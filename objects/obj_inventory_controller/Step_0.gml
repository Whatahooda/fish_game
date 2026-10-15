if (visible)
{
	if (MouseInInventory())
	{
		highlight_tile = true;
		highlighted_col = GetColumn(mouse_x);
		highlighted_row = GetRow(mouse_y);
	}
	else highlight_tile = false;
}
