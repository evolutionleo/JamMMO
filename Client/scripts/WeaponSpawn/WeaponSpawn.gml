function spawn_weapon(type, _x, _y) {
	trace("Accepted spawn request")
	
	//// Destroy all previous spawns
	//var list = ds_list_create()
	
	//if (instance_position_list(_x, _y, oWeaponPickup, list, false)) {
	//	for(var i = 0; i < ds_list_size(list); ++i) {
	//		with(list[| i])
	//			instance_destroy()
	//	}
	//}
	
	//ds_list_destroy(list)
	
	if (instance_position(_x, _y, oWeaponPickup))
		return -1
	
	var upper_name = string_upper(string_char_at(type, 0)) + string_copy(type, 2, string_length(type)-1) // pistol -> Pistol
	var spr_name = "s" + upper_name + "Pickup"	
	
	trace(spr_name)
	
	var weapon = instance_create_layer(_x, _y, "Instances", oWeaponPickup)
	
	weapon.sprite_index = asset_get_index(spr_name)
	weapon.image_xscale = 5
	weapon.image_yscale = 5
	weapon.type = type
}