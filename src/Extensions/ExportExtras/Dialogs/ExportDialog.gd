extends ConfirmationDialog

var inverse_c = false
var ignore_hide_layers = false
var inverse_r= false
onready var inverse_c_checkbox = get_node("%InverseCCheckBox")
onready var ignore_layers_check = get_node("%IgnoreHLayersCheckBox")
onready var flip_rows_check = get_node("%InverseRCheckBox")
onready var flip_columns_ckeck = get_node("%InverseCCheckBox")
onready var checker = get_node("%TransparentChecker")
onready var extension_api = get_node_or_null("/root/ExtensionsApi")
onready var path_line_edit = get_node("%PathLineEdit")
onready var filename_line_edit = get_node("%FilenameLineEdit")
var global
var file_name = ""
var dir = ""

func _ready():
	global = extension_api.general.get_global()

func change_preview(image):
	get_node("VBoxContainer/PreviewPanel/ScrollContainer/Previews/VBoxContainer/preview").texture = image

func update_values():
	inverse_c = flip_columns_ckeck.pressed
	inverse_r = flip_rows_check.pressed
	ignore_hide_layers = ignore_layers_check.pressed
func setup_dialog(project):
	dir = project.directory_path
	path_line_edit.text = dir
	file_name = project.file_name
	filename_line_edit.text = file_name
	
	var global_theme = get_global_theme()
	theme = global_theme
	update_checker()
	
func set_path_text(path):
	dir = path
	path_line_edit.text = dir
	
func get_global_theme():
	return extension_api.theme.get_theme()

func _on_FilenameLineEdit_text_changed(new_text):
	file_name = new_text

func update_checker():
	checker.material.set_shader_param("size", global.checker_size)
	checker.material.set_shader_param("color1", global.checker_color_1)
	checker.material.set_shader_param("color2", global.checker_color_2)
	checker.material.set_shader_param("follow_movement", global.checker_follow_movement)
	checker.material.set_shader_param("follow_scale", global.checker_follow_scale)



