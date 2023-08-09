extends PanelContainer

onready var add_layer_list: MenuButton = $"%AddLayerList"
onready var layer_vbox: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/LayerVbox
onready var add_layer_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/LayerButtons/AddLayer

onready var remove_layer_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/LayerButtons/RemoveLayer
onready var clone_layer_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/LayerButtons/CloneLayer
onready var opacity_slider: TextureProgress = $MarginContainer/VBoxContainer/VBoxContainer/BlendingHBox/OpacitySlider

onready var merge_down_layer_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/LayerButtons/MergeDownLayer

onready var move_down_layer_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/LayerButtons/MoveDownLayer
onready var move_up_layer_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/LayerButtons/MoveUpLayer

var _o_layer_vbox = null
var _o_move_down_layer_button = null
var _o_move_up_layer_button = null
var _o_merge_down_layer_button = null
var _o_remove_layer_button = null
var _o_layer_opacity_slider = null

var global = null

func _exit_tree() -> void:
	global.layer_vbox = _o_layer_vbox
	global.move_down_layer_button = _o_move_down_layer_button
	global.move_up_layer_button = _o_move_up_layer_button
	global.merge_down_layer_button = _o_merge_down_layer_button
	global.remove_layer_button = _o_remove_layer_button
	global.layer_opacity_slider = _o_layer_opacity_slider

func _ready() -> void:
	_o_layer_vbox = global.layer_vbox
	_o_move_down_layer_button = global.move_down_layer_button
	_o_move_up_layer_button = global.move_up_layer_button
	_o_merge_down_layer_button = global.merge_down_layer_button
	_o_remove_layer_button = global.remove_layer_button
	_o_layer_opacity_slider = global.layer_opacity_slider
	
	global.layer_vbox = layer_vbox
	
	global.move_down_layer_button = move_down_layer_btn
	global.move_up_layer_button = move_up_layer_btn
	global.merge_down_layer_button = merge_down_layer_btn
	
	global.remove_layer_button = remove_layer_btn
	
	global.layer_opacity_slider = opacity_slider
	
#	ExtensionsApi.signals.connect_project_changed(self, "project_changed")
	
	move_up_layer_btn.connect("pressed", global.animation_timeline, "change_layer_order", [true])
	move_down_layer_btn.connect("pressed", global.animation_timeline, "change_layer_order", [false])
	
	merge_down_layer_btn.connect("pressed", global.animation_timeline, "_on_MergeDownLayer_pressed")
	
	clone_layer_btn.connect("pressed", global.animation_timeline, "_on_CloneLayer_pressed")
	
	remove_layer_btn.connect("pressed", global.animation_timeline, "_on_RemoveLayer_pressed")
	
	add_layer_btn.connect("pressed", global.animation_timeline, "add_layer", [0])
	add_layer_list.get_popup().connect("id_pressed", global.animation_timeline, "add_layer")
	
	opacity_slider.connect("value_changed", global.animation_timeline, "_on_OpacitySlider_value_changed")
	
	print("Loading previously created nodes.")
	
	var project = global.current_project
	
	for layer in project.layers.size():
		var layer_button = project.layers[layer].instantiate_layer_button()
		layer_button.layer = layer
		if project.layers[layer].name == "":
			project.layers[layer].set_name_to_default(global.current_project.layers.size())
		
		layer_button.visible = global.current_project.layers[layer].is_expanded_in_hierarchy()
		
		global.layer_vbox.add_child(layer_button)
		var count : int = global.layer_vbox.get_child_count()
		global.layer_vbox.move_child(layer_button, count - 1 - layer)
	
