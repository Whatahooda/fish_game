stored_combat_info = array_create(0);

function CombatStoreInfo(_tracked_info)
{
	array_push(stored_combat_info, _tracked_info);
}