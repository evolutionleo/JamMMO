/// @desc




#macro c_pink $8400FF
#macro c_cyan $F9CD00
#macro c_magenta $FF00C6


if (team == "cyan") {
	draw_healthbar(10, 10, 200+10, 40+10, hp/max_hp*100, c_black, c_cyan, c_cyan, 0, false, false)
}
else if (team == "pink") {
	draw_healthbar(room_width-10, 10, room_width-(200+10), 40+10, hp/max_hp*100, c_black, c_pink, c_pink, 0, false, false)
}