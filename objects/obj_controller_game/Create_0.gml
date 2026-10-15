function ShowTitleScreen(_visible)
{
	obj_button_play.visible = _visible;
	obj_title.visible = _visible;
}

function PlayGame()
{
	ShowTitleScreen(false);
	obj_controller_overworld.OverworldStart();
}
