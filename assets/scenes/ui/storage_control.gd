extends Control

signal  button_changed(button : Button, state : String)

const cell = preload("res://assets/scenes/ui/cell.tscn")
@onready var grid = $CenterContainer/VBoxContainer/GridContainer
@onready var name_label = $CenterContainer/VBoxContainer/Panel/HBoxContainer/VBoxContainer/Name
@onready var description_label = $CenterContainer/VBoxContainer/Panel/HBoxContainer/VBoxContainer/Description
@onready var buttons = $CenterContainer/VBoxContainer/Panel/HBoxContainer/buttons

var storage : StorageClass :
	set(value):
		if storage != null and storage.state_updated.is_connected(update):
			storage.state_updated.disconnect(update)
		if storage != null and storage.size_changed.is_connected(prepare_cells):
			storage.size_changed.disconnect(prepare_cells)
		
		storage = value
		
		if !storage.state_updated.is_connected(update):
			storage.state_updated.connect(update)
		if !storage.size_changed.is_connected(prepare_cells):
			storage.size_changed.connect(prepare_cells)
			
		prepare_cells()

var selected : int = -1


func _ready() -> void:
	prepare_cells()


func prepare_cells() -> void:
	
	selected = -1
	for child in grid.get_children():
		child.queue_free()
	
	if storage != null:
		for i in range(storage.size):
			var c = cell.instantiate()
			c.index = i
			grid.add_child(c)
			c.selected.connect(cell_selected)

	disable_buttons()
	update_data()


func enable_buttons() -> void:
	for child in buttons.get_children():
		if child is Button:
			child.disabled = false


func disable_buttons() -> void:
	for child in buttons.get_children():
		if child is Button:
			child.disabled = true


func cell_selected(index : int) -> void:
	if selected != -1:
		disable_buttons()
		grid.get_child(selected).unselect()
	selected = index
	var selected_cell = grid.get_child(selected)
	selected_cell.select()
	if storage.get_item(selected) != null:
		enable_buttons()
	else:
		disable_buttons()
		
	update_data()


func update_data() -> void:
	if storage != null:
		var item_data = storage.get_item(selected)
		if item_data != null:
			set_text(item_data.name,item_data.description)
		else:
			set_empty_text()
		update()
	else:
		set_empty_text()


func set_text(new_name : String, new_description : String) -> void:
	name_label.text = new_name
	description_label.text = new_description


func set_empty_text() -> void:
	set_text("Empty", "Empty cell")


func check_current_selected():
	if storage.get_item(selected) == null:
		disable_buttons()
		set_empty_text()


func update() -> void:
	if storage != null:
		for i in range(storage.size):
			(grid.get_child(i)).set_item(storage.get_item(i))
	check_current_selected()


func add_button(button : Button) -> void:
	buttons.add_child(button)
	button.pressed.connect(func (): button_changed.emit(button,"pressed"))


func clear_buttons():
	for child in buttons.get_children():
		child.queue_free()


func get_current_selected() -> ItemData:
	return storage.get_item(selected)


func use_current_selected() -> ItemData:
	return storage.use_item(selected)
