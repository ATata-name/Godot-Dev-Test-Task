extends Node

signal update_houses
signal restart

var player : PlayerClass:
	set(value):
		player = value
		player.died.connect(restart_game)
		
var hud : Node
var current_house : int = -1
var houses : Dictionary = {}
var levels : Dictionary = {}
var current_level_name = ""


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
		return hud.show_confirm()

