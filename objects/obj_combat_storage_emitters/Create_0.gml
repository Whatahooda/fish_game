function AddCombatEmitter(_new_combat_emitter)
{
	ds_map_add(combat_emitters, _new_combat_emitter.emitter_id, _new_combat_emitter);
}


/**
 * Function Description
 * @param {any} _emitter_id Description
 * @return {Struct.CombatEmitterData}
 */
function GetCombatEmitter(_emitter_id)
{
	return ds_map_find_value(combat_emitters, _emitter_id);
}

combat_emitters = ds_map_create();
var _emitter = undefined;

_emitter = new CombatEmitterData("basic_left",
	new Vector2D(obj_combat_zone.x, obj_combat_zone.y),
	new CombatSpawnRegion(obj_combat_zone.x,
		obj_combat_zone.y,
		new Vector2D(-obj_combat_zone.combat_zone_width / 2 - 48, -obj_combat_zone.combat_zone_width / 2),
		new Vector2D(-obj_combat_zone.combat_zone_height / 2, obj_combat_zone.combat_zone_height / 2),
		new Vector2D(0, 0)
	),
	0.5,
	obj_bullet_basic,
	-1
);
AddCombatEmitter(_emitter);

_emitter = new CombatEmitterData("basic_right",
	new Vector2D(obj_combat_zone.x, obj_combat_zone.y),
	new CombatSpawnRegion(obj_combat_zone.x,
		obj_combat_zone.y,
		new Vector2D(obj_combat_zone.combat_zone_width / 2 + 16, obj_combat_zone.combat_zone_width / 2 + 48),
		new Vector2D(-obj_combat_zone.combat_zone_height / 2, obj_combat_zone.combat_zone_height / 2),
		new Vector2D(180, 180)
	),
	0.5,
	obj_bullet_basic,
	-1
);
AddCombatEmitter(_emitter);

_emitter = new CombatEmitterData("basic_top",
	new Vector2D(obj_combat_zone.x, obj_combat_zone.y),
	new CombatSpawnRegion(obj_combat_zone.x,
		obj_combat_zone.y,
		new Vector2D(-obj_combat_zone.combat_zone_width / 2, obj_combat_zone.combat_zone_width / 2),
		new Vector2D(-obj_combat_zone.combat_zone_height / 2 - 48, -obj_combat_zone.combat_zone_height / 2 - 16),
		new Vector2D(270, 270)
	),
	0.5,
	obj_bullet_basic,
	-1
);
AddCombatEmitter(_emitter);

_emitter = new CombatEmitterData("basic_bottom",
	new Vector2D(obj_combat_zone.x, obj_combat_zone.y),
	new CombatSpawnRegion(obj_combat_zone.x,
		obj_combat_zone.y,
		new Vector2D(-obj_combat_zone.combat_zone_width / 2, obj_combat_zone.combat_zone_width / 2),
		new Vector2D(obj_combat_zone.combat_zone_height / 2 + 16, obj_combat_zone.combat_zone_height / 2 + 48),
		new Vector2D(90, 90)
	),
	0.5,
	obj_bullet_basic,
	-1
);
AddCombatEmitter(_emitter);

_emitter = new CombatEmitterData("boomerang_random_circle",
	new Vector2D(obj_combat_zone.x, obj_combat_zone.y),
	new CombatSpawnRegionCircle(obj_combat_zone.x,
		obj_combat_zone.y,
		new Vector2D(0, 360),
		new Vector2D(240, 240),
		true
	),
	0.5,
	obj_bullet_boomerang1,
	-1,
	5,
	false
);
AddCombatEmitter(_emitter);

// Zones
_emitter = new CombatEmitterData("basic_zone_middle",
	new Vector2D(obj_combat_zone.x, obj_combat_zone.y),
	new CombatSpawnRegion(obj_combat_zone.x,
		obj_combat_zone.y,
		new Vector2D(0, 0),
		new Vector2D(0, 0),
		new Vector2D(0, 0)
	),
	0.5,
	obj_proj_zone_basic,
	-1,
	1
);
AddCombatEmitter(_emitter);