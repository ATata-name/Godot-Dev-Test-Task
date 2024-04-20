extends LevelClass
class_name InteriorClass

signal go_to_street


func _ready() -> void:
	level_name = name
	_ready_level()
	enter_position = $Enter.position


func connect_root(new_root : Node) -> void:
	root = new_root
	go_to_street.connect(go_to_street_from)
	

func go_to_street_from() -> void:
	root.load_level(load("res://assets/scenes/world/street.tscn"))
	

func _on_exit_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerClass:
		go_to_street.emit()
	

