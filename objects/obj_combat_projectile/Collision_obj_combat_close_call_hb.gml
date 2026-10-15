if (active && !close_call)
{
	close_call = true;
	other.CloseCallVisuals();
	time_source_start(ts_close_call);
}
