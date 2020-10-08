/// @desc Spawning weapons

if (room != rMenu and room != rCutscene and room != rMenu)
{
	send_weapon_spawn()
	alarm[2] = 10 * room_speed
}