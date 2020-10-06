/// @desc



var _x = text_positions[cur_layer].x
var _y = text_positions[cur_layer].y
var _text = text[cur_layer]

draw_set_font(fCutscene)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

//draw_set_color(c_cyan)
//draw_text(_x+.5, _y+.5, _text)
//draw_set_color(c_pink)
//draw_text(_x+1, _y+1, _text)
draw_set_color(c_black)
draw_text(_x+1, _y+1, _text)

draw_set_color(c_magenta)
draw_text(_x, _y, _text)

draw_set_color(c_white)
draw_set_font(-1)