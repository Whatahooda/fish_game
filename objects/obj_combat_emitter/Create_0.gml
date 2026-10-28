ts_spawn_projectile = time_source_create(time_source_game, spawn_delay, time_source_units_seconds, function(_emitter){with(_emitter){EmitterTimer()}}, [self], max_projectiles);
my_projectiles = array_create(0);
fired_projectiles = 0;

if (emitter_lifetime > 0) ts_lifetime = time_source_create(time_source_game, emitter_lifetime, time_source_units_seconds, function(){instance_destroy(self)});

function EmitterTimer()
{
	var _projectile = EmitterGetProjectile();
	var _spawn_data = spawn_region.GetSpawnData();
	_projectile.ProjectileStart(_spawn_data.spawn_x, _spawn_data.spawn_y, _spawn_data.spawn_direction);
	obj_combat_info.InfoTrack(INFO.PROJECTILES_CREATED, 1);
	fired_projectiles++;
}

function EmitterGetProjectile()
{
	var _ready_projectile = noone;
	for (var i = 0; i < array_length(my_projectiles); i++) {
	    if (!array_get(my_projectiles, i).active) _ready_projectile = array_get(my_projectiles, i);
	}
	
	if (!instance_exists(_ready_projectile))
	{
		var _spawn_data = spawn_region.GetSpawnData();
		_ready_projectile = instance_create_layer(_spawn_data.spawn_x, _spawn_data.spawn_y, __COMBAT_ACTOR_LAYER, projectile, {
			aim_at_player: aim_at_player,
			target_direction: _spawn_data.spawn_direction
		});
		array_push(my_projectiles, _ready_projectile);
	}
	
	return _ready_projectile;
}

function CombatCompleted()
{
	instance_destroy(self);
}

time_source_start(ts_spawn_projectile);
if (emitter_lifetime != -1) time_source_start(ts_lifetime);
