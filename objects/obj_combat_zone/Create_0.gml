draw_combat_zone = false;

combat_zone_width = 0;
combat_zone_height = 0;

combat_zone_xscale = 0;
combat_zone_yscale = 0;


zone_hb_left = instance_create_layer(x, y, layer, obj_solid);
zone_hb_right = instance_create_layer(x, y, layer, obj_solid);
zone_hb_top = instance_create_layer(x, y, layer, obj_solid);
zone_hb_bottom = instance_create_layer(x, y, layer, obj_solid);
hb_sprite_dimension = sprite_get_width(zone_hb_left.sprite_index);

function CombatZoneSetWidth(_new_width)
{
	combat_zone_width = _new_width;
	combat_zone_xscale = _new_width / sprite_width;
	CombatZoneUpdateHitboxes();
}

function CombatZoneSetHeight(_new_height)
{
	combat_zone_height = _new_height;
	combat_zone_yscale = _new_height / sprite_height;
	CombatZoneUpdateHitboxes();
}

function CombatZoneSetDimensions(_new_width, _new_height)
{
	CombatZoneSetWidth(_new_width);
	CombatZoneSetHeight(_new_height);
}


function CombatZoneUpdateHitboxes()
{
	zone_hb_left.image_yscale = combat_zone_yscale + 1;
	zone_hb_left.x = x - combat_zone_width / 2 - hb_sprite_dimension / 2;
	
	zone_hb_right.image_yscale = combat_zone_yscale + 1;
	zone_hb_right.x = x + combat_zone_width / 2 + hb_sprite_dimension / 2;
	
	zone_hb_top.image_xscale = combat_zone_xscale + 1;
	zone_hb_top.y =  y - combat_zone_height / 2 - hb_sprite_dimension / 2;
	
	zone_hb_bottom.image_xscale = combat_zone_xscale + 1;
	zone_hb_bottom.y = y + combat_zone_height / 2 + hb_sprite_dimension / 2;
	
	if (instance_exists(obj_combat_info))
	{
		obj_combat_info.CombatUpdateInfoPosition();
	}
}

function CombatZoneEnabled(_enabled)
{
	draw_combat_zone = _enabled;
}

function CombatZoneCleanUp()
{
	CombatZoneEnabled(false);
}

CombatZoneSetDimensions(sprite_width, sprite_height);