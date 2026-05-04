# AGENTS.md

## What This Is

Web-based Linux terminal sandbox. Browser connects via Socket.IO to an Express server that spawns PTY sessions inside a Docker container (`node-pty` → `docker exec`).

## Architecture

- **Server**: `server.js` - Express + Socket.IO, Vite middleware in dev, static serve in prod
- **Client**: `src/entry-client.js` - xterm.js with fit, image (sixel/iip), web-links, unicode addons
- **SSR**: `src/entry-server.js` - minimal, returns empty HTML (SPA-style)
- **Sandbox**: Alpine Linux container via `Dockerfile`, entrypoint is `tail -f /dev/null`
- **PTY spawn**: `docker exec -it -u visitor sandbox-porto bash` (see `spawnShell()` in server.js)

## Key Commands

```bash
# Development
npm run dev              # Vite dev server + Express on :5173

# Production build
npm run build            # Build client + server to dist/
npm run preview          # Test production build locally

# Deploy
make deploy              # Build and run Docker container (requires sandbox-porto image)
```

## Docker Compose

`docker-compose.yml` runs the main app and wud (update watcher):
- `sandbox-porto` - Main terminal sandbox app
- `wud` - Container update watcher

Requires `WUD_GITHUB_TOKEN` env var for private registry access.

**Important**: Mounts Docker socket (`/var/run/docker.sock`) to spawn PTY sessions via `docker exec`.

## CV Generation (Typst)

```bash
# Compile CV to HTML (used in Dockerfile)
make render-cv-html      # Outputs cv.html from scripts/cv.typ

# Generate sixel image for terminal
make render-sixel        # Creates public/profile.sixel from profile.jpg
```

CV template: `scripts/basic-typst-resume-template-html/`

## CI/CD

`.github/workflows/deploy.yml` builds and pushes `ghcr.io/iktas/sandbox-porto:latest` on push to `master`.

## Important Details

- **Package manager**: Uses `bun.lock` (Bun), but npm scripts work
- **Mobile detection**: `socket.handshake.headers.mobile` set by client based on viewport width
- **Container constraints**: Deployed with `--network none --cap-drop NET_RAW --cap-drop NET_ADMIN -m 512m --cpus=2`
- **User in container**: `visitor` with oh-my-bash, fastfetch on login
- **Terminal features**: Sixel and iTerm IIP image support enabled, 25MB size limits
- **History persistence**: `/home/visitor/.bash_history` is writable (chmod 777), rest of homedir is read-only

## File Structure

```
server.js              # Express + Socket.IO + PTY spawn logic
src/
  entry-client.js      # xterm.js terminal setup
  entry-server.js      # SSR render function (minimal)
scripts/
  cv.typ               # CV source (Typst)
  setup_user.sh        # Creates visitor user in container
  .bashrc              # Shell config with fastfetch + lynx read() function
  config.jsonc         # fastfetch config
public/                # Static assets (profile.jpg, profile.sixel, etc.)
```
