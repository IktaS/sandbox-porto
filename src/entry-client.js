import '@xterm/xterm/css/xterm.css';
import { Terminal } from '@xterm/xterm';
import { FitAddon } from '@xterm/addon-fit';
import { ImageAddon } from '@xterm/addon-image';
import { WebLinksAddon } from '@xterm/addon-web-links';

const socket = io();
var term = new Terminal();
const fit = new FitAddon();
const image = new ImageAddon();
const weblink = new WebLinksAddon();
term.loadAddon(fit);
term.loadAddon(image);
term.loadAddon(weblink);
term.open(document.getElementById('terminal'));
fit.fit();

socket.on("terminal.incomingData", (data) => {
    term.write(data);
});

term.onData((data) => {
    socket.emit("terminal.keystroke", data);
});