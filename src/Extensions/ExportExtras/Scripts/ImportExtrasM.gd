extends Node

onready var import_extras = preload("res://src/Extensions/ExportExtras/Scripts/ImportExtras.gd").new()
var extension_api
var file_dialog
var import_dialog
var preview_image
var file_name = ""
func menu_item_clicked():
	file_dialog.popup_centered()

func setup_import() -> void:
	import_dialog.preview.texture = preview_image
	import_dialog.setup_slice_grid()
	import_dialog.popup_centered()

func _on_ImportFileDialog_file_selected(path):
	var real_img = Image.new()
	real_img.load(path)
	preview_image = ImageTexture.new()
	preview_image.create_from_image(real_img,1)
	real_img = null
	file_name = path.get_file()
	file_name = file_name.trim_suffix(str(".",file_name.get_extension()))
	setup_import()


func _on_RowsSpinBox_value_changed(value):
	import_dialog.slice_grid._spritesheet_vertical = value
	import_dialog.slice_grid.update()


func _on_ColumnsSpinBox_value_changed(value):
	import_dialog.slice_grid._spritesheet_horizontal = value
	import_dialog.slice_grid.update()


func _on_SliceModeButton_item_selected(index):
	match index:
		0: import_dialog.slice_mode = "rows"
		1: import_dialog.slice_mode = "columns"


func _on_SplitLayerCheckBox_pressed():
	import_dialog.split_in_layers = import_dialog.split_layers_check.pressed


func _on_CreateProjectCheckBox_pressed():
	import_dialog.create_new_project = import_dialog.create_project_check.pressed


func _on_ImportDialog_confirmed():
	var image = preview_image
	var rows = import_dialog.slice_grid._spritesheet_horizontal
	var columns = import_dialog.slice_grid._spritesheet_vertical
	var slice_mode = import_dialog.slice_mode
	var split_layer = import_dialog.split_in_layers
	var create_project = import_dialog. create_new_project
	
	import_extras.import_image(image,file_name,rows,columns,slice_mode,split_layer,create_project,extension_api)
