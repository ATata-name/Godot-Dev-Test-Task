extends Node2D
class_name ItemClass

signal collected(index)

@export var item_data : ItemData = ItemData.new()

var index = -1


func _on_area_2d_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		pickup_item()
		#use(body)


#func use(player : PlayerClass) -> void:
	#player.use(item_data)


func pickup_item():
	if !Globals.player.inventory.is_full():
		Globals.player.inventory.add(item_data)
		collected.emit(index)
		queue_free()
