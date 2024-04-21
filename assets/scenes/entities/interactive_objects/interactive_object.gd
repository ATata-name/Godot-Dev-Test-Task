extends Node2D

var interactable : bool = false
@export var text = "text"


func _process(_delta) -> void:
	if interactable:
		if is_player_looking() and Globals.player.controlled:
			if Input.is_action_pressed("use"):
				Globals.show_message(text)


func is_player_looking() -> bool:
	var rc : RayCast2D = Globals.player.raycast
	if rc.is_colliding():
		if rc.get_collider() == $StaticBody2D:
			return true
	return false


func _on_area_2d_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		interactable = true


func _on_area_2d_body_exited(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		interactable = false
