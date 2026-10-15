#macro INVENTORY_BASE_WIDTH 10
#macro INVENTORY_BASE_HEIGHT 10

#macro INVENTORY_TILE_SIZE 32

inventory_width = INVENTORY_BASE_WIDTH;
inventory_height = INVENTORY_BASE_HEIGHT;

inventory_edge_padding = 16;
inventory_tile_padding = 16;

inventory_box_width = inventory_edge_padding * 2 + INVENTORY_TILE_SIZE * inventory_width;
inventory_box_height = inventory_edge_padding * 2 + INVENTORY_TILE_SIZE * inventory_height;

bg_color = #28383F;
tile_sprite = spr_inventory_tile;
tile_scale = 1;

highlighted_row = -1;
highlighted_col = -1;
highlight_tile = false;

draw_reward_box = false;
reward_box_width = INVENTORY_TILE_SIZE * 4;
reward_box_height = INVENTORY_TILE_SIZE * 4;
reward_box_offsetx = inventory_box_width;

currently_stored_fish = array_create(0);

x = room_width / 2 - inventory_box_width / 2;
y = room_height / 2 - inventory_box_height / 2;

last_x = x;
last_y = y;

inventory_box_x1 = x;
inventory_box_y1 = y;
inventory_box_x2 = x + inventory_box_width;
inventory_box_y2 = y + inventory_box_height;

inventory_reward_x1 = x + inventory_box_width / 2 - reward_box_width / 2 + reward_box_offsetx;
inventory_reward_y1 = y + inventory_box_height / 2 - reward_box_height / 2;
inventory_reward_x2 = x + inventory_box_width / 2 + reward_box_width / 2 + reward_box_offsetx;
inventory_reward_y2 = y + inventory_box_height / 2 + reward_box_height / 2;

reward_box_centerx = inventory_reward_x1 + reward_box_width / 2;
reward_box_centery = inventory_reward_y1 + reward_box_height / 2;

function InventorySetVisible(_is_visible)
{
	visible = _is_visible;
	for (var i = 0; i < array_length(currently_stored_fish); i++)
	{
		var _fish = array_get(currently_stored_fish, i);
		_fish.visible = _is_visible;
	}
}

function InventorySetPosition(_x, _y)
{
	x = _x;
	y = _y;
	for (var i = 0; i < array_length(currently_stored_fish); i++)
	{
		var _fish = array_get(currently_stored_fish, i);
		UpdateFishPositionX(_fish);
		UpdateFishPositionY(_fish);
	}
	UpdateInventoryPositions();
}

function UpdateInventoryPositions()
{
	inventory_box_x1 = x;
	inventory_box_y1 = y;
	inventory_box_x2 = x + inventory_box_width;
	inventory_box_y2 = y + inventory_box_height;

	inventory_reward_x1 = x + inventory_box_width / 2 - reward_box_width / 2 + reward_box_offsetx;
	inventory_reward_y1 = y + inventory_box_height / 2 - reward_box_height / 2;
	inventory_reward_x2 = x + inventory_box_width / 2 + reward_box_width / 2 + reward_box_offsetx;
	inventory_reward_y2 = y + inventory_box_height / 2 + reward_box_height / 2;
	
	reward_box_centerx = inventory_reward_x1 + reward_box_width / 2;
	reward_box_centery = inventory_reward_y1 + reward_box_height / 2;
}

/**
 * StoreFish(_x, _y, _fish_instance) Adds the specificied fish into the inventory
 * @param {real} _x Description
 * @param {real} _y Description
 * @param {any*} _fish_instance Description
 */
function StoreFish(_x, _y, _fish_instance)
{
	array_push(currently_stored_fish, _fish_instance);
	_fish_instance.inventory_index = array_length(currently_stored_fish) - 1;
	_fish_instance.inventory_col = GetColumn(_x);
	_fish_instance.inventory_row = GetRow(_y);
	
	_fish_instance.picked_up = false;
	UpdateFishPositionX(_fish_instance);
	UpdateFishPositionY(_fish_instance);
	MouseSetMode(MOUSE_MODE.DEFAULT);
}

function RemoveFish(_inventory_index)
{
	var _removed_fish = array_get(currently_stored_fish, _inventory_index);
	_removed_fish.inventory_index = -1;
	_removed_fish.inventory_col = -1;
	_removed_fish.inventory_row = -1;
	
	array_delete(currently_stored_fish, _inventory_index, 1);
	for (var i = _inventory_index; i < array_length(currently_stored_fish); i++)
	{
		var _fish = array_get(currently_stored_fish, i);
		_fish.inventory_index = i;
	}
}

function UpdateFishPositionX(_fish_instance)
{
	_fish_instance.x = GetColumnPosition(_fish_instance.inventory_col) + INVENTORY_TILE_SIZE / 2;
	//_fish_instance.x = GetColumnPosition(_fish_instance.inventory_col);
}

function UpdateFishPositionY(_fish_instance)
{
	_fish_instance.y = GetRowPosition(_fish_instance.inventory_row) + INVENTORY_TILE_SIZE / 2;
	//_fish_instance.y = GetRowPosition(_fish_instance.inventory_row);
}

function MouseInInventory()
{
	return visible && point_in_rectangle(mouse_x, mouse_y,
		x + inventory_edge_padding,
		y + inventory_edge_padding,
		x + INVENTORY_TILE_SIZE * inventory_width + inventory_edge_padding - 1,
		y + INVENTORY_TILE_SIZE * inventory_height + inventory_edge_padding - 1);
}

function FishInInventory(_fish_instance)
{
	var _left_diff = _fish_instance.x - _fish_instance.bbox_left;
	var _right_diff = _fish_instance.x - _fish_instance.bbox_right;
	var _top_diff = _fish_instance.y - _fish_instance.bbox_top;
	var _bot_diff = _fish_instance.y - _fish_instance.bbox_bottom;
	var _x_snap = SnapToGridX(_fish_instance.x);
	var _y_snap = SnapToGridY(_fish_instance.y)
	return visible && (_x_snap - _left_diff >= x) && 
		(_x_snap - _right_diff < x + inventory_box_width) &&
		(_y_snap - _top_diff >= y) &&
		(_y_snap - _bot_diff < y + inventory_box_height);
}

function GetFishModifiers()
{
	var _modifiers = array_create(COMBAT_MODIFIER.COUNT, undefined);
	for (var i = 0; i < array_length(currently_stored_fish); i++)
	{
		var _fish = array_get(currently_stored_fish, i);
		var _modifier_keys = ds_map_keys_to_array(_fish.modifiers);
		
		for (var j = 0; j < array_length(_modifier_keys); j++) {
			var _index = _modifier_keys[j];
			var _value = ds_map_find_value(_fish.modifiers, _modifier_keys[j]);
		    if (_modifiers[_index] == undefined)
			{
				_modifiers[_index] = _value;
			}
			else
			{
				_modifiers[_index] += _value;
			}
		}
	}
	
	return _modifiers;
}

function GetColumn(_position_x)
{
	return floor((_position_x - x + inventory_edge_padding) / INVENTORY_TILE_SIZE) - 1;
}

function GetRow(_position_y)
{
	return floor((_position_y - y + inventory_edge_padding) / INVENTORY_TILE_SIZE) - 1;
}

function GetColumnPosition(_col)
{
	return x + inventory_edge_padding + _col * INVENTORY_TILE_SIZE;
}

function GetRowPosition(_row)
{
	return y + inventory_edge_padding + _row * INVENTORY_TILE_SIZE;
}

function SnapToGridX(_x)
{
	return GetColumnPosition(GetColumn(_x));
}

function SnapToGridY(_y)
{
	return GetColumnPosition(GetColumn(_y));
}

InventorySetPosition(x, y);
