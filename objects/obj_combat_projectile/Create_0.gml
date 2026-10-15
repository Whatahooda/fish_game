active = true;
destroy_when_finished = false;
close_call = false;

// The multiplier for how the projectile travels through time (delta_time stuff kinda/not really)
time_scale = 1.0;
projectile_current_time = 0;

true_x = x;
true_y = y;

offset_x = 0;
offset_y = 0;

image_xscale = scale;
image_yscale = scale;

fade = false;
fade_strength = random_range(.5, 1.5);

ts_close_call = time_source_create(time_source_game, 0.5, time_source_units_seconds, function(){ProjectileCloseCall()});

function ProjectileStart(_x, _y, _direction)
{
	true_x = _x;
	true_y = _y;
	if (aim_at_player) target_direction = CombatGetDirectionToPlayer(x, y);
	else target_direction = _direction;
	if (time_source_exists(ts_lifetime))
	{
		time_source_reset(ts_lifetime);
		time_source_start(ts_lifetime);
	}
	
	visible = true;
	active = true;
}

function ProjectileFinish()
{
	visible = false;
	active = false;
	close_call = false;
	
	time_source_stop(ts_lifetime);
	time_source_stop(ts_close_call);
	if (destroy_when_finished) instance_destroy(self);
}

function ProjectileDestroy()
{
	if (active && !destroy_on_move_finished)
	{
		destroy_when_finished = true;
		//if (obj_controller_combat.combat_complete) ProjectileCombatCompleted();
	}
	else instance_destroy(self);
}

function ProjectileCloseCall()
{
	if (close_call && instance_exists(obj_combat_info))
	{
		obj_combat_info.InfoTrack(INFO.CLOSE_CALLS, 1);
	}
}

function ProjectileCombatCompleted()
{
	target_direction = point_direction(obj_combat_player.x, obj_combat_player.y, x, y);
	projectile_speed /= 2;
	fric = random_range(0.9, .975);
	fade = true;
	image_alpha = random_range(1, 1.5);
}


// Position Getters and Setters
{
	function GetPositionSpeed(_apply_time = true)
	{
		return (_apply_time) ? projectile_speed * time_scale : projectile_speed;
	}

	function SetPositionSpeed(_new_val, _is_add = false)
	{
		if (_is_add) projectile_speed += _new_val;
		else projectile_speed = _new_val;
	}

	function GetPositionAcceleration(_apply_time = true)
	{
		return (_apply_time) ? projectile_acceleration * time_scale : projectile_acceleration;
	}

	function SetPositionAcceleration(_new_val, _is_add = false)
	{
		if (_is_add) projectile_acceleration += _new_val;
		else projectile_acceleration = _new_val;
	}

	function GetPositionJerk(_apply_time = true)
	{
		return (_apply_time) ? projectile_jerk * time_scale : projectile_jerk;
	}

	function SetPositionJerk(_new_val, _is_add = false)
	{
		if (_is_add) projectile_jerk += _new_val;
		else projectile_jerk = _new_val;
	}
	
	function GetPositionFriction(_apply_time = true)
	{
		return (_apply_time) ? power(fric, time_scale) : fric;
	}
}

// Direction Getters and Setters
{
	function GetDirectionSpeed(_apply_time = true)
	{
		return (_apply_time) ? direction_speed * time_scale : direction_speed;
	}

	function SetDirectionSpeed(_new_val, _is_add = false)
	{
		if (_is_add) direction_speed += _new_val;
		else direction_speed = _new_val;
	}

	function GetDirectionAcceleration(_apply_time = true)
	{
		return (_apply_time) ? direction_acceleration * time_scale : direction_acceleration;
	}

	function SetDirectionAcceleration(_new_val, _is_add = false)
	{
		if (_is_add) direction_acceleration += _new_val;
		else direction_acceleration = _new_val;
	}

	function GetDirectionJerk(_apply_time = true)
	{
		return (_apply_time) ? direction_jerk * time_scale : direction_jerk;
	}

	function SetDirectionJerk(_new_val, _is_add = false)
	{
		if (_is_add) direction_jerk += _new_val;
		else direction_jerk = _new_val;
	}
}

// Move Functions
// TODO Make sure to incorporate a time scale for all move functions.
// TODO Make setter functions for each variable? So that we only worry about the time scale in those functions instead of EVERY move function
{
	/**
	 * ProjectileMoveBasic Basic movement for a projectile, meant for bullet like projectiles
	 */
	function ProjectileMoveBulletBasic()
	{
		target_direction += GetDirectionSpeed();
		
		projectile_speed *= GetPositionFriction();
		
		true_x += GetPositionSpeed() * dcos(target_direction);
		true_y += GetPositionSpeed() * -dsin(target_direction);
	
		x = true_x + offset_x;
		y = true_y + offset_y;
	}
	
	/**
	 * ProjectileMoveBasic Advanced movement for a projectile, accounting for jerk. Meant for bullet like projectiles
	 */
	function ProjectileMoveBulletAdvanced()
	{
		//direction_acceleration += direction_jerk;
		//direction_speed += direction_acceleration;
		//target_direction += direction_speed;
		
		SetDirectionAcceleration(GetDirectionJerk(), true);
		SetDirectionSpeed(GetDirectionAcceleration(), true);
		target_direction += GetDirectionSpeed();
	
		//projectile_acceleration += projectile_jerk;
		//projectile_speed += projectile_acceleration;
		
		SetPositionAcceleration(GetPositionJerk(), true);
		SetPositionSpeed(GetPositionAcceleration(), true);
		
		projectile_speed *= GetPositionFriction();
		
		true_x += GetPositionSpeed() * dcos(target_direction);
		true_y += GetPositionSpeed() * -dsin(target_direction);
	
		x = true_x + offset_x;
		y = true_y + offset_y;
	}
}

ProjectileMoveStep = ProjectileMoveBulletBasic;

ts_lifetime = undefined;
if (lifetime != -1)
{
	ts_lifetime = time_source_create(time_source_game, lifetime, time_source_units_seconds, function(){ProjectileFinish()});
	time_source_start(ts_lifetime);
}
