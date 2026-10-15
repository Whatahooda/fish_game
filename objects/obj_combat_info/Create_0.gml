///	This is the combat portrait and progress bar
DEFAULT_HEIGHT = 100;
BOX_WIDTH = sprite_get_width(spr_combat_progress_box);
BOX_HEIGHT = sprite_get_height(spr_combat_progress_box);

draw_portrait = true;
draw_progress = true;
draw_tracked_info = false;

progress_goal = 0;
progress_bar_height = DEFAULT_HEIGHT;
progress_yscale = DEFAULT_HEIGHT / BOX_HEIGHT;

function CombatGetProgress()
{
	return new Vector2D(obj_controller_combat.progress, obj_controller_combat.progress_goal);
}

function SetProgressGoal(_new_goal)
{
	progress_goal = _new_goal;
	progress_bar_height = DEFAULT_HEIGHT + 10 * _new_goal;
	progress_yscale = progress_bar_height / BOX_HEIGHT;
}

function CombatUpdateInfoPosition()
{
	x = obj_combat_zone.x - obj_combat_zone.combat_zone_width / 2;
	y = obj_combat_zone.y - obj_combat_zone.combat_zone_height / 2;
}

// Combat Tracking Information
enum INFO
{
	TIMES_HIT,
	TOTAL_TIME,
	PROJECTILES_CREATED,
	MOVES_SEEN,
	CLOSE_CALLS,
	ABILITIES_USED,
	TIME_PRESSING_INPUTS,
	COUNT
}

current_combat_info = array_create(INFO.COUNT, 0);
// info_player_positions? Would be an array, and updated on a defined period. Would be tied to the move
// Maybe save the player position, and offer a replay of the combat? Showing off how the player moved
// and where they got hit if anywhere?

function InfoTrack(_info_key, _change)
{
	var _existing_val = array_get(current_combat_info, _info_key);
	array_set(current_combat_info, _info_key, _existing_val + _change);
}

function InfoGet(_info_key)
{
	return array_get(current_combat_info, _info_key);
}

function InfoStore(_combat_id, _combat_number)
{
	obj_combat_storage_info.CombatStoreInfo(new CombatTrackedInfo(_combat_id, _combat_number, current_combat_info));
}

function InfoObjectCleanUp()
{
	instance_destroy(self);
}

CombatUpdateInfoPosition();
