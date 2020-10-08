/// @desc




if Input.getPressed("skip") {
	cur_layer++
}

if Input.getPressed("skip_all")
	cur_layer = 100

if cur_layer >= array_length(cutscene_layers) {
	room_goto_next()
}
else {
	var lay_id = layer_get_id(cutscene_layers[cur_layer])

	for(var i = 0; i < array_length(cutscene_layers); ++i) {
		var _lay_id = layer_get_id(cutscene_layers[i])
		if (_lay_id != lay_id) {
			layer_set_visible(_lay_id, false)
		}
		else {
			layer_set_visible(_lay_id, true)
		}
	}
}