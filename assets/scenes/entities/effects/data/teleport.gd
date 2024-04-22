extends EffectClass
class_name TeleportEffect

#You need this because get_class() doesn't display custom class name :(
func get_effect_name() -> String:
	return "Teleport"


func activate(arguments : Array) -> void:
	
	if not (arguments[0] is PlayerClass):
		return
		
	if not (arguments[1] is int):
		return
		
	var player : PlayerClass= arguments[0]
	var distance : int = arguments[1]
	var dir : int = randi() % 4
	var mod : Vector2 = Vector2.ZERO
	
	var collision_size : Vector2 = player.get_collision_shape_size()
	var collision_offset : Vector2 = -player.get_collision_shape_position()
	
	match dir:
		0:
			mod.x = 1
			collision_offset.x += -collision_size.x/2
		1:
			mod.x = -1
			collision_offset.x += collision_size.x/2
		2:
			mod.y = 1
			collision_offset.y += -collision_size.y/2
		3:
			mod.y = -1
			collision_offset.y += collision_size.y/2
	
	var raycast : RayCast2D = RayCast2D.new()
	player.add_child(raycast)
	mod *= distance
	
	raycast.target_position = mod
	raycast.force_raycast_update() #You can teleport through walls without this line
	if raycast.is_colliding():
		player.position = raycast.get_collision_point() + collision_offset
	else:
		player.position += mod + collision_offset
	raycast.queue_free()
	player.move_and_slide() #You need this because otherwise the player can get stuck in the wall if they teleport along it
