extends Node
class_name StorageClass

signal state_updated
signal size_changed

var items : Array[ItemData] = []
var size : int = 5:
	set(value):
		size = value
		size_changed.emit()


func add(item : ItemData) -> bool:
	if items.size() < size:
		items.append(item)
		state_updated.emit()
		return true
	return false


func get_item(index : int) -> ItemData:
	if items.size() > index and index >= 0:
		return items[index]
	else:
		return null


func use_item(index : int) -> ItemData:
	var item : ItemData = items.pop_at(index)
	state_updated.emit()
	return item


func is_full() -> bool:
	return items.size() >= size
