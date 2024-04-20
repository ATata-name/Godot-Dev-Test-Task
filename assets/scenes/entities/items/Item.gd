extends Area2D
class_name ItemClass

signal collected(index)

var index = -1


func _on_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		use(body)
		collected.emit(index)
		queue_free()


func use(player : PlayerClass) -> void:
	pass
