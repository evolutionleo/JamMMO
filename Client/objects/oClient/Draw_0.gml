/// @desc



#macro room_middle (room_height/2)
#macro room_center (room_width/2)

if (room == rMenu) {
	draw_set_font(fCutscene)

	draw_set_color(c_black)
	draw_text(room_center+1, room_height - 120+1, text)

	if (string_pos("cyan", text))
		draw_set_color(c_cyan)
	else if (string_pos("pink", text))
		draw_set_color(c_pink)
	else
		draw_set_color(c_magenta)
	
	draw_text(room_center, room_height - 120, text)
	
	
	draw_set_color(c_lime)
	draw_set_font(fOnline)
	
	draw_text(room_width-128, 32, "Online: "+string(players_online))

	draw_set_color(c_white)
	draw_set_font(-1)
}