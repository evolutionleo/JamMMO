const fs = require('fs');
const net = require('net');
const path = require('path');

const port = 1337;

require('./clients.js'); // clients = []
require('./packetmodels.js'); // PacketModels = {...}
require('./packet.js'); // packet = {parse(), build() }
require('./lobbies.js'); // lobbies = []
require('./commands.js'); // cmd = {...}
require('./sessionid.js'); // sessionid = 0
require('./username.js'); // getUsername()

const {createLobby, findFreeLobby, lobby_status} = require('./createlobby.js'); // createLobby = () => {}
// const lobby = require('./lobby.js');


// Create a bunch of lobbies
for(var i = 0; i < 5; ++i) {
    createLobby('rLevel4');
    // createLobby('rLevel1');
    createLobby('rLevel2');
    createLobby('Room1');
    createLobby('rLevel3');
}

console.log(lobbies);
// console.log(JSON.stringify(lobbies));

const server = net.createServer(function(socket) {
    console.log("Socket connected!");

    var client_inst = new require('./client.js');
    var c = new client_inst;

    c.username = getUsername();
    c.socket = socket;
    c.initiate();

    console.log('Assigned username: '+c.username);

    clients.push(c);

    socket.on('error', c.error);
    socket.on('close', c.end);
    socket.on('data', c.data);
    // socket.on('error', (err) => {
    //     console.log(`Error! ${err}`); // Don't crash
    // });
    
    // socket.on('data', (data) => {
    //     console.log('Received data: ');
    //     console.log(data); // weird hex bytes
    //     packet.parse(socket, data); // Do stuff
    // });
});

server.listen(port);
console.log("Server running on port " + port);