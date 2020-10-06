/// @desc

//if !instance_exists(oClient) {
//	instance_create_layer(0, 0, "Managers", oClient)
//}

with(oClient) {
	if (!lobby_found)
		send_find_game()
}