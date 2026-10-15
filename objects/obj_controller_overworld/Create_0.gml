ocean_min_y = room_height / 2 + 96;
ocean_max_y = room_height - 96;
player_stats = new CombatStatsPlayer(1000, 1);
paused = false;
do_next_cycle = false;

food_max = 10;
food_current = food_max;

food_pip_sprite = spr_food_pip;
food_x = room_width / 2;
food_y = room_height - 32;
food_pip_spacing = sprite_get_width(food_pip_sprite) * 1.25;
food_pip_width = sprite_get_width(food_pip_sprite) * food_max + sprite_get_width(food_pip_sprite) * .25 * (food_max - 1);

food_box_x1 = food_x - food_pip_width / 2 - food_pip_spacing;
food_box_y1 = food_y - food_pip_spacing;
food_box_x2 = food_x + food_pip_width / 2;
food_box_y2 = food_y + food_pip_spacing;

draw_chomp = false;

function OverworldStart()
{
	obj_ocean.draw_ocean = true;
	obj_player_boat.PlayerBoatSetEnabled(true);
	obj_player_boat.PlayerBoatSetMoveLimits(ocean_min_y, ocean_max_y);
	var _ts_spawn_first_pois = time_source_create(time_source_game, 1, time_source_units_seconds, function(){OverworldSpawnPOIs()});
	time_source_start(_ts_spawn_first_pois);
}

function OverworldSpawnPOIs()
{
	var _x_spacing = 96;
	var _poi_location = [0, 0, 0]
	_poi_location[irandom(2)] = 1;
	
	var _x_spawn = room_width + 64;
	var _y_spawn_middle = (ocean_max_y - ocean_min_y) / 2 + ocean_min_y;
	
	for (var i = 0; i < 3; i++) {
	    // if (_poi_location[i] == 1)
		
		var _fish = instance_create_layer(_x_spawn, _y_spawn_middle + (i - 1) * _x_spacing, "POIs", obj_ocean_fish, {
			fish_pool: FISH_POOL.STANDARD
		});
		
	}
}

function PauseOverworld(_is_paused)
{
	paused = _is_paused;
	obj_ocean.paused = _is_paused;
	for (var i = 0; i < instance_number(obj_ocean_fish); i++)
	{
		var _fish = instance_find(obj_ocean_fish, i);
		_fish.paused = _is_paused;
	}
	
	// After a combat is completed and the player closes the inventory, move the game forward
	if (!paused && do_next_cycle)
	{
		do_next_cycle = false;
		OverworldStepForward();
	}
}

function TimeCycleStep()
{
	food_current -= 1;
}

function OverworldStepForward()
{
	obj_player_boat.fishing = false;
	OverworldSpawnPOIs();
	TimeCycleStep();
}

function GetPlayerStats()
{
	return player_stats;
}
