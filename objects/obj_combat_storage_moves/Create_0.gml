/// @desc AddCombatStats Utility function to quickly store newly created moves
/// @param {Struct.CombatMoveData} _new_combat_move
function AddCombatMove(_new_combat_move) {
	ds_map_add(combat_moves, _new_combat_move.move_id, _new_combat_move);
}

/**
 * Function Description
 * @param {any} _move_id Description
 * @return {Struct.CombatMoveData}
 */
function GetCombatMove(_move_id)
{
	return ds_map_find_value(combat_moves, _move_id);
}

combat_moves = ds_map_create();
var _move = undefined;

_move = new CombatMoveData("basic_left", ["basic_left"], undefined, undefined);
AddCombatMove(_move);

_move = new CombatMoveData("basic_right", ["basic_right"], undefined, undefined);
AddCombatMove(_move);

_move = new CombatMoveData("basic_top", ["basic_top"], undefined, undefined);
AddCombatMove(_move);

_move = new CombatMoveData("basic_bottom", ["basic_bottom"], undefined, undefined);
AddCombatMove(_move);

_move = new CombatMoveData("basic_all", ["basic_left", "basic_right", "basic_top", "basic_bottom"], undefined, undefined);
AddCombatMove(_move);

_move = new CombatMoveData("basic_zone_middle", ["basic_zone_middle"], undefined, undefined);
AddCombatMove(_move);

// Flying Fish Moves
_move = new CombatMoveData("flying_fish1", ["boomerang_random_circle"], undefined, undefined);
AddCombatMove(_move);