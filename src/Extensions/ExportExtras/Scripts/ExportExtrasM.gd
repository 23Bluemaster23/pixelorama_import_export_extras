extends Node
onready var exportExtras = preload("res://src/Extensions/ExportExtras/Scripts/ExportExtras.gd").new()
var exportDialog
var fileDialog
var extension_api

func menu_item_clicked():
	open_export_spritesheet()
func open_export_spritesheet():
	var project= extension_api.project.get_current_project()
	var inverse_c = exportDialog.inverse_c
	var inverse_r = exportDialog.inverse_r
	var ignore_h_layers = exportDialog.ignore_hide_layers
	create_image(project,inverse_c,inverse_r,ignore_h_layers)
	update_preview(project)
	exportDialog.popup_centered()
	extension_api.dialog.dialog_open(true)


func create_image(project,inverse_c,inverse_r,ignore_h_layers):
	exportExtras.create_image(project.size,project.frames.size(),project.layers.size(),project,extension_api.project,inverse_c,inverse_r,ignore_h_layers)


func update_preview(project):
	var preview_texture = ImageTexture.new()
	preview_texture.create_from_image(exportExtras.whole_img,1)
	exportDialog.setup_dialog(project)
	exportDialog.change_preview(preview_texture)

func update_data():
	var project= extension_api.project.get_current_project()
	exportDialog.update_values()
	var inverse_c = exportDialog.inverse_c
	var inverse_r = exportDialog.inverse_r
	var ignore_h_layers = exportDialog.ignore_hide_layers
	create_image(project,inverse_c,inverse_r,ignore_h_layers)
	update_preview(project)

func _on_ExportDialog_confirmed():
	exportExtras.whole_img.save_png(str(exportDialog.dir,"/",exportDialog.file_name,".png"))


func _on_InverseCCheckBox_pressed():
	update_data()

func _on_InverseRCheckBox_pressed():
	update_data()

func _on_IgnoreHLayersCheckBox_pressed():
	update_data()

func _on_PathButton_pressed():
	fileDialog.popup_centered()

func _on_FilenameLineEdit_text_changed(new_text):
	exportDialog.file_name = new_text


func _on_FileDialog_dir_selected(dir):
	exportDialog.set_path_text(dir)


func _on_ExportDialog_popup_hide():
	extension_api.dialog.dialog_open(false)
