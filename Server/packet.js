var zeroBuffer = Buffer.alloc(1, '00', 'hex');
const { isUndefined } = require('underscore');
const {findFreeLobby} = require('./createlobby.js');
// const lobby = require('./lobby.js');

// console.log(typeof clients);

module.exports = packet = {
    // params = array of json's
    build: function(params) {
        var packSize = 0;
        var packParts = []; // Array of buffers

        params.forEach(function(param) {

            if(Array.isArray(param)) {
                var size = param[0]/8;
                buffer = Buffer.alloc(size);
                buffer.writeIntLE(param[1], 0, size);
            }
            else if(typeof param === 'string') {
                buffer = Buffer.alloc(param.length, param, 'utf-8');
                buffer = Buffer.concat([buffer, zeroBuffer], buffer.length + 1);
                // console.log('Packing String: ' + param);
            }
            else if(typeof param === 'boolean') {
                buffer = Buffer.alloc(1);
                buffer.writeUInt8(param);
            }
            else if(typeof param === 'number') {
                buffer = Buffer.alloc(2);
                buffer.writeInt16LE(param);
                // console.log('Packing Number: ' + param);
            }
            else {
                console.log('WARNING: Unknown data type in packet builder!');
            }

            packSize += buffer.length;
            packParts.push(buffer);
        });

        var dataBuffer = Buffer.concat(packParts, packSize);

        var sizeBuffer = Buffer.alloc(1, dataBuffer.length);


        var finalPack = Buffer.concat([sizeBuffer, dataBuffer], dataBuffer.length + sizeBuffer.length);

        // console.log("Writing pack: " + finalPack.toString());

        return finalPack;
    },

    parse: function(c, data) {
        var idx = 0;
        while(idx < data.length) {

            var packSize = data.readUInt8(idx);
            var extractedPack = Buffer.alloc(packSize);
            data.copy(extractedPack, 0, idx, idx+packSize);


            this.interpret(c, extractedPack);

            idx += packSize;
        }
    },

    interpret: function(c, datapack) {
        let header = PacketModels.header.parse(datapack);

        // console.log('Recieved packet cmd = ' + cmd[header.command]);

        switch(cmd[header.command]) {
            case "HELLO":
                var data = PacketModels.hello.parse(datapack);
                console.log("Kappa!!!");
                console.log(data.kappa);
                
                c.socket.write(packet.build([[8, cmd["HELLO"]], "No Fuck You!"]));
                c.socket.write(packet.build([[8, cmd["HI"]], "No Fuck You 2!"]));
                break;
            case "PLAYER":
                var data = PacketModels.player.parse(datapack);

                var pack = [
                    [8, cmd['PLAYER']],
                    data.id,
                    data.x,
                    data.y,
                    data.hsp,
                    data.vsp,
                    data.rotation,
                    data.hp
                ]

                // var lobby = lobbies[c.lobbyid];
                c.broadcastLobby(packet.build(pack));
                break;
            case "BULLET":
                var data = PacketModels.bullet.parse(datapack);

                var pack = [
                    [8, cmd['BULLET']],
                    data.id,
                    data.x,
                    data.y,
                    data.hsp,
                    data.vsp,
                    data.rotation,
                    data.damage
                ]

                // var lobby = lobbies[c.lobbyid];
                c.broadcastLobby(packet.build(pack));
                break;
            case "LASER":
                var data = PacketModels.laser.parse(datapack);

                var pack = [
                    [8, cmd['LASER']],
                    data.id,
                    data.x,
                    data.y,
                    data.hsp,
                    data.vsp,
                    data.rotation,
                    data.damage
                ]

                // var lobby = lobbies[c.lobbyid];
                c.broadcastLobby(packet.build(pack));

                console.log('laser: ');
                console.log(data);
                break;
            case "HIT":
                var data = PacketModels.hit.parse(datapack);
                var pack = [
                    [8, cmd["HIT"]],
                    data.id,
                    data.player,
                    data.damage
                ]

                c.broadcastLobby(packet.build(pack), true);
                break;
            case "FIND_GAME":
                var data = PacketModels.findgame.parse(datapack);
                
                var lobbyid = findFreeLobby();
                if (lobbyid === undefined) {
                    c.socket.write(packet.build([[8, cmd["LOBBY_FULL"] ], "All lobbies are full!"]));
                }
                else {
                    var pack = [
                        [8, cmd["FOUND_LOBBY"]],
                        "Found a lobby!"
                    ]
                    
                    c.socket.write(packet.build(pack));

                    c.enterLobby(lobbyid);

                    lobby = lobbies[lobbyid];
                    
                }
                break;
            case "GAME_END":
                var data = PacketModels.game_end.parse(datapack);
                var team = data.team;
                var status = data.status;
                var winner = "";

                if (status == "win") {
                    winner = team;
                }
                else if (status == "lose") {
                    if (team == "pink")
                        winner = "cyan";
                    else if (team == "cyan")
                        winner = "pink";
                }
                else {
                    throw "Unknown gameover status";
                }

                // var lobby = lobbies[c.lobbyid];
                // lobby.players.forEach((_c) => {
                //     var str = winner + " player wins!";
                //     var pack = [
                //         [8, cmd["GAME_END"]],
                //         str
                //     ];

                //     _c.socket.write(packet.build(pack));
                //     _c.quitLobby(_c.lobbyid);
                // })
                var str = winner + " player wins!";
                c.broadcastLobby(packet.build([[8, cmd['GAME_END']], str]), true);
                
                if (!isUndefined(c.lobbyid)) {
                    var lobby = lobbies[c.lobbyid];
                    lobby.end(); // this also kicks players out
                }
                break;
            case "ONLINE": // fetch the amount of players online
                var pack = [
                    [8, cmd['ONLINE']],
                    clients.length
                ]
                c.socket.write(packet.build(pack));
                break;
            case "LEAVING":
                console.log('A guy\'s leaving');
                c.leave();
                break;
            case "WEAPON_PICKUP":
                var data = PacketModels.weapon_pickup.parse(datapack);
                var pack = [
                    [8, cmd['WEAPON_PICKUP']],
                    c.team,
                    data.type,
                    data.x,
                    data.y
                ]

                c.broadcastLobby(packet.build(pack), true);
                break;
            case "WEAPON_SPAWN":
                var data = PacketModels.weapon_spawn.parse(datapack);
                var pack = [
                    [8, cmd['WEAPON_SPAWN']],
                    data.type,
                    data.x,
                    data.y
                ]

                c.broadcastLobby(packet.build(pack), true);
                break;
        }
    }
};