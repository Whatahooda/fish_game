dbg_player_vars = dbg_view("Player Variables", true, 0, 32, 400, 200);

//dbg_section_font = dbg_section("Font Stuff");
dbg_section("Player Variables", true);
dbg_text("Change player stat variables to test and experiment.");

ref_player_acceleration = ref_create(instance_find(obj_combat_player, 0), "acceleration");
dbg_slider_int(ref_player_acceleration, 100, 2000, "Acceleration");

ref_player_snap = ref_create(instance_find(obj_combat_player, 0), "player_snap_multiplier");
dbg_slider(ref_player_snap, 0, 1, "Snap/Slide Multiplier");

ref_player_reset = ref_create(instance_find(obj_combat_player, 0), "PlayerDefaults");
dbg_button("Reset to Defaults", ref_player_reset);

var _info = instance_find(obj_combat_info, 0);
ref_info_tracker = ref_create(_info, "draw_tracked_info");
dbg_checkbox(ref_info_tracker, "Draw Tracked Info");