fish_pool_sprites = [
	spr_ocean_fish_standard
];

fishing = false;
pool_speed = obj_ocean.ocean_speed;
base_speed = pool_speed;
paused = false;

function CleanUp()
{
	instance_destroy(self);
}

function UpdatePool()
{
	if (fish_pool == -1) return;
	sprite_index = array_get(fish_pool_sprites, fish_pool);
}

UpdatePool();