/// Combat
//		Combat Stats

// Stat ID

// AI - Determins how the combat acts during combat (maybe make it possible to specificy more than one ai?)
// May want to think of this more like individual moves that are selected during combat with weights

// Strength/Reel Time - How long it takes to reel in the combat by staying in the reel zone
// Most likely using seconds as the unit

//	Visuals
// Portrait - The image displayed around the combat area. Does not effect combat gameplay
// Body - The sprite to use for the combat if it appears as an attack during combat
// *Note* We won't worry about sprites for non combat body moves. These are generic enough it shouldn't matter

// Reward - Item recieved upon winning the combat encounter


/// @desc AddCombatStats Utility function to quickly store newly created stats
/// @param {Struct.CombatStats} _new_combat_stats combat Stats Struct
function AddCombatStats(_new_combat_stats, _fish_pool)
{
	ds_map_add(combat_stats, _new_combat_stats.combat_id, _new_combat_stats);
	array_push(array_get(fish_pools, _fish_pool), _new_combat_stats.combat_id);
}

/**
 * GetCombatStats Description
 * @param {String} _stats_id Description
 * @returns {Struct.CombatStats} Description
 */
function GetCombatStats(_stats_id)
{
	return ds_map_find_value(combat_stats, _stats_id);
}


enum FISH_POOL
{
	STANDARD,
	COUNT
}

fish_pools = array_create(FISH_POOL.COUNT);
for (var i = 0; i < FISH_POOL.COUNT; i++) array_set(fish_pools, i, array_create(0));

function GetFishFromPool(_fish_pool)
{
	var _pool = array_get(fish_pools, _fish_pool);
	return array_get(_pool, irandom(array_length(_pool) - 1));
}

combat_stats = ds_map_create();
var _stats = undefined;

//_stats = new CombatStats("basic", "basic", 10, spr_combat_hook, spr_combat_hook, obj_fish_test);
//AddCombatStats(_stats, FISH_POOL.STANDARD);

_stats = new CombatStats("flying_fish", "flying_fish", 10, spr_combat_hook, spr_combat_hook, obj_fish_test);
AddCombatStats(_stats, FISH_POOL.STANDARD);