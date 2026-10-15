if (!draw_reward_box && obj_mouse_controller.mouse_mode == MOUSE_MODE.DEFAULT)
{
	obj_controller_overworld.PauseOverworld(!visible);
	InventorySetVisible(!visible);
}
