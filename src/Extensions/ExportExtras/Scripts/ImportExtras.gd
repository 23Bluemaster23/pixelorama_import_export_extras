extends Node



func import_image(image,file_name,rows,columns,slice_mode,split_layers,new_project,extension_api):
	var project = extension_api.project.get_current_project()
	var sprite = image.get_data()
	var sprite_size = sprite.get_size()
	var unit_sprite_size = sprite_size/Vector2(rows,columns)

	var layers_count
	var frames = []
	var frames_count
	
	if new_project:
		project = extension_api.project.new_project([], file_name, unit_sprite_size)
		extension_api.project.switch_to(project)
	
	if slice_mode == "rows":
		layers_count = columns
		frames_count = rows
		for column in range(0,columns):
			
			for row in range(0,rows):
				var new_img 
				
				new_img = sprite.get_rect(Rect2(unit_sprite_size.x*row,unit_sprite_size.y*column,unit_sprite_size.x,unit_sprite_size.y))
				frames.append(new_img)
	else:
		layers_count = rows
		frames_count = columns
		for row in range(0,rows):
			for column in range(0,columns):
				var new_img 
				
				new_img = sprite.get_rect(Rect2(unit_sprite_size.x*row,unit_sprite_size.y*column,unit_sprite_size.x,unit_sprite_size.y))
				frames.append(new_img)
	
	var count = 0
	var frame_i = 0
	var layer_i = 0
	if !split_layers:
		for frame in frames:
			#frame.save_png(str(count,"-",0,frame_i,".png"))
			if !(range(project.frames.size()).has(count)):
				extension_api.project.add_new_frame(count-1)
			extension_api.project.set_pixelcel_image(frame,frame_i,0)
			frame_i +=1
			count+=1
	else:
		for layer in range(layers_count):
			frame_i = 0
			if !(range(project.layers.size()).has(layer_i)):
				extension_api.project.add_new_layer(layer_i-1, str(layer_i))
			for frame in range(frames_count):
				if !(range(project.frames.size()).has(frame_i)):
					extension_api.project.add_new_frame(frame_i-1)
				extension_api.project.set_pixelcel_image(frames[count],frame_i,layer_i)
				frame_i += 1
				count +=1
			layer_i += 1
	
