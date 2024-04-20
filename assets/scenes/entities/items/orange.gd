extends ItemClass


func use(player : PlayerClass) -> void:
	player.max_health += 1
	player.health += 1
