function CombatTrackedInfo(_combat_id, _combat_number, _countable_info) constructor
{
	combat_id = _combat_id;
	combat_number = _combat_number;
	countable_info = array_create(0);
	array_copy(countable_info, 0, _countable_info, 0, array_length(_countable_info));
}
