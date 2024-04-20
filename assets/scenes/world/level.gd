extends Node2D
class_name LevelClass

var root : Node
var enter_position : Vector2
var level_name : String = ""

func connect_root(new_root : Node) -> void:
	root = new_root


func load_level_data(level_data : LevelData) -> void:
	var index = 0
	for child in get_children():
		if child is ItemClass:
			child.index = index
			if index in level_data.collected:
				child.queue_free()
			index += 1
			child.collected.connect(collected_item)


func _ready_level() -> void:
	Globals.current_level_name = level_name
	if !Globals.levels.has(level_name):
		Globals.levels[level_name] = LevelData.new()
	load_level_data(Globals.levels[level_name])


func collected_item(item_index : int) -> void:
	Globals.collect(item_index)
