function get_inst_id() {
	static _id = -1
	
	if (!variable_global_exists("team"))
		global.team = ""
	
	_id++
	var obj_name = object_get_name(object_index)
	
	return global.team+obj_name+string(_id)
}

function send_hello() {
	//var buff = buffer_create(1, buffer_grow, 1)
	//buffer_write(buff, buffer_s8, HELLO)
	//buffer_write(buff, buffer_string, "Server-side sucks")
	
	//network_write(buff)
	var data = {cmd: "HELLO", str: "Server-side sucks"}
	var buff = snap_to_messagepack(data)
	
	//show_message(snap_from_messagepack(buff))
	
	network_write(buff)
}

function send_player() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, PLAYER)
	buffer_write(buff, buffer_string, inst_id)
	buffer_write(buff, buffer_s16, x)
	buffer_write(buff, buffer_s16, y)
	buffer_write(buff, buffer_s16, spd.x)
	buffer_write(buff, buffer_s16, spd.y)
	buffer_write(buff, buffer_s16, round(mdir))
	buffer_write(buff, buffer_s16, hp)
	
	network_write(buff)
}
function send_bullet() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, BULLET)
	buffer_write(buff, buffer_string, inst_id)
	buffer_write(buff, buffer_s16, x)
	buffer_write(buff, buffer_s16, y)
	buffer_write(buff, buffer_s16, spd.x)
	buffer_write(buff, buffer_s16, spd.y)
	buffer_write(buff, buffer_s16, image_angle)
	buffer_write(buff, buffer_s16, damage)
	
	network_write(buff)
}

function send_hit(p) {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, HIT)
	buffer_write(buff, buffer_string, inst_id)
	buffer_write(buff, buffer_string, p)
	buffer_write(buff, buffer_s16, damage)
	
	network_write(buff)
}

function send_laser() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, LASER)
	buffer_write(buff, buffer_string, inst_id)
	buffer_write(buff, buffer_s16, x)
	buffer_write(buff, buffer_s16, y)
	buffer_write(buff, buffer_s16, spd.x)
	buffer_write(buff, buffer_s16, spd.y)
	buffer_write(buff, buffer_s16, image_angle)
	buffer_write(buff, buffer_s16, damage)
	
	network_write(buff)
}

function send_find_game() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, FIND_GAME)
	
	network_write(buff)
}

function send_defeat() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, GAME_END)
	buffer_write(buff, buffer_string, global.team)
	buffer_write(buff, buffer_string, "lose")
	
	network_write(buff)
}

function send_win() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, GAME_END)
	buffer_write(buff, buffer_string, global.team)
	buffer_write(buff, buffer_string, "win")
	
	network_write(buff)
}


function send_leave() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, LEAVING)
	
	network_write(buff)
	//send_defeat()
}

function send_request_online() {
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, ONLINE)
	
	network_write(buff)
}

function send_pickup(type) {
	trace("Sent pickup request")
	
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, WEAPON_PICKUP)
	//buffer_write(buff, buffer_string, team)
	buffer_write(buff, buffer_string, type)
	buffer_write(buff, buffer_s16, x)
	buffer_write(buff, buffer_s16, y)
	
	network_write(buff)
}

function send_weapon_spawn() {
	trace("Sent spawn request")

	if (!instance_exists(oWeaponSpot)) {
		show_message_async("Unable to spawn a weapon")
		return -1
	}
	
	var n = irandom(instance_number(oWeaponSpot)-1)
	var spawn = instance_find(oWeaponSpot, n)
	
	//var type = choose("pistol", "shotgun", "riffle", "railgun")
	var type = choose("railgun")
	
	
	
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_write(buff, buffer_s8, WEAPON_SPAWN)
	buffer_write(buff, buffer_string, type)
	buffer_write(buff, buffer_s16, spawn.x)
	buffer_write(buff, buffer_s16, spawn.y)
	
	network_write(buff)
}