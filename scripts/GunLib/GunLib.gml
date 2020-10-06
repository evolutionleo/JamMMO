globalvar GunLibrary;

GunLibrary = {
	pistol: {
		sprite_index: sPistol,
		laser: false,
		bullet_count: 1,
		bullets: 6,
		reload_time: 45,
		delay_time: 20,
		damage: 10,
		bul_spd: 10,
		rand_dir: 5,
		rand_spd: 1
	},
	shotgun: {
		sprite_index: sShotgun,
		laser: false,
		bullet_count: 6,
		bullets: 6,
		reload_time: 45,
		delay_time: 60,
		damage: 10,
		bul_spd: 15,
		rand_dir: 20,
		rand_spd: 2
	},
	riffle: {
		sprite_index: sRiffle,
		laser: false,
		bullet_count: 1,
		bullets: 18,
		reload_time: 60,
		delay_time: 10,
		damage: 8,
		bul_spd: 17,
		rand_dir: 6,
		rand_spd: .1
	},
	railgun: {
		sprite_index: sRailgun,
		laser: true,
		bullet_count: 1,
		bullets: 2,
		delay_time: 60,
		reload_time: 40,
		shoot_delay: 15,
		damage: 80,
		bul_spd: 1,
		rand_dir: 1,
		rand_spd: 0
	}
}