const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('api', {
  // We can expose functions to the renderer process here.
  // For example: send: (channel, data) => ipcRenderer.send(channel, data)
});
