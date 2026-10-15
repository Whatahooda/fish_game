function ParticleCreate(_x, _y, _vel_x, _vel_y, _angle_strength, _fade_strength, _scale_strength, _lifetime, _sprite, _image_index, _rotation, _color = c_white, _fric = 0.8)
{
	return instance_create_layer(_x, _y, "Particles", obj_particle, {
		vel_x: _vel_x,
		vel_y: _vel_y,
		angle_strength: _angle_strength,
		fade_strength: _fade_strength,
		scale_strength: _scale_strength,
		lifetime: _lifetime,
		sprite_index: _sprite,
		image_index: _image_index,
		image_angle: _rotation,
		image_blend: _color,
		fric: _fric
	});
}

function ParticleCreateSimple(_x, _y, _vel, _direction, _fric, _fade, _scale, _lifetime, _sprite)
{
	return ParticleCreate(_x, _y, _vel * dcos(_direction), _vel * -dsin(_direction), 0, _fade, _scale, _lifetime, _sprite, 0, _direction, c_white, _fric);
}