dbg_main = dbg_view("Fish Game Menu", true, 0, 32, 400, 200);

dgb_game_menu = dbg_section("Fish Game Menu Probably", true);
dbg_text("Click THAT button ->");
dbg_button("PLAY", function()
{
	//CombatInitiate("basic", obj_inventory_controller.GetFishModifiers(), new CombatStatsPlayer(1000, 1));
	obj_controller_combat.CombatStart("basic", __COMBAT_DELAY, obj_inventory_controller.GetFishModifiers());
	dbg_section_delete(dgb_game_menu);
	dbg_view_delete(dbg_main);
});
