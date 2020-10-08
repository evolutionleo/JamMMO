const { isUndefined, random } = require("underscore");
const lobbies = require("./lobbies");

// const lobbies = require("./lobbies");
module.exports.createLobby = function(map) {
    if (isUndefined(map)) {
        map = 'Room1';
    }
    var lobby_inst = new require('./lobby.js');
    var lobby = new lobby_inst;

    lobby.map = map;

    lobbies.push(lobby);
    // lobby.play();

    // console.log(JSON.stringify(lobbies));
    // console.log(lobby);

    // return lobbies.length - 1;
    return lobby;
}

module.exports.lobby_status = {
    "FREE": 0,
    "WAITING": 1,
    "PLAY": 2,
    0: "FREE",
    1: "WAITING",
    2: "PLAY"
}

module.exports.findFreeLobby = function() {
    for(var i = 0; i < lobbies.length; i++) { // Search for waiting lobbies first
        var lobby = lobbies[i];
        lobby.updateStatus();

        if (lobby.status === "WAITING") {
            return i;
        }
    }

    var freeLobbies = [];

    for(var i = 0; i < lobbies.length; i++) { // then search for empty lobbies
        var lobby = lobbies[i];
        lobby.updateStatus();
        if (lobby.status === "FREE") {
            // return i;
            freeLobbies.push(i);
        }
    }

    if (freeLobbies.length > 0) {
        var i = random(freeLobbies.length-1);
        return freeLobbies[i];
    }
    else {
        return undefined;
    }
}