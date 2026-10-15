///	@function	Vector2D(_x, _y)
///	@param	{Real}	_x
///	@param	{Real}	_y
///	@desc	Vector2D
function Vector2D(_x, _y) constructor
{
	vx = _x;
	vy = _y;
	magnitude = sqrt(sqr(vx) + sqr(vy));
	
	//	Math Operations
	
	///	@function	normalize()
	///	@return	{Struct.Vector2D}
	///	@desc	Returns a new vector that has been normalized from this vector
	static normalize = function()
	{
		var _length = magnitude;
		if (_length == 0) return new Vector2D(0, 0);
		return new Vector2D(vx / _length, vy / _length);
	}
	
	///	@function	getPerpendicular(_get_clockwise)
	///	@param	{Bool}	_get_clockwise	If true, return a clockwise perpendicular vector, counter-clockwise if false
	///	@return	{Struct.Vector2D}
	///	@desc	Returns a new vector that has been normalized from this vector
	static getPerpendicular = function(_get_clockwise)
	{
		if (_get_clockwise) return new Vector2D(vy, -vx);
		return new Vector2D(-vy, vx);
	}
	
	///	@function	add(_vec2d)
	///	@return	{Struct.Vector2D}
	static add = function(_vec2d)
	{
		return new Vector2D(vx + _vec2d.vx, vy + _vec2d.vy);
	}
	
	///	@function	sub(_vec2d)
	///	@return	{Struct.Vector2D}
	static sub = function(_vec2d)
	{
		return new Vector2D(vx - _vec2d.vx, vy - _vec2d.vy);
	}
	
	///	@function	magnify(_multiplier)
	///	@return	{Struct.Vector2D}
	static magnify = function(_multiplier)
	{
		//vx *= _multiplier;
		//vy *= _multiplier;
		return new Vector2D(vx * _multiplier, vy * _multiplier);
	}
	
	///	@function	dot(_vec2d)
	///	@return	{Real}
	///	@desc	
	static dot = function(_vec2d)
	{
		return dot_product(vx, vy, _vec2d.vx, _vec2d.vy);
	}
}

///	@function	Vector2DFromDegrees(_angle)
///	@param	{Real}	_angle Angle in degrees
///	@return	{Struct.Vector2D}
///	@desc	Returns a normalized Vector2D equivlent to _angle
function Vector2DFromDegrees(_angle)
{
	return new Vector2D(dcos(_angle), dsin(_angle));
}

///	@function	Vector2DFromRadians(_angle)
///	@param	{Real}	_angle Angle in radians
///	@return	{Struct.Vector2D}
///	@desc	Returns a normalized Vector2D equivlent to _angle
function Vector2DFromRadians(_angle)
{
	return new Vector2D(cos(_angle), sin(_angle));
}

///	@function	DegreesFromVector2D(_vector)
///	@param	{Struct.Vector2D}	_vector
///	@return	{Real}
function DegreesFromVector2D(_vector)
{
	return darctan2(_vector.vy, _vector.vx);
}
	
///	@function	RadiansFromVector2D(_vector)
///	@param	{Struct.Vector2D}	_vector
///	@return	{Real}
function RadiansFromVector2D(_vector)
{
	return arctan2(_vector.vy, _vector.vx);
}

///	@function	BinaryInputToVector(_in_up, _in_down, _in_left, _in_right)
///	@param	{Real}	_in_up
///	@param	{Real}	_in_down
///	@param	{Real}	_in_left
///	@param	{Real}	_in_right
///	@return	{Vector2D}
///	@desc	Takes in input variables and turns them into a normalized vector struct
function BinaryInputToVector(_in_up, _in_down, _in_left, _in_right)
{
	return new Vector2D(_in_right - _in_left, _in_down - _in_up).normalize();
}