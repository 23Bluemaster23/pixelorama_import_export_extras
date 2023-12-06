extends Node

class_name ExportExtras


var whole_img = Image.new()

func create_image(size,frames,layers,project,projectAPI,inverse_c,inverse_r,ignore_hide_layers):
	
	print(inverse_c)
	var columns:Array = []
	for layer in range(0,layers):
		var rows = []
		print(project.layers[layer].visible)
		if !project.layers[layer].visible and !ignore_hide_layers:
			continue
		for frame in range(0,frames):
			var cel = projectAPI.get_cel_at(project, frame, layer)
			var cel_tex:ImageTexture = cel._get_image_texture()
			rows.append(cel_tex.get_data())
		columns.append(rows)
	var columns_size = columns.size() if columns.size() > 0 else 1 
	whole_img.create(size.x*frames,size.y*columns_size,false,Image.FORMAT_RGBA8)
	if !inverse_c: 
		print("volteando Columnas")
		columns.invert()
	if inverse_r:
		for row in columns:
			row.invert()
	var column_i = 0
	for column in columns:
		var row_i = 0 
		for cel in column:
			whole_img.blend_rect(cel,Rect2(0,0,size.x,size.y),Vector2(row_i*size.x,column_i*size.y))
			row_i +=1
		column_i +=1
func get_spritesheet():
	return whole_img
