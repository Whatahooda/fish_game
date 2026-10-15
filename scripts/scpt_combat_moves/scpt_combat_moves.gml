/* Combat Moves Planning
Moves are the meat of combat, what actually create projectiles and determind gameplay
Moves need to be able to:
 - Create projectile emitters
 - Modify the combat zone: Position, Size, Reel Zone Position, Reel Zone Size*
 - Modify the player in specific ways: Speed, Gravity, Input
 - Last a set duration

*/

enum COMBAT_ZONE_POSITIONS
{
	LEFT,
	CENTER,
	RIGHT,
	TOP,
	MIDDLE,
	BOTTOM
}

/**
 * Function Description
 * @param {any*} _x Description
 * @param {any*} _y Description
 * @param {any*} _horizontal_region Description
 * @param {any*} _vertical_region Description
 * @param {any*} _direction_region Description
 */
function CombatSpawnRegion(_x, _y, _horizontal_region, _vertical_region, _direction_region) constructor
{
	origin_x = _x;
	origin_y = _y;
	horizontal_region = _horizontal_region;
	vertical_region = _vertical_region;
	direction_region = _direction_region;
	
	static GetSpawnX = function(_relative = true)
	{
		return (_relative) ? origin_x + random_range(horizontal_region.vx, horizontal_region.vy) : random_range(horizontal_region.vx, horizontal_region.vy);
	}
	static GetSpawnY = function(_relative = true)
	{
		return (_relative) ? origin_y + random_range(vertical_region.vx, vertical_region.vy) : random_range(vertical_region.vx, vertical_region.vy);
	}
	static GetSpawnDirection = function()
	{
		return random_range(direction_region.vx, direction_region.vy);
	}
}

/**
 * Function Description
 * @param {String} _move_id Description
 * @param {Array<String>} _emitters Description
 * @param {any*} _zone_mod Description
 * @param {any*} _player_mod Description
 */
function CombatMoveData(_move_id, _emitters, _zone_mod, _player_mod) constructor
{
	// Emitter details
	// Any zone or player modifications on move start and end
	move_id = _move_id;
	emitters = _emitters;
	zone_mod = _zone_mod;
	player_mod = _player_mod;
}

/**
 * Function Description
 * @param {String} _emitter_id
 * @param {Struct.Vector2D} _spawn_position Where the emitter spawns
 * @param {Struct.CombatSpawnRegion} _spawn_region Where projectiles are spawned by the emitter
 * @param {Real} _spawn_delay Pause between creating projectiles
 * @param {Asset.GMObject} projectile_id Object Asset for the emitter to create
 * @param {Real} _emitter_lifetime 
 * @param {Real} [_max_projectiles]=-1 How many projectiles the emitter will create before stopping
 * @param {Bool} [_aim_at_player]=false Set to true to point at the player
 */
function CombatEmitterData(_emitter_id, _spawn_position, _spawn_region, _spawn_delay, projectile_id, _emitter_lifetime, _max_projectiles = -1, _aim_at_player = false) constructor
{
	/* Emitters
	Spawn position
		Can be randomly selected regions
	Spawn region
		Where the emitter creates projectiles and their direction
	Path? Look into this, could be overly complicated
	Projectile to spawn
	Spawn Delay
	Emitter lifetime
	Optionally Maximum Projectiles Spawned
	*/
	emitter_id = _emitter_id;
	spawn_position = _spawn_position;
	spawn_region = _spawn_region;
	spawn_delay = _spawn_delay;
	projectile = projectile_id;
	emitter_lifetime = _emitter_lifetime;
	max_projectiles = _max_projectiles;
	aim_at_player = _aim_at_player;
	
	static CreateEmitter = function()
	{
		var _emitter = instance_create_layer(spawn_position.vx, spawn_position.vy, __COMBAT_ACTOR_LAYER, obj_combat_emitter, {
			spawn_region: spawn_region,
			spawn_delay: spawn_delay,
			projectile: projectile,
			max_projectiles: max_projectiles,
			emitter_lifetime: emitter_lifetime,
			aim_at_player: aim_at_player
		});
		
		return _emitter;
	}
}
