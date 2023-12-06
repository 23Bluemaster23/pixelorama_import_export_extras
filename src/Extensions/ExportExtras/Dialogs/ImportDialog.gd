extends ConfirmationDialog


onready var slice_grid = get_node("%SliceGrid")
onready var rows_spin_box = get_node("%RowsSpinBox")
onready var columns_spin_box = get_node("%ColumnsSpinBox")
onready var preview = get_node("%Preview")
onready var split_layers_check = get_node("%SplitLayerCheckBox")
onready var create_project_check = get_node("%CreateProjectCheckBox")
onready var slice_mode_button = get_node("%SliceModeButton")
onready var checker = get_node("%TransparentChecker")
onready var global
var slice_mode = "columns"
var split_in_layers = true
var create_new_project = false
var file_name = ""

func _ready():
	
	slice_mode = slice_mode_button.text
	split_in_layers = split_layers_check.pressed
	create_new_project = create_project_check.pressed
	
func setup_slice_grid():
	rows_spin_box.value =  slice_grid._spritesheet_vertical
	columns_spin_box.value = slice_grid._spritesheet_horizontal
	slice_grid.update()
	

func setup_transparent_checker():
	checker = get_node("%TransparentChecker")
	checker.material.set_shader_param("size", global.checker_size)
	checker.material.set_shader_param("color1", global.checker_color_1)
	checker.material.set_shader_param("color2", global.checker_color_2)
	checker.material.set_shader_param("follow_movement", global.checker_follow_movement)
	checker.material.set_shader_param("follow_scale", global.checker_follow_scale)

#func _on_RowsSpinBox_value_changed(value):
#	rows_spin_box.value = value
#	slice_grid._spritesheet_vertical = value
#	slice_grid.update()
#
#
#func _on_ColumnsSpinBox_value_changed(value):
#	columns_spin_box.value = value
#	slice_grid._spritesheet_horizontal = value
#	slice_grid.update()
#
#
#func _on_CreateButton_pressed():
#	var rows = slice_grid._spritesheet_horizontal
#	var columns = slice_grid._spritesheet_vertical
#	var sprite = preview.texture.get_data()
#	var sprite_size = sprite.get_size()
#	var unit_sprite_size = sprite_size/Vector2(rows,columns)
#
#	var layers = []
#
#	if slice_mode == "rows":
#		for column in range(0,columns):
#			var frames = []
#			for row in range(0,rows):
#				var new_img 
#
#				new_img = sprite.get_rect(Rect2(unit_sprite_size.x*row,unit_sprite_size.y*column,unit_sprite_size.x,unit_sprite_size.y))
#				frames.append(new_img)
#			layers.append(frames)
#	else:
#
#		for row in range(0,rows):
#			var frames = []
#			for column in range(0,columns):
#				var new_img 
#
#				new_img = sprite.get_rect(Rect2(unit_sprite_size.x*row,unit_sprite_size.y*column,unit_sprite_size.x,unit_sprite_size.y))
#				frames.append(new_img)
#			layers.append(frames)
#
#
#	var count = 0		
#	var layer_i = 0
#	if create_new_project: print("Proyecto creado")
#	for layer in layers:
#		var frame_i = 0
#		if split_in_layers and layer_i>0:print("layer Creado")
#		for frame in layer:
#			count+=1
#			frame.save_png(str(count,"-",layer_i,frame_i,".png"))
#			frame_i +=1
#		layer_i+=1
#
#
#func _on_SliceModeButton_item_selected(index):
#	match index:
#		0: slice_mode= "rows"
#		1: slice_mode = "columns"
#
#
#func _on_SplitLayerCheckBox_pressed():
#	split_in_layers = split_layers_check.pressed
#
#
#
#func _on_CreateProjectCheckBox_pressed():
#	create_new_project = create_project_check.pressed
