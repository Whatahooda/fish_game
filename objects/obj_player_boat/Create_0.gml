event_inherited();

fishing = false
y_min = 0;
y_max = 0;

UpdateActorInput = function()
{
	if (!fishing && y > y_min) input_up = real(keyboard_check(ord("W")));
	else input_up = 0;
	
	if (!fishing && y < y_max) input_down = real(keyboard_check(ord("S")));
	else input_down = 0;
}

///	@func	UpdateMoveDefault(_in_vector)
///	@param	{Struct.Vector2D}	_in_vector	Actor movement input, usually gotten from BinaryInputToVector()
///	@desc	Default Move function for Actors on a 2D plain
UpdateMoveDefault = function(_in_vector)
{
	if (do_acc) velocity_vector = UpdateAcceleration(_in_vector, velocity_vector, acceleration, fric);
	else velocity_vector = new Vector2D(_in_vector.vx * velocity, _in_vector.vy * velocity);
	
	var _dt = delta_time / 1000000;
	var _collisions = move_and_collide(velocity_vector.vx * _dt, velocity_vector.vy * _dt, colliders);
	y = clamp(y + velocity_vector.vy * _dt, y_min, y_max);
}

function PlayerBoatSetEnabled(_is_enabled)
{
	visible = _is_enabled;
	can_move = _is_enabled;
}

function PlayerBoatSetMoveLimits(_y_min, _y_max)
{
	y_min = _y_min;
	y_max = _y_max;
}
