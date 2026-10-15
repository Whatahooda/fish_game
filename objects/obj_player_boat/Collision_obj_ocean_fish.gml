if (fishing) exit

other.fishing = true;
fishing = true;

// Initiate the POI
//CombatInitiate(obj_combat_storage_stats.GetFishFromPool(other.fish_pool), obj_inventory_controller.GetFishModifiers(), obj_controller_overworld.GetPlayerStats());
obj_controller_combat.CombatStart(obj_combat_storage_stats.GetFishFromPool(other.fish_pool), __COMBAT_DELAY, obj_inventory_controller.GetFishModifiers());
