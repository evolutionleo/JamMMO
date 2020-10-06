/// @desc

remote = false
looped = false
//damage = 10

inst_id = get_inst_id()

image_xscale = 4
image_yscale = 4

spd = vec2(0, 0)
prev_spd = vec2(0, 0)

collision = function() {
	x += spd.x
	y += spd.y
		
		
	if place_meeting(x, y, oPlayer) {
		var p = instance_place(x, y, oPlayer)
		if (!remote and p.remote) { // other's bullets hit us
			send_hit(p.inst_id)
			instance_destroy()
		}
	}
	if place_meeting(x, y, oWall) {
		instance_destroy()
	}
	if (x < 0 or x > room_width or y < 0 or y > room_height) {
		if (looped)
			instance_destroy()
		else {
			looped = true
			// Wrap
			var pos = wrap_position(vec2(x, y))
			x = pos.x
			y = pos.y
		}
	}
}