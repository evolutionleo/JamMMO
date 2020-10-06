/// @desc

var p = instance_place(x, y, oPlayer)
if (p) {
	if (!p.remote) {
		//p.my_gun.inheritGun(self.type)
		send_pickup(self.type)
		instance_destroy()
	}
}


scale += scale_spd
if (scale >= max_scale) or scale <= base_scale
	scale_spd *= -1


flip_pos += flip_spd

if (flip_pos >= 1) or (flip_pos <= 0)
	flip_spd *= -1

flip_pos = clamp(flip_pos, 0, 1)

var channel = animcurve_get_channel(cvFlipping, "curve1")
var flip = animcurve_channel_evaluate(channel, flip_pos)

image_xscale = scale * flip
image_yscale = scale