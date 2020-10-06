/// @desc

remote = false
looped = false
//damage = 10

inst_id = get_inst_id()

image_xscale = 4
image_yscale = 4

spd = vec2(0, 0)


setTimeout(self, function() {
	if (!remote)
		send_laser()
}, 1)

collision = function() {
	var _laser = vec2(x, y)
	var _step = spd.normalized().multiplied(vec2(2, 2))
	
	var hitByAttack = new Array()
	
	while(true) {
		_laser.add(_step)
		
		
		var part = instance_create_layer(_laser.x, _laser.y, layer, oLaserParticle)
		part.image_xscale = image_xscale
		part.image_yscale = image_yscale
		part.image_angle = image_angle
		part.team = team
		
		if (position_meeting(_laser.x, _laser.y, oPlayer)) {
			var p = instance_position(_laser.x, _laser.y, oPlayer)
			if (!remote and p.remote and !hitByAttack.exists(p)) { // other's bullets hit us
				send_hit(p.inst_id)
				instance_destroy()
				hitByAttack.push(p)
			}
		}
		
		if (position_meeting(_laser.x, _laser.y, oWall)) {
			instance_destroy()
			break
		}
		
		if (_laser.x < 0 or _laser.x > room_width or _laser.y < 0 or _laser.y > room_height)
		{
			if !looped {
				looped = true
				_laser = wrap_position(_laser)
			}
			else {
				instance_destroy()
				break
			}
		}
	}
}