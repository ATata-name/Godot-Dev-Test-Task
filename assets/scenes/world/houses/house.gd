extends Node2D
class_name HouseClass

signal go_to_house(house : HouseClass, interior : PackedScene)

@onready var exit_position : Vector2 = $Exit.position

@export var interior : PackedScene
@export var opened : bool = false :
	set(value):
		opened = value
		if value:
			open()
		else:
			close()

var data : HouseData = HouseData.new()


func open() -> void:
	$Door.modulate = Color.BLACK
	upadate_data()


func close() -> void:
	$Door.modulate = Color.WHITE
	upadate_data()


func upadate_data() -> void:
	if Globals.houses.has(data.id):
		Globals.houses[data.id].opened = opened


func load_data(new_data : HouseData) -> void:
	data = new_data
	opened = data.opened
	

func _on_enter_body_entered(body : PhysicsBody2D) -> void:
	if interior:
		if body is PlayerClass:
			if !opened:
				if body.keys > 0:
					Globals.hud.confirm.connect(confirm_open)
					Globals.hud.cancel.connect(cancel_open)
					Globals.show_confirm()
				else:
					return
			else:
				open_door_and_go()


func confirm_open() -> void:
	if Globals.player.keys > 0:
		Globals.player.keys -= 1
		open_door_and_go()
	disconnect_hud()


func disconnect_hud() -> void:
	if Globals.hud.confirm.is_connected(confirm_open):
		Globals.hud.confirm.disconnect(confirm_open)
	if Globals.hud.cancel.is_connected(cancel_open):
		Globals.hud.cancel.disconnect(cancel_open)


func cancel_open() -> void:
	disconnect_hud()


func open_door_and_go() -> void:
	opened = true
	Globals.current_house = data.id
	go_to_house.emit(self,interior)
