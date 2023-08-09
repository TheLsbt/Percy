extends Panel

onready var layers: VBoxContainer = $Content/LayersScroll/Layers

var project

func _ready() -> void:
	load_current_layers()

# Loading the current layers that were created before
func load_current_layers() -> void:
	var 


func add_button(child: Node) -> void:
	yield(get_tree(), "idle_frame")
	var layer_button = Button.new()
	layer_button.text = child.label.text
	layers.add_child(layer_button)


func remove_button() -> void:
	for
