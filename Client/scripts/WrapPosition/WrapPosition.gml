///@funciton	wrap_position(pos)
///@param		{Vector2} pos
function wrap_position(pos) {
	if pos.x > room_width {
		pos.x = 0
	}
	if pos.x < 0 {
		pos.x = room_width
	}
	if pos.y > room_height {
		pos.y = 0
	}
	if pos.y < 0 {
		pos.y = room_height
	}
	
	return pos
}