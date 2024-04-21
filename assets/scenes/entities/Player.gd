extends CharacterBody2D
class_name PlayerClass

signal health_changed
signal max_health_changed
signal died
signal keys_changed

const speed : int = 400

var controlled = true

var max_health : int = 10:
	set(new_max_health):
		max_health = new_max_health
		emit_signal("max_health_changed")

var health : int = 0: 
	set(new_health):
		health = new_health
		if health > max_health:
			health = max_health
		emit_signal("health_changed")
		if health <= 0:
			emit_signal("died")

var keys : int = 0:
	set(new_keys):
		keys = new_keys
		emit_signal("keys_changed")

@onready var raycast : RayCast2D = %RayCast2D

var inventory : StorageClass = StorageClass.new()


func _ready() -> void:
	health = max_health
	Globals.player = self


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		Globals.show_inventory()


func _physics_process(_delta : float) -> void:
	if controlled:
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = direction * speed
		

		if velocity.length() == 0:
			stop_animation()
		else:
			if direction.x > 0:
				$AnimatedSprite2D.play("move_right")
				raycast.rotation_degrees = 270
			elif direction.x < 0:
				$AnimatedSprite2D.play("move_left")
				raycast.rotation_degrees = 90
			elif direction.y > 0:
				$AnimatedSprite2D.play("move_down")
				raycast.rotation_degrees = 0
			elif direction.y < 0:
				$AnimatedSprite2D.play("move_up")
				raycast.rotation_degrees = 180
		move_and_slide()
		
	else:
		stop_animation()


func stop_animation() -> void:
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 1


func use(item_data : ItemData) -> void:
	if item_data != null:
		EffectSystem.activate(item_data.effect)
