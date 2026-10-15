#macro __COMBAT_DEFAULT_WIDTH 400
#macro __COMBAT_DEFAULT_HEIGHT 400
#macro __COMBAT_DELAY 5


/**
 
 */


function CombatGetDirectionToPlayer(_x, _y, _obj_player = obj_combat_player)
{
	return point_direction(_x, _y, _obj_player.x, _obj_player.y);
}


function CombatSetTimeScale(_new_time_scale)
{
	if (!object_exists(obj_controller_combat)) show_error("[Combat System]	obj_controller_combat object not found, please import it into your project", true);
	if (!instance_exists(obj_controller_combat)) instance_create_depth(0, 0, 0, obj_controller_combat);
	
	obj_controller_combat.CombatSetTimeScale(_new_time_scale);
}