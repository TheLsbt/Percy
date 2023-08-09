extends Node

onready var percy: Panel = $Percy

var global : Node = null
var timeline : Panel = null
var layer_vbox : VBoxContainer = null


func _enter_tree() -> void:
	global = get_node_or_null("/root/Global")
	
	if global:
		timeline = global.animation_timeline
		layer_vbox = global.layer_vbox
		
#		timeline.hide()
		layer_vbox.hide()
		
		percy.project = null

func _ready() -> void:
	percy.popup_centered()
	if layer_vbox:
		layer_vbox.connect("child_entered_tree", self, "_on_layer_vbox_child_entered_tree")
		layer_vbox.connect("child_exited_tree", self, "_on_layer_vbox_child_exited_tree")


func _on_layer_vbox_child_entered_tree(child: Node) -> void:
	percy.add_button(child)


func _on_layer_vbox_child_exited_tree(child: Node) -> void:
	percy.remove_button(child)


func _exit_tree() -> void:
	if global:
		timeline.show()
		layer_vbox.show()
