extends CanvasLayer

signal confirm
signal cancel

@export var player : PlayerClass
@export var message_show_time : float = 5


func _ready() -> void:
	if player:
		update_hp()
		update_keys()
		player.health_changed.connect(update_hp)
		player.max_health_changed.connect(update_hp)
		player.keys_changed.connect(update_keys)
		
	%MessageTimer.wait_time = message_show_time
	%MessageControl.visible = false
	Globals.hud = self


func show_message(text : String) -> void:
	%Message.text = text
	%MessageControl.visible = true
	%MessageTimer.start()


func _on_message_timer_timeout() -> void:
	%MessageControl.visible = false


func update_hp() -> void:
	%HP.text = "HP: " + str(player.health) + "\\" + str(player.max_health)


func update_keys() -> void:
	%Keys.text = "Keys: " + str(player.keys)


func show_confirm() -> void:
	Globals.player.controlled = false
	$Control/ConfirmWindow.visible = true
	$Control/Inventory.visible = false
	

func _on_confirm_window_no() -> void:
	cancel.emit()
	Globals.player.controlled = true
	$Control/ConfirmWindow.visible = false


func _on_confirm_window_yes() -> void:
	confirm.emit()
	Globals.player.controlled = true
	$Control/ConfirmWindow.visible = false


func show_inventory() -> void:
	if !$Control/ConfirmWindow.visible:
		$Control/Inventory.visible = !$Control/Inventory.visible
		Globals.player.controlled = !$Control/Inventory.visible
	
