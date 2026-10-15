input_up = 0;
input_left = 0;
input_down = 0;
input_right = 0;

velocity_vector = new Vector2D(0, 0);
player_snap_multiplier = 1;

///	@function	GetPlayerInput()
///	@desc	Updates Actor input variables with player input
GetPlayerInput = function()
{
	input_up = real(keyboard_check(ord("W")));
	input_left = real(keyboard_check(ord("A")));
	input_down = real(keyboard_check(ord("S")));
	input_right = real(keyboard_check(ord("D")));
}

UpdateActorInput = GetPlayerInput;

///	@func	UpdateAcceleration(_direction, _vel, _acc, _fric)
///	@param	{Struct.Vector2D}	_direction
///	@param	{Struct.Vector2D}	_vel
///	@param	{Real}	_acc	
///	@param	{Real}	_fric	
///	@return	{Struct.Vector2D}
///	@desc	Modifies the velocity with acceleration and friction then returns it
function UpdateAcceleration(_direction, _vel, _acc, _fric)
{
	var _dt = delta_time / 1000000;
	
	// Snapping
	if (snapping && _vel.dot(_direction) < 0)
	{
		var _u = _direction.getPerpendicular(true);
		// To the left
		if (_direction.getPerpendicular(false).dot(_vel) > 1)
		{
			_u = _direction.getPerpendicular(false);	
		}
		_vel = _u.magnify(_u.dot(_vel)/sqr(_u.magnitude)).magnify(player_snap_multiplier);
		
		
		//_vel = new Vector2D(0, 0);
	}
	
	_vel.vx += _acc * _dt * _direction.vx;
	_vel.vy += _acc * _dt * _direction.vy;
	
	_vel = _vel.magnify(power(_fric, _dt));
	
	return _vel;
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
}

UpdateMove = UpdateMoveDefault;