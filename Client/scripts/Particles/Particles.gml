//Generated for GMS2 in Geon FX v1.3
//Put this code in Create event

//trail Particle System
global.ps = part_system_create();
part_system_depth(global.ps, -1);

//trail Particle Types
//BulletTrail
global.pt_BulletTrail = part_type_create();
part_type_shape(global.pt_BulletTrail, pt_shape_line);
part_type_size(global.pt_BulletTrail, 0.50, 0.50, 0, 0);
part_type_scale(global.pt_BulletTrail, 1, 1);
part_type_orientation(global.pt_BulletTrail, 0, 0, 0, 0, 0);
part_type_color3(global.pt_BulletTrail, 8388863, 8388863, 8388863);
part_type_alpha3(global.pt_BulletTrail, 1, 0.49, 0);
part_type_blend(global.pt_BulletTrail, 0);
part_type_life(global.pt_BulletTrail, 20, 20);
part_type_speed(global.pt_BulletTrail, 5, 5, 0, 0);
part_type_direction(global.pt_BulletTrail, -1, 0, 0, 0);
part_type_gravity(global.pt_BulletTrail, 0.50, 0);

//trail Emitters
global.pe_BulletTrail = part_emitter_create(global.ps);


//jump Particle Types
//Jump
global.pt_Jump = part_type_create();
part_type_shape(global.pt_Jump, pt_shape_pixel);
part_type_size(global.pt_Jump, 7, 10, 0, 0);
part_type_scale(global.pt_Jump, 1, 1);
part_type_orientation(global.pt_Jump, -5, 348, 0, 0, 1);
part_type_color3(global.pt_Jump, 13028814, 14080476, 4828598);
part_type_alpha3(global.pt_Jump, 1, 0.44, 0.27);
part_type_blend(global.pt_Jump, 0);
part_type_life(global.pt_Jump, 10, 20);
part_type_speed(global.pt_Jump, 5, 5, 0, 0);
part_type_direction(global.pt_Jump, 33, 148, 0, 0);
part_type_gravity(global.pt_Jump, 0.10, 273);

//jump Emitters
global.pe_Jump = part_emitter_create(global.ps);


//shoot Particle Types
//Shoot
global.pt_Shoot = part_type_create();
part_type_shape(global.pt_Shoot, pt_shape_sphere);
//part_type_sprite(global.pt_Shoot, spr_pt_shape_sphere, 0, 0, 0);
part_type_shape(global.pt_Shoot, pt_shape_sphere);
part_type_size(global.pt_Shoot, 0.30, 0.30, 0, 0);
part_type_scale(global.pt_Shoot, 1, 1);
part_type_orientation(global.pt_Shoot, -356, 28, 0, 0, 0);
part_type_color3(global.pt_Shoot, 16776960, 16711935, 8388863);
part_type_alpha3(global.pt_Shoot, 0.50, 0.86, 1);
part_type_blend(global.pt_Shoot, 0);
part_type_life(global.pt_Shoot, 10, 15);
part_type_speed(global.pt_Shoot, 10, 10, 0, 0);
part_type_direction(global.pt_Shoot, -16, 28, 0, 0);
part_type_gravity(global.pt_Shoot, 0, 0);

//shoot Emitters
global.pe_Shoot = part_emitter_create(global.ps);

function shoot_particle(_x, _y, _dir) {
	//shoot emitter positions. Streaming or Bursting Particles.
	var xp, yp;
	xp = _x;
	yp = _y;
	
	part_type_direction(global.pt_Shoot, _dir-22, _dir+22, 0, 0);
	
	part_emitter_region(global.ps, global.pe_Shoot, xp-12, xp+12, yp-12, yp+12, ps_shape_diamond, ps_distr_invgaussian);
	part_emitter_burst(global.ps, global.pe_Shoot, global.pt_Shoot, 5);
}


function jump_particle() {
	//jump emitter positions. Streaming or Bursting Particles.
	var xp, yp;
	xp = x;
	yp = bbox_bottom;
	part_emitter_region(global.ps, global.pe_Jump, xp-40, xp+40, yp-7, yp+7, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(global.ps, global.pe_Jump, global.pt_Jump, 10);
}

function trail_particle(_x, _y, _dir) {
	//trail emitter positions. Streaming or Bursting Particles.
	var xp, yp;
	xp = _x;
	yp = _y;
	
	part_type_direction(global.pt_BulletTrail, _dir-1, _dir, 0, 0);
	
	part_emitter_region(global.ps, global.pe_BulletTrail, xp-12, xp+12, yp-2, yp+2, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(global.ps, global.pe_BulletTrail, global.pt_BulletTrail, 1);
}


function clear_particles() {
	//Destroying Emitters
	part_emitter_destroy(global.ps, global.pe_BulletTrail);
	part_emitter_destroy(global.ps, global.pe_Jump);
	part_emitter_destroy(global.ps, global.pe_Shoot);
}