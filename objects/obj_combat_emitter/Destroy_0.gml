// Clean up projectiles
for (var i = 0; i < array_length(my_projectiles); i++) {
	var _projectile = array_get(my_projectiles, i);
	_projectile.ProjectileDestroy();
}

time_source_destroy(ts_spawn_projectile);
