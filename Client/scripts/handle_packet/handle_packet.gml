#macro HELLO 1
#macro PLAYER 2 // pos and stuff
#macro FIND_GAME 3
#macro LEAVING 4
#macro LOBBY_FULL 5
#macro BULLET 7
#macro HIT 8
#macro ONLINE 9
#macro FOUND_LOBBY 10
#macro GAME_END 11
#macro WEAPON_SPAWN 12
#macro WEAPON_PICKUP 13
#macro LASER 14

#macro Hi 100

///@function	handle_packet(buff)
///@arg			{buffer} buff
function handle_packet(buff) {
	//var cmd = buffer_read(buff, buffer_s8)
	//trace("##############")
	//trace("Recieved command. id: %", cmd)
	var data = snap_from_messagepack(buff)
	//var data = snap_from_messagepack(_data.data)
	
	show_message(data)
	
	switch(data.cmd) {
		case "HELLO":
			//var time = buffer_read(buff, buffer_string)
			var time = data.str
			
			trace("Server sends his regards. Server time: %", time)
			
			alarm[1] = 1
			break
		case PLAYER:
			if (room == rMenu or room == rInit or room == rCutscene) {
				exit
			}
			
			//var inst_id = buffer_read(buff, buffer_string)
			//var _x		= buffer_read(buff, buffer_s16)
			//var _y		= buffer_read(buff, buffer_s16)
			//var hsp		= buffer_read(buff, buffer_s16)
			//var vsp		= buffer_read(buff, buffer_s16)
			//var dir		= buffer_read(buff, buffer_s16)
			//var hp		= buffer_read(buff, buffer_s16)
			var inst_id = data.inst_id
			var _x = data.x
			var _y = data.y
			var hsp = data.spd.x
			var vsp = data.spd.y
			var dir = data.dir
			var hp = data.hp
			
			
			var found = noone
			
			var type = -1
			type = oPlayer
			
			with(type) {
				if self.inst_id == inst_id {
					found = id
				}
			}
			
			if !found {
				found = instance_create_layer(0, 0, "Instances", type)
				found.inst_id = inst_id
				found.remote = true
			}
			
			found.x		= _x
			found.y		= _y
			found.spd.x	= hsp
			found.spd.y	= vsp
			found.mdir	= dir
			found.hp	= hp
			found.image_xscale = 2
			found.image_yscale = 2
			
			break
		case BULLET:
			if (room == rMenu or room == rInit or room == rCutscene) {
				exit
			}
			
			var inst_id = buffer_read(buff, buffer_string)
			var _x		= buffer_read(buff, buffer_s16)
			var _y		= buffer_read(buff, buffer_s16)
			var hsp		= buffer_read(buff, buffer_s16)
			var vsp		= buffer_read(buff, buffer_s16)
			var dir		= buffer_read(buff, buffer_s16)
			var damage	= buffer_read(buff, buffer_s16)
			
			var found = noone
			
			var type = -1
			type = oBullet
			
			with(type) {
				if self.inst_id == inst_id {
					found = id
				}
			}
			
			var lay_id = layer_get_id("Bullets")
	
			if lay_id == -1
				lay_id = layer_create(-10, "Bullets")
			
			if !found {
				found = instance_create_layer(0, 0, lay_id, type)
				found.inst_id = inst_id
				found.remote = true
			}
			
			found.x		= _x
			found.y		= _y
			found.spd.x	= hsp
			found.spd.y	= vsp
			found.dir	= dir
			found.image_angle  = dir
			found.damage = damage
			break
		case LASER:
			var inst_id = buffer_read(buff, buffer_string)
			var _x		= buffer_read(buff, buffer_s16)
			var _y		= buffer_read(buff, buffer_s16)
			var hsp		= buffer_read(buff, buffer_s16)
			var vsp		= buffer_read(buff, buffer_s16)
			var dir		= buffer_read(buff, buffer_s16)
			var damage	= buffer_read(buff, buffer_s16)
			
			
			var found = noone
			
			var type = -1
			type = oLaser
			
			with(type) {
				if self.inst_id == inst_id {
					found = id
				}
			}
			
			var lay_id = layer_get_id("Bullets")
	
			if lay_id == -1
				lay_id = layer_create(-10, "Bullets")
			
			if !found {
				found = instance_create_layer(0, 0, lay_id, type)
				found.inst_id = inst_id
				found.remote = true
			}
			
			found.x		= _x
			found.y		= _y
			found.spd.x	= hsp
			found.spd.y	= vsp
			found.dir	= dir
			found.image_angle  = dir
			found.damage = damage
			
			trace("laser")
			
			break
		case HIT:
			if (room == rMenu or room == rInit or room == rCutscene) {
				exit
			}
			
			var inst_id = buffer_read(buff, buffer_string)
			var p_id = buffer_read(buff, buffer_string)
			var damage = buffer_read(buff, buffer_s16)
			
			with(oBullet) {
				if inst_id == self.inst_id {
					instance_destroy()
				}
			}
			
			with(oPlayer) {
				if p_id == self.inst_id {
					self.hp -= damage
				}
			}
			
			trace("hit")
			break
		case FIND_GAME: // entering a game!
			show_debug_message("Starting!!!")
			var team = buffer_read(buff, buffer_string)
			var map_name = buffer_read(buff, buffer_string)
			var map = asset_get_index(map_name)
			
			trace("Team: "+team+". Map: "+map_name)
			
			global.team = team
			
			room_goto(map)
			
			setTimeout(self, function() {
				#region Spawn the player
				
				var n = (global.team == "pink") ? 0 : 1
				var spawn = instance_find(oSpawnPoint, n)
			
				var player = instance_create_layer(spawn.x, spawn.y, "Instances", oPlayer)
				player.image_xscale = 2
				player.image_yscale = 2
				
				#endregion
				#region Spawn the gun pickups
				
				if (global.team == "pink") {
					alarm[2] = 1 * room_speed // 5
				}
				else if (global.team == "cyan") {
					alarm[2] = 2 * room_speed // spawn_weapon()
					// 10
				}
				
				#endregion
			}, 1)
			
			break
		case FOUND_LOBBY:
			var str = buffer_read(buff, buffer_string)
			oClient.text = str
			
			trace(str)
			
			lobby_found = true
			break
		case LOBBY_FULL:
			var str = buffer_read(buff, buffer_string)
			oClient.text = str
			//show_message_async(str)
			
			trace(str)
			
			lobby_found = false
			break
		case GAME_END:
			var str = buffer_read(buff, buffer_string)
			oClient.text = str
			//show_message_async(str) // placeholder
			
			room_goto(rMenu)
			
			lobby_found = false
			
			break
		case Hi:
			show_debug_message("Second pack received! "+buffer_read(buff, buffer_string))
			
			break
		case ONLINE:
			var online = buffer_read(buff, buffer_s16)
			
			oClient.players_online = online
			
			break
		case WEAPON_PICKUP:
			var team = buffer_read(buff, buffer_string)
			var type = buffer_read(buff, buffer_string)
			//var inst_id = buffer_read(buff, buffer_string)
			var _x = buffer_read(buff, buffer_s16)
			var _y = buffer_read(buff, buffer_s16)
			
			
			with(instance_position(_x, _y, oWeaponPickup)) {
				instance_destroy()
			}
			
			with(oPlayer) {
				if (self.team == team) {
					my_gun.inheritGun(type)
				}
			}
			
			trace("weapon pickup")
			break
		case WEAPON_SPAWN:
			var type = buffer_read(buff, buffer_string)
			var _x = buffer_read(buff, buffer_s16)
			var _y = buffer_read(buff, buffer_s16)
			
			spawn_weapon(type, _x, _y)
			
			
			trace("weapon spawn")
			break
	}
}


function define_team() {
	#region Team

	if global.team == "cyan" {
		if remote
			team = "pink"
		else 
			team = "cyan"
	}
	else if global.team == "pink" {
		if remote
			team = "cyan"
		else 
			team = "pink"
	}

	#endregion
}