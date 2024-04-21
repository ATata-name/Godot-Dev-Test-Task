extends ItemClass


func pickup_item() -> void:
	Globals.player.keys += 1
	collected.emit(index)
	queue_free()
