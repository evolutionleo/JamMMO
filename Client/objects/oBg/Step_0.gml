/// @desc

alpha += alpha_spd

if alpha > 1 or alpha < 0
	alpha_spd *= -1

var lay_id = layer_get_id("Background1")
var back_id = layer_background_get_id(lay_id)
layer_background_alpha(back_id, alpha)