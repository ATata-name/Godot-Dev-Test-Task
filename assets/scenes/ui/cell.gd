extends Panel

signal selected(index)

var index = -1


func set_item(item : ItemData) -> void:
	if item != null:
		$TextureRect.texture = item.icon
	else:
		$TextureRect.texture = null


func select():
	self_modulate = Color.BLACK


func unselect():
	self_modulate = Color.WHITE


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			select()
			selected.emit(index)
			
