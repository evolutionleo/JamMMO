/// @desc

shoot_delay = 0

reload = function() {
	reloading = true
	alarm[1] = reload_time
}

shoot = function() {
	if(reloading) or (alarm[0] > 0) {
		return -1;
	}
	else if (bullets <= 0) {
		reload();
		return -1
	}
	
	var lay_id = layer_get_id("Bullets")
	
	if lay_id == -1
		lay_id = layer_create(-10, "Bullets")
	
	repeat(bullet_count) {
		var _dir = dir + random_range(-rand_dir, rand_dir)
		var _spd = bul_spd + random_range(-rand_spd, rand_spd)
		
		var len = abs(image_xscale) * sprite_get_width(sprite_index) / 2
		var xx = x + lengthdir_x(len, _dir)
		var yy = y + lengthdir_y(len, _dir)
		
		if (laser) {
			var bul = instance_create_layer(xx, yy, lay_id, oLaser)
		}
		else {
			var bul = instance_create_layer(xx, yy, lay_id, oBullet)
		}
		bul.dir = _dir
		bul.image_angle = _dir
		bul.spd.x = lengthdir_x(_spd, _dir)
		bul.spd.y = lengthdir_y(_spd, _dir)
		bul.damage = damage
		bul.team = my_player.team
		
		//shoot_particle(xx, yy, _dir)
	}
	
	bullets -= 1
	alarm[0] = delay_time
}

Input.addBind("shoot", mb_left, "mouse")

inheritGun = function(type) {
	self.type = type
	
	var struct = variable_struct_get(GunLibrary, type)
	
	var keys = variable_struct_get_names(struct)
	for(var i = 0; i < array_length(keys); ++i) {
		var key = keys[i]
		var value = variable_struct_get(struct, key)
		
		variable_instance_set(id, key, value)
	}
	
	max_bullets = bullets
}

inheritGun("pistol")
//inheritGun("shotgun")


reloading = false