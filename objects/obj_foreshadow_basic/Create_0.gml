// Inherit the parent event
event_inherited();

ts_warning = time_source_create(time_source_game, warning_duration, time_source_units_seconds, function(){ProjectileWarningDone()});

function ProjectileWarningDone()
{
	if (time_source_exists(ts_lifetime))
	{
		time_source_reset(ts_lifetime);
		time_source_start(ts_lifetime);
	}
	
	SetHitboxEnabled(true);
}

function ProjectileStart(_x, _y, _direction)
{
	true_x = _x;
	true_y = _y;
	start_x = true_x;
	start_y = true_y;
	x = true_x + offset_x;
	y = true_y + offset_y;
	
	if (aim_at_player) target_direction = CombatGetDirectionToPlayer(x, y);
	else target_direction = _direction;
	
	time_source_start(ts_warning);
	
	visible = true;
	active = true;
	SetHitboxEnabled(false);
	
	// Animate warning
	
}
