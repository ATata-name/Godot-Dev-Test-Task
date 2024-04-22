extends Node2D
class_name ItemClass

signal collected(index)

@export var item_data : ItemData = ItemData.new()

var index = -1


func _on_area_2d_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		pickup_item()


func pickup_item() -> void:
	if !Globals.player.inventory.is_full():
		Globals.player.inventory.add(item_data)
		collected.emit(index)
		queue_free()
