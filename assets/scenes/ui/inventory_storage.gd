extends StorageControlClass

@onready var use_button : Button = $CenterContainer/VBoxContainer/Panel/HBoxContainer/buttons/Use
const item_inst = preload("res://assets/scenes/entities/items/item.tscn")


func _ready() -> void:
	super._ready()
	storage = Globals.player.inventory


func cell_selected(index : int) -> void:
	super.cell_selected(index)
	var item : ItemData = get_current_selected()
	if item != null:
		if item.effect == "":
			use_button.disabled = true
		else:
			use_button.disabled = false


func _on_button_pressed() -> void:
	var item : ItemData = get_current_selected()
	if item.consumable:
		item = use_current_selected()
	Globals.player.use(item)


func _on_drop_pressed() -> void:
	var item_data : ItemData = use_current_selected()
	var item_obj : ItemClass = item_inst.instantiate()
	item_obj.item_data = item_data
	item_obj.position = Globals.player.position
	item_obj.droped = true
	Globals.add_item(item_obj)
