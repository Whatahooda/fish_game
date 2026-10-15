/// @desc AddCombatStats Utility function to quickly store newly created stats
/// @param {Struct.CombatAIData} _new_combat_stats combat Stats Struct
function AddCombatAi(_new_combat_ai) {
	ds_map_add(combat_ai, _new_combat_ai.ai_id, _new_combat_ai);
}


/**
 * GetCombatAi Description
 * @param {String} _ai_id Description
 * @return {Struct.CombatAIData}
 */
function GetCombatAi(_ai_id) {
	return ds_map_find_value(combat_ai, _ai_id);
}

combat_ai = ds_map_create();
var _ai = undefined;

_ai = new CombatAIData("basic",
	[],
	["basic_left", "basic_right", "basic_top", "basic_bottom", "basic_all"],
	["basic_zone_middle"],
	true, 1, 1, 1
);
AddCombatAi(_ai);

_ai = new CombatAIData("flying_fish",
	[],
	["flying_fish1"],
	[],
	true, 1, 1, 1
);
AddCombatAi(_ai);