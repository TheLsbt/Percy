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
	if percy:
		percy.queue_free()
		
	if affected.size() > 0:
		for a in affected:
			a.visible = true
