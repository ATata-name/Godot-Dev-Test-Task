extends Node

signal update_houses
signal restart
signal added_item(item : ItemClass)

var player : PlayerClass:
	set(value):
		player = value
		player.died.connect(restart_game)
		
var hud : Node
var current_house : int = -1
var houses : Dictionary = {}
var levels : Dictionary = {}
var current_level_name : String = ""


func collect(item_index : int) -> void:
	if levels.has(current_level_name):
		levels[current_level_name].collected.append(item_index)


func close_all_doors() -> void:
	for index in houses.keys():
		houses[index].opened = false
		update_houses.emit()


func restart_game() -> void:
	restart.emit()
	houses = {}
	levels = {}
	current_level_name = ""
	current_house = -1


func show_message(text : String) -> void:
	if hud != null and hud.has_method("show_message"):
		hud.show_message(text)


func show_confirm() -> void:
	if hud.has_method("show_confirm"):
		hud.show_confirm()


func show_inventory() -> void:
	if hud.has_method("show_inventory"):
		hud.show_inventory()


func add_item(item : ItemClass) -> void:
	added_item.emit(item)
