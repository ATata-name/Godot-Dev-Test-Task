extends Panel

signal selected(index : int)

var index : int = -1


func set_item(item : ItemData) -> void:
	if item != null:
		$TextureRect.texture = item.icon
	else:
		$TextureRect.texture = null


func select() -> void:
	self_modulate = Color.BLACK


func unselect() -> void:
	self_modulate = Color.WHITE


func _on_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			select()
			selected.emit(index)
			
