function CombatStatsPlayer(_player_speed, _player_defense) constructor
{
	player_speed = _player_speed;
	player_defense = _player_defense;
}


/**
 * @desc CombatStats Represents the stats of a combat for combats
 * @param {String} _combat_id
 * @param {String} _combat_ai_id AI the combat uses during combat
 * @param {Real} _combat_reel_time Duration the player needs to spend to reel in the combat
 * @param {Asset.GMSprite} _combat_portrait Sprite which is displayed around the combat area
 * @param {Asset.GMSprite} _combat_body Sprite used by the combat in some moves/attacks
**/
function CombatStats(_combat_id, _combat_ai_id, _combat_reel_time, _combat_portrait, _combat_body, _reward) constructor
{
	combat_id = _combat_id;
	ai_id = _combat_ai_id;
	reel_time = _combat_reel_time;
	portrait = _combat_portrait;
	body = _combat_body;
	reward = _reward;
}
