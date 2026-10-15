if (draw_progress)
{
	draw_sprite_ext(spr_combat_progress_box, 0, x - 32, y, 1, progress_yscale, 0, c_white, 1);
	var _progress_y = (CombatGetProgress().vx / progress_goal) * (progress_bar_height - 4);
	draw_rectangle(x - 34, y + 2, x - 30 - BOX_WIDTH, y + 2 + _progress_y, false);
}

if (draw_tracked_info)
{
	draw_set_halign(fa_right);
	draw_text(x - 64, y, "Times Hit: " + string(InfoGet(INFO.TIMES_HIT)));
	draw_text(x - 64, y + 16, "Close Calls: " + string(InfoGet(INFO.CLOSE_CALLS)));
	
	DrawFontDefaults();
}

if (draw_portrait)
{
	draw_sprite_ext(combat_portrait, 0, x + 32, y - 32, 1, 1, 0, c_white, 1);
}
