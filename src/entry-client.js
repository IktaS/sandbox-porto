import "@xterm/xterm/css/xterm.css";
import { Terminal } from "@xterm/xterm";
import { FitAddon } from "@xterm/addon-fit";
import { ImageAddon, IImageAddonOptions } from "@xterm/addon-image";
import { WebLinksAddon } from "@xterm/addon-web-links";
import { Unicode11Addon } from "@xterm/addon-unicode11";

const customSettings = {
  enableSizeReports: true, // whether to enable CSI t reports (see below)
  pixelLimit: 16777216, // max. pixel size of a single image
  sixelSupport: true, // enable sixel support
  sixelScrolling: true, // whether to scroll on image output
  sixelPaletteLimit: 256, // initial sixel palette size
  sixelSizeLimit: 25000000, // size limit of a single sixel sequence
  storageLimit: 128, // FIFO storage limit in MB
  showPlaceholder: true, // whether to show a placeholder for evicted images
  iipSupport: true, // enable iTerm IIP support
  iipSizeLimit: 20000000, // size limit of a single IIP sequence
};

const socket = io({
  extraHeaders: {
    mobile: document.documentElement.clientWidth < 900 ? true : false,
  },
});
var term = new Terminal({
  allowProposedApi: true,
  theme: {
    background: "#5e5c64",
  },
});
const fit = new FitAddon();
const image = new ImageAddon(customSettings);
const weblink = new WebLinksAddon();
const unicode = new Unicode11Addon();
term.loadAddon(fit);
term.loadAddon(image);
term.loadAddon(weblink);
term.loadAddon(unicode);
term.unicode.activeVersion = "11";
const terminalContainer = document.getElementById("terminal");
term.open(terminalContainer);
term.onResize((data) => {
  socket.emit("terminal.resize", data);
});
fit.fit();

socket.on("terminal.incomingData", (data) => {
  term.write(data);
});

term.onData((data) => {
  socket.emit("terminal.keystroke", data);
});

const resizeObserver = new ResizeObserver((entries) => {
  fit.fit();
});
resizeObserver.observe(terminalContainer);
