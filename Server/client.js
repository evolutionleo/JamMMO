// Client handled
var now = require('performance-now');
const { isUndefined } = require('underscore');
var _ = require('underscore');
// const lobbies = require('./lobbies');

module.exports = function() {
    var client = this;
    this.username = "";
    this.lobbyid = undefined;
    this.socket = undefined;
    this.active = false;
    this.team = undefined;

    this.enterLobby = function(lobbyid) {
        var lobby = lobbies[lobbyid];
        client.lobbyid = lobbyid;

        lobby.players.push(client);
        lobby.updateStatus();
        // console.log(lobby);

        client.active = true;
        // console.log(JSON.stringify(lobbies));
    }

    this.quitLobby = function() {
        var lobby = lobbies[client.lobbyid];
        let idx = lobby.players.findIndex((p) => { return p.username === client.username });
        lobby.players.splice(idx, 1);

        lobby.updateStatus();
        
        if (lobby.status === 'WAITING') {
            lobby.end();
        }

        client.lobbyid = undefined;
        client.active = false;
    }

    this.broadcastLobby = function(packData, includeSelf) {
        if (isUndefined(includeSelf))
            includeSelf = false;
        
        if (!isUndefined(client.lobbyid)) {
            lobbies[client.lobbyid].players.forEach(function(otherClient) {
                if (otherClient.username != client.username || includeSelf) {
                    otherClient.socket.write(packData);
                }
            })
        }
    };

    this.initiate = function() {

        // Send the greetings
        // client.socket.write(packet.build([[8, cmd["HELLO"]], now().toString()]));
        this.active = true;
        // console.log("Client initiated.");
    };
 
    this.data = function(data) {
        //console.log("Socket data arrived: " + data.toString() + ".");
        packet.parse(client, data);
    };

    this.error = function(err) {
        console.log("Socket error: " + err.toString() + ".");
    };

    this.leave = function() {
        if (!client.active)
            return;

        idx = clients.findIndex((_c) => (_c.username === client.username));
        clients.splice(idx, 1);
        if (!isUndefined(client.lobbyid)) {
            var lobby = lobbies[client.lobbyid];
            var str = client.team + ' disconnected.';
            lobby.players.forEach((_c) => {
                _c.socket.write(packet.build([[8, cmd['GAME_END']], str]));
            });
            // console.log('DISCONNECT!!!');
            
            client.quitLobby();
        }
        client.active = false;
    }

    this.end = function() {
        // console.log("Ending socket...");
        client.leave();
        //client.user.close();
        // console.log("Socket ended.");
    };
}