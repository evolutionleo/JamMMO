/// @desc

if (my_player.team == "cyan")
	pal_swap_set(sPalette, 1, false)

draw_self()

pal_swap_reset()


var col = my_player.team == "cyan" ? c_cyan : c_pink

if (!my_player.remote) {
	draw_set_font(fAmmo)
	draw_set_color(col)
	draw_set_halign(fa_middle)
	draw_set_valign(fa_center)
	
	draw_text(room_width - 128, room_height - 32, "Ammo: " + string(bullets) + "/" + string(max_bullets))
	
	draw_set_color(c_white)
	draw_set_font(-1)
}

if (reloading)
	draw_healthbar(my_player.bbox_left-10, my_player.bbox_top-20, my_player.bbox_right+10, my_player.bbox_top-5, (reload_time-alarm[1])/reload_time*100, c_black, col, col, 0, false, true)