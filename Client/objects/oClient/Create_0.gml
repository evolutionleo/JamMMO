/// @desc
socket = network_create_socket(network_socket_tcp)

text = ""
lobby_found = false

players_online = 0

// NO I WON'T let you play on my server with custom game build

// Production
//network_connect_raw(socket, "xxxxx", 1337)
// Debug
//network_connect_raw(socket, "127.0.0.1", 1338)
// Variable


//global.playing = false
//global.local_index = -1

global.ip = "127.0.0.1"
//global.ip = "xxxxxxx"
global.port = "1337"
network_connect_raw(socket, global.ip, real(global.port))


send_hello()