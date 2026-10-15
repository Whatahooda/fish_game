#macro __COMBAT_ZONE_LAYER "Combat_Zone"
#macro __COMBAT_ACTOR_LAYER "Combat_Actors"
#macro __COMBAT_UI_LAYER "UI"

combat_counter = 0;
current_combat_id = "";

combat_time_scale = 1;

active_combat = false;
current_combat_stats = undefined;
combat_start_time = 0;

player_bobber = noone;
reel_zone = noone;
combat_info = noone;
combat_zone = noone;
progress = 0;
progress_goal = 0;
combat_complete = false;

moves_random = undefined;
move_index = -1;
selecting_random_moves = true;
delay_between_moves = 0;

ts_move_timer = undefined;

active_emitters = [];
combat_modifiers = array_create(COMBAT_MODIFIER.COUNT, undefined);

ts_move_timer = time_source_create(time_source_game, 1, time_source_units_seconds, CombatMoveTimer);
ts_move_initial = time_source_create(time_source_game, 1, time_source_units_seconds, CombatMoveInitial);
ts_combat_cleanup = time_source_create(time_source_game, 2, time_source_units_seconds, function(){obj_controller_combat.CombatCleanUp();});
ts_combat_reward = time_source_create(time_source_game, 3, time_source_units_seconds, function(){obj_controller_combat.CombatGiveReward();});

function InitializeStorageObjects()
{
	// Create the combat Zone
	combat_zone = instance_create_layer(room_width / 2, room_height / 2, "Combat_Zone", obj_combat_zone);
	combat_zone.CombatZoneSetDimensions(__COMBAT_DEFAULT_WIDTH, __COMBAT_DEFAULT_HEIGHT);
	
	instance_create_layer(0, 0, layer, obj_combat_storage_emitters);
	instance_create_layer(0, 0, layer, obj_combat_storage_moves);
	instance_create_layer(0, 0, layer, obj_combat_storage_ai);
	instance_create_layer(0, 0, layer, obj_combat_storage_stats);
	instance_create_layer(0, 0, layer, obj_combat_storage_info);
}

/**
 * CombatStart Begins to initiate combat, gathering data and prepping assets
 * @param {any} _combat_id Description
 * @param {Real} _delay Description
 * @param {Array<Real>} _combat_modifications Description
 */
function CombatStart(_combat_id, _delay, _combat_modifications)
{
	// Get combat information
	// Get combat portrait
	// Get base combat stats
	// Construct new combat with base stats and modifications
	// Use player stats to instatiate player combat character
	
	var _combat = -1;
	if (ds_map_exists(obj_combat_storage_stats.combat_stats, _combat_id)) _combat = obj_combat_storage_stats.GetCombatStats(_combat_id);
	else show_error("FATAL	Combat Stat ID \"" + _combat_id + "\" is undefined", true);
	
	current_combat_id = _combat_id;
	
	// Pause Overworld (not necessary, we want other pois to drift away, we will spawn new ones based on combat completion)
	//obj_controller_overworld.PauseOverworld(true);
	
	combat_zone.CombatZoneEnabled(true);
	
	var _player_speed = 1000;
	if (!is_undefined(_combat_modifications[COMBAT_MODIFIER.PLAYER_SPEED_ADD])) _player_speed += _combat_modifications[COMBAT_MODIFIER.PLAYER_SPEED_ADD];
	if (!is_undefined(_combat_modifications[COMBAT_MODIFIER.PLAYER_SPEED_MULT])) _player_speed *= _combat_modifications[COMBAT_MODIFIER.PLAYER_SPEED_MULT];
	var _player_defense = 1;
	
	var _player_stats = new CombatStatsPlayer(_player_speed, _player_defense);
	
	// Create the player bobber thing
	player_bobber = instance_create_layer(obj_combat_zone.x, obj_combat_zone.y, __COMBAT_ACTOR_LAYER, obj_combat_player, {
		player_stats : _player_stats
	});
	
	// Start combat after a set duration
	
	combat_modifiers = _combat_modifications;
	combat_ai = ds_map_find_value(obj_combat_storage_ai.combat_ai, _combat.ai_id);
	if (array_length(combat_ai.moves_random))
	{
		moves_random = array_create(0);
		for (var i = 0; i < array_length(combat_ai.moves_random); i++) array_push(moves_random, i);
		array_shuffle(moves_random);
	}
	else moves_random = undefined;
	
	active_combat = true;
	combat_counter++;
	combat_start_time = current_time;
	current_combat_stats = _combat;
	move_index = -1;
	
	selecting_random_moves = combat_ai.start_random;
	
	reel_zone = instance_create_layer(obj_combat_zone.x, obj_combat_zone.y, __COMBAT_ACTOR_LAYER, obj_combat_reel_zone);
	combat_info = instance_create_layer(obj_combat_zone.x, obj_combat_zone.y, __COMBAT_UI_LAYER, obj_combat_info, {combat_portrait: spr_fish_portrait});
	progress = 0;
	progress_goal = _combat.reel_time;
	combat_info.SetProgressGoal(_combat.reel_time);
	
	ts_move_timer = time_source_create(time_source_game, _delay, time_source_units_seconds, function(){CombatMoveTimer()}, [], -1);
	time_source_start(ts_move_timer);
	
	ts_move_initial = time_source_create(time_source_game, _delay, time_source_units_seconds, function(){CombatMoveInitial()}, []);
	time_source_start(ts_move_initial);
	
	// Debug Stuff
	instance_create_layer(x, y, layer, obj_debug_player);
}

function CombatMoveTimer()
{
	var _move_id = undefined;
	
	// Cycle through moves
	move_index++;
	
	if (selecting_random_moves && move_index >= array_length(moves_random) ||
		!selecting_random_moves && move_index >= array_length(combat_ai.moves_ordered)
	)
	{
		if (selecting_random_moves && array_length(combat_ai.moves_ordered)) selecting_random_moves = false;
		else if (!selecting_random_moves && array_length(combat_ai.moves_random))
		{
			selecting_random_moves = true;
		}
		if (selecting_random_moves) moves_random = array_shuffle(moves_random);
		move_index = 0;
	}
	
	if (selecting_random_moves) _move_id = array_get(combat_ai.moves_random, array_get(moves_random, move_index));
	else _move_id = array_get(combat_ai.moves_ordered, move_index);
	
	CombatMoveStop();
	CombatMoveStart(_move_id);
}

function CombatMoveInitial()
{
	for (var i = 0; i < array_length(combat_ai.moves_initial); i++) {
	    CombatMoveStart(array_get(combat_ai.moves_initial, i));
	}
}

function CombatMoveStart(_move_id)
{
	obj_combat_info.InfoTrack(INFO.MOVES_SEEN, 1);
	var _move = obj_combat_storage_moves.GetCombatMove(_move_id);
	for (var i = 0; i < array_length(_move.emitters); i++) {
	    var _emitter_data = obj_combat_storage_emitters.GetCombatEmitter(array_get(_move.emitters, i));
		var _emitter = _emitter_data.CreateEmitter();
		array_push(active_emitters, _emitter);
	}
}

function CombatMoveStop()
{
	for (var i = 0; i < array_length(active_emitters); i++) {
	    instance_destroy(array_get(active_emitters, i));
	}
	if (array_length(active_emitters) > 0) array_delete(active_emitters, 0, array_length(active_emitters) - 1);
}

function CombatChangeProgress(_seconds)
{
	progress += _seconds;
	progress = clamp(progress, 0, progress_goal);
	
	if (progress >= progress_goal)
	{
		CombatCompleted();
	}
}

function CombatCompleted()
{
	combat_complete = true;
	obj_combat_info.InfoTrack(INFO.TOTAL_TIME, (current_time - combat_start_time) / 1000000);
	obj_combat_info.InfoStore(current_combat_stats.combat_id, combat_counter);
	
	obj_combat_reel_zone.complete = true;
		
	time_source_destroy(ts_move_timer);
	for (var i = 0; i < array_length(active_emitters); i++) {
		var _emitter = array_get(active_emitters, i);
		if (instance_exists(_emitter)) _emitter.CombatCompleted();
	}
	with (obj_combat_projectile) {ProjectileCombatCompleted();}
	
	// Remove combat assets
	time_source_reset(ts_combat_cleanup);
	time_source_start(ts_combat_cleanup);
	
	// Open inventory and create fish reward
	time_source_reset(ts_combat_reward);
	time_source_start(ts_combat_reward);
}

function CombatCleanUp()
{
	active_combat = false;
	
	// Clean up all combat assets and move back to other gameplay
	combat_info.InfoObjectCleanUp();
	reel_zone.ReelObjectCleanUp();
	combat_zone.CombatZoneCleanUp();
	player_bobber.PlayerCleanUp();
	with (obj_ocean_fish) {CleanUp();}
}

/**
 * CombatGiveReward Opens the player inventory and creates a reward for the player to take
 * @param {Asset.GMObject} _reward_fish_object Description
 */
function CombatGiveReward()
{
	obj_controller_overworld.PauseOverworld(true);
	obj_controller_overworld.do_next_cycle = true;
	obj_inventory_controller.InventorySetVisible(true);
	obj_inventory_controller.draw_reward_box = true;
	
	// Spawn Fish Reward on reward box
	instance_create_depth(obj_inventory_controller.reward_box_centerx,
		obj_inventory_controller.reward_box_centery,
		obj_inventory_controller.depth - 1,
		current_combat_stats.reward,
		{is_reward: true}
	);
}

function CombatSetTimeScale(_new_time_scale)
{
	combat_time_scale = _new_time_scale;
}

if (!layer_exists(__COMBAT_ZONE_LAYER))
{
	var _layer = layer_create(0, __COMBAT_ZONE_LAYER);
	layer = layer_get_id(_layer);
}

InitializeStorageObjects();
