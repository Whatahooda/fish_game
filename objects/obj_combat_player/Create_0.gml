// Inherit the parent event
event_inherited();

acceleration = player_stats.player_speed;
invulnerable = false;

close_call_hb = instance_create_layer(x, y, layer, obj_combat_close_call_hb);

function PlayerHit(_damage, _invulnerable_duration, _knockback = 0)
{
	if (invulnerable) return;
	obj_controller_combat.CombatChangeProgress(-_damage);
	obj_combat_info.InfoTrack(INFO.TIMES_HIT, 1);
	
	PlayerHitIndicator(true);
	var _ts = time_source_create(time_source_game, min(_invulnerable_duration, .1), time_source_units_seconds, function(){PlayerHitIndicator(false)});
	time_source_start(_ts);
	
	invulnerable = true;
	_ts = time_source_create(time_source_game, _invulnerable_duration, time_source_units_seconds, function(){invulnerable = false;});
	time_source_start(_ts);
}

function PlayerHitIndicator(_on)
{
	if (_on)
	{
		image_blend = c_red;
	}
	else
	{
		image_blend = c_white;
	}
}

function PlayerDefaults()
{
	acceleration = 1000;
	player_snap_multiplier = 1;
}

function PlayerCleanUp()
{
	instance_destroy(self);
}
