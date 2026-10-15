image_alpha = 0.5;

origin_x = x;
origin_y = y;

player_touching = false;
complete = false;

time_step = 0;

function ReelSetIsTouching(_is_touching)
{
	player_touching = _is_touching;
	
	if (player_touching) image_alpha = .8;
	else image_alpha = .5;
}

function CombatCompleted()
{
	complete = true;
}

function ReelObjectCleanUp()
{
	instance_destroy(self);
}

{
	function ReelMovementCircle(_time_step)
	{
		var _x_diff = dcos(_time_step * 60) * (obj_combat_zone.combat_zone_width / 2 - 64);
		var _y_diff = dsin(_time_step * 60) * (obj_combat_zone.combat_zone_height / 2 - 64);
		
		x = origin_x + _x_diff;
		y = origin_y + _y_diff;
	}
}

ReelMoveStep = ReelMovementCircle;