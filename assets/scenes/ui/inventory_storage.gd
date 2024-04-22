extends StorageControlClass


@onready var use_button = $CenterContainer/VBoxContainer/Panel/HBoxContainer/buttons/Use


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
	var item : ItemData = use_current_selected()
