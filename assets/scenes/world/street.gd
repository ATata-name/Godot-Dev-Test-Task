extends LevelClass
class_name StreetClass

signal go_to_house(house, interior)


func _ready() -> void:
	level_name = "street"
	_ready_level()
	
	Globals.update_houses.connect(update_houses)
	
	enter_position = $Enter.position
	var index = 0
	for child in get_children():
		
		if child is HouseClass:
			
			child.go_to_house.connect(func (house : HouseClass, interior : PackedScene): go_to_house.emit(house, interior))

			if !Globals.houses.has(index):
				var data = HouseData.new()
				data.id = index
				data.opened = child.opened
				Globals.houses[index] = data
			child.load_data(Globals.houses[index])
			
			if index == Globals.current_house:
				enter_position = child.exit_position + child.global_position
			
			index += 1


func update_houses() -> void:
	var index = 0
	for child in get_children():
		if child is HouseClass:
			child.opened = Globals.houses[index].opened


func connect_root(new_root : Node) -> void:
	root = new_root
	go_to_house.connect(street_go_to)


func street_go_to(house : HouseClass, interior : PackedScene) -> void:
	root.load_level(interior)
