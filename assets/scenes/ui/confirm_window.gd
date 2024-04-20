extends CenterContainer

signal Yes
signal No


func _ready() -> void:
	visible = false


func _on_yes_pressed() -> void:
	visible = false
	Yes.emit()


func _on_no_pressed() -> void:
	visible = false
	No.emit()
