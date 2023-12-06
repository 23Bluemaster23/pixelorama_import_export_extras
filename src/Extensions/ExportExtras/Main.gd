extends Node
onready var extension_api: Node
onready var export_dialog
onready var export_file_dialog
onready var export_extras
onready var import_extras
onready var import_file_dialog
onready var import_dialog

var export_id
var import_id
var global
func _enter_tree() -> void:
	extension_api = get_node_or_null("/root/ExtensionsApi")
	global = extension_api.general.get_global()
	
	export_extras = get_node("%ExportExtras")
	export_dialog = get_node("%ExportDialog")
	export_file_dialog = get_node("%ExportFileDialog")
	export_extras.extension_api = extension_api
	export_extras.exportDialog = export_dialog
	export_extras.fileDialog = export_file_dialog
	
	import_extras = get_node("%ImportExtras")
	import_file_dialog = get_node("%ImportFileDialog")
	import_file_dialog.theme = extension_api.theme.get_theme()
	import_dialog = get_node("%ImportDialog")
	import_dialog.theme = extension_api.theme.get_theme()
	import_dialog.global = global
	import_dialog.setup_transparent_checker()
	
	import_extras.extension_api = extension_api
	import_extras.import_dialog = import_dialog
	import_extras.file_dialog = import_file_dialog
	
	var type = extension_api.menu.FILE
	export_id = extension_api.menu.add_menu_item(type, "Export Extras", export_extras)
	import_id = extension_api.menu.add_menu_item(type, "Import Extras", import_extras)
func _exit_tree() -> void:  
	extension_api.menu.remove_menu_item(extension_api.menu.FILE,import_id)
	extension_api.menu.remove_menu_item(extension_api.menu.FILE, export_id)
	

