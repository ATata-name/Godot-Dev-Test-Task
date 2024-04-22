extends Node2D


func _ready() -> void:
	Globals.restart.connect(restart_game)
	Globals.added_item.connect(add_item)
	for child in %Level.get_children():
		child.connect_root(self)


func load_level(scene : PackedScene) -> Node:
	return call_deferred("_deferred_load_level",scene)
	

func _deferred_load_level(scene : PackedScene) -> Node:
	for child in %Level.get_children():
		child.free()
	
	var new_level = scene.instantiate()

	new_level.connect_root(self)
	%Level.add_child(new_level)
	$Player.position = new_level.enter_position
	return new_level


func restart_game() -> void:
	#load_level(load("res://assets/scenes/world/street.tscn"))
	get_tree().call_deferred("reload_current_scene")
	#_ready()


func add_item(item : ItemClass):
	%Level.get_child(0).add_child(item)
