function Menu(_x, _y, _options, _description = -1)
{
		with (instance_create_depth(_x, _y, -999, oMenu))
		{
			options = _options;
			description = _description;
			optionsCount = array_length(_options)
			hovermarker = "* ";
			
			//setup size
			margin = 8;
			draw_set_font(fnt_menu)
			
			width = 1;
			if (_description != -1) width = max(width, string_width(_description));
			for(var i = 0; i < optionsCount; i++)
			{
				width = max(width, string_width(_options[i][0]));
			}
			width += string_width(hovermarker);
			
			heightLine = 17;
			height = heightLine * (optionsCount + !(description == -1));
			
			widthFull = width + margin * 2;
			heightFull = height + margin * 2;
		}
}