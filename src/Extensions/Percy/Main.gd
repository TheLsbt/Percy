extends Node

const PERCY_SCENE = preload("UI/Percy.tscn")
var percy

var affected = []

var global = null

func _enter_tree() -> void:
	global = get_node("/root/Global")
	
	if global:
		percy = PERCY_SCENE.instance()
		percy.global = global
		ExtensionsApi.panel.add_node_as_tab(percy)
		
		affected.append(global.animation_timeline.find_node("LayerTools"))
		affected.append(global.animation_timeline.find_node("LayerFrameHSplit").get_child(0))
		
		if affected.size() > 0:
			for a in affected:
				a.visible = false


func _exit_tree() -> void:
	ExtensionsApi.dialog.show_error("Please Restart Pixelorama (From Percy) to fix UI errors")
	if affected.size() > 0:
		for a in affected:
			a.visible = true
	
	if global:
		ExtensionsApi.panel.remove_node_from_tab(percy)
