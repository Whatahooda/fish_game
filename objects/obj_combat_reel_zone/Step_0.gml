if (place_meeting(x, y, obj_combat_player) && !complete)
{
	obj_controller_combat.CombatChangeProgress(GetDeltaTimeSeconds());
	if (!player_touching) ReelSetIsTouching(true);
}
else if (player_touching) ReelSetIsTouching(false);

time_step += GetDeltaTimeSeconds();
ReelMoveStep(time_step);
