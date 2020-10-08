var Parser = require('binary-parser').Parser;
var stringOptions = {length: 99, zeroTerminated: true};

module.exports = PacketModels = {
    header: new Parser().skip(1)
        .int8("command", stringOptions),
    
    hello: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("kappa", stringOptions),
    
    findgame: new Parser().skip(1)
        .int8("command", stringOptions),
    
    player: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("id", stringOptions)
        .int16le("x", stringOptions)
        .int16le("y", stringOptions)
        .int16le("hsp", stringOptions)
        .int16le("vsp", stringOptions)
        .int16le("rotation", stringOptions)
        .int16le("hp", stringOptions),
    
    bullet: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("id", stringOptions)
        .int16le("x", stringOptions)
        .int16le("y", stringOptions)
        .int16le("hsp", stringOptions)
        .int16le("vsp", stringOptions)
        .int16le("rotation", stringOptions)
        .int16le("damage", stringOptions),
    
    laser: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("id", stringOptions)
        .int16le("x", stringOptions)
        .int16le("y", stringOptions)
        .int16le("hsp", stringOptions)
        .int16le("vsp", stringOptions)
        .int16le("rotation", stringOptions),
    
    hit: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("id", stringOptions)
        .string("player", stringOptions)
        .int16le("damage", stringOptions),
    
    game_end: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("team", stringOptions)
        .string("status", stringOptions),
    
    weapon_pickup: new Parser().skip(1)
        .int8("command", stringOptions)
        //.string("team", stringOptions)
        .string("type", stringOptions)
        .int16le("x", stringOptions)
        .int16le("y", stringOptions),
    
    weapon_spawn: new Parser().skip(1)
        .int8("command", stringOptions)
        .string("type", stringOptions)
        .int16le("x", stringOptions)
        .int16le("y", stringOptions)
}