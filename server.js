import fs from 'node:fs/promises'
import express from 'express'
import { createServer } from 'node:http';
import { Server } from 'socket.io';
import * as pty from 'node-pty';

// Constants
const isProduction = process.env.NODE_ENV === 'production'
const port = process.env.PORT || 5173
const base = process.env.BASE || '/'

// Cached production assets
const templateHtml = isProduction
  ? await fs.readFile('./dist/client/index.html', 'utf-8')
  : ''

// Create http server
const app = express()
const server = createServer(app);
const io = new Server(server);

// Add Vite or respective production middlewares
/** @type {import('vite').ViteDevServer | undefined} */
let vite
if (!isProduction) {
  const { createServer } = await import('vite')
  vite = await createServer({
    server: { middlewareMode: true },
    appType: 'custom',
    base,
  })
  app.use(vite.middlewares)
} else {
  const compression = (await import('compression')).default
  const sirv = (await import('sirv')).default
  app.use(compression())
  app.use(base, sirv('./dist/client', { extensions: [] }))
}

// Serve HTML
app.use('*all', async (req, res) => {
  try {
    const url = req.originalUrl.replace(base, '')

    /** @type {string} */
    let template
    /** @type {import('./src/entry-server.js').render} */
    let render
    if (!isProduction) {
      // Always read fresh template in development
      template = await fs.readFile('./index.html', 'utf-8')
      template = await vite.transformIndexHtml(url, template)
      render = (await vite.ssrLoadModule('/src/entry-server.js')).render
    } else {
      template = templateHtml
      render = (await import('./dist/server/entry-server.js')).render
    }

    const rendered = await render(url)

    const html = template
      .replace(`<!--app-head-->`, rendered.head ?? '')
      .replace(`<!--app-html-->`, rendered.html ?? '')

    res.status(200).set({ 'Content-Type': 'text/html' }).send(html)
  } catch (e) {
    vite?.ssrFixStacktrace(e)
    console.log(e.stack)
    res.status(500).end(e.stack)
  }
})

const spawnShell = () => {
  return pty.spawn("docker", ["exec", "-it", "-u", "visitor", "-w", "/home/visitor", "sandbox-porto", "bash"], {
    name: "xterm-color",
    cols: 80,
    rows: 30,
  });
};

io.on("connection", (socket) => {
  let ptyProcess = spawnShell();

  ptyProcess.onData((data) => {
    socket.emit("terminal.incomingData", data);
  });

  ptyProcess.onExit(() => {
    socket.disconnect()
  })

  socket.on("terminal.keystroke", (data) => {
    ptyProcess.write(data);
  });

  socket.on('disconnect', () => {
    ptyProcess.kill();
  });
});

// Start http server
server.listen(port, () => {
  console.log(`Server started at http://localhost:${port}`)
})
