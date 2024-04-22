extends Node2D
class_name ItemClass

signal collected(index)

@export var item_data : ItemData = ItemData.new():
	set(value):
		item_data = value
		update_icon()

var index = -1
var droped = false


func _ready() -> void:
	update_icon()


func update_icon() -> void:
	if item_data != null and item_data.icon != null:
		$Sprite2D.texture = item_data.icon


func _on_area_2d_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		if !droped:
			pickup_item()
		else:
			droped = false


func pickup_item() -> void:
	if !Globals.player.inventory.is_full():
		Globals.player.inventory.add(item_data)
		collected.emit(index)
		queue_free()
