if (picked_up)
{
	if (obj_inventory_controller.MouseInInventory() && obj_inventory_controller.FishInInventory(self) &&
		place_empty(obj_inventory_controller.SnapToGridX(x) + INVENTORY_TILE_SIZE / 2, obj_inventory_controller.SnapToGridY(y) + INVENTORY_TILE_SIZE / 2, obj_fish_item)
	)
	{
		obj_inventory_controller.StoreFish(x, y, self.id);
		obj_mouse_controller.held_instance = noone;
	}
}
else if (visible && MouseGetMode() == MOUSE_MODE.DEFAULT)
{
	picked_up = true;
	MouseSetMode(MOUSE_MODE.HOLDING_FISH);
	obj_mouse_controller.held_instance = self;
	if (inventory_index != -1)
	{
		obj_inventory_controller.RemoveFish(inventory_index);
	}
	if (is_reward)
	{
		is_reward = false;
		obj_inventory_controller.draw_reward_box = false;
	}
}
