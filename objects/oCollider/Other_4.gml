/// @desc

if (layer_get_id("Walls") == -1) or (layer_get_id("Tiles_1") == -1)
	exit

#macro TILE_WIDTH 32
#macro TILE_HEIGHT 32

var lay_id = layer_get_id("Tiles_1")
var tilemap = layer_tilemap_get_id(lay_id)

for(var _x = 0; _x <= room_width div TILE_WIDTH; _x++) {
	for(var _y = 0; _y < room_height div TILE_HEIGHT; _y++) {
		var tile = tilemap_get(tilemap, _x, _y)
		if (tile != 0) {
			//var wall = instance_create_layer(_x * TILE_WIDTH, _y * TILE_HEIGHT, "Walls", oWall)
			instance_create_layer(_x * TILE_WIDTH, _y * TILE_HEIGHT, "Walls", oWall)
		}
	}
}