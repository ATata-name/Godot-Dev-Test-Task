extends Control

@onready var storage = $Storage


func _ready() -> void:
	storage.storage = Globals.player.inventory
	for button_name in ["Use","Drop"]:
		var button = Button.new()
		button.text = button_name
		storage.add_button(button)
	storage.button_changed.connect(on_button_signal)


func on_button_signal(button : Button, state : String) -> void:
	match button.text:
		"Use":
			if state == "pressed":
				var item : ItemData = storage.use_current_selected()
				Globals.player.use(item)
		"Drop":
			pass
