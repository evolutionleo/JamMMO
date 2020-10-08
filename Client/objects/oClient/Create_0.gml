/// @desc
socket = network_create_socket(network_socket_tcp)

text = ""
lobby_found = false

players_online = 0

// Production
//network_connect_raw(socket, "62.113.112.109", 1337)
// Debug
//network_connect_raw(socket, "127.0.0.1", 1338)
// Variable


//global.playing = false
//global.local_index = -1

global.ip = "127.0.0.1"
//global.ip = "62.113.112.109"
global.port = "1337"
network_connect_raw(socket, global.ip, real(global.port))


send_hello()