extends ItemClass


func _ready() -> void:
	$Sprite2D.queue_free()


func use(player : PlayerClass) -> void:
	Globals.close_all_doors()

