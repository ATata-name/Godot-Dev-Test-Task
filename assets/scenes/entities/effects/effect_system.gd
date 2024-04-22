extends Node

const effects_path : String = "res://assets/scenes/entities/effects/data/"

var effects : Dictionary = {} ## List of all effects in the game


func _ready() -> void:
	update_effects()

	
func update_effects() -> void:
	var dir = DirAccess.open(effects_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				var effect = load(effects_path+file_name).new()
				effects[effect.get_effect_name()] = effect
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	

func parse_args(args_string : Array) -> Array:
	var args : Array = []
	var regex = RegEx.new()
	regex.compile("\\d+")
	for arg in args_string:
		if arg == "p":
			args.append(Globals.player)
		elif regex.search(arg):
			args.append(int(regex.search(arg).get_string()))
	
	return args


func activate(effect_string : String) -> void:
	
	var effect_lines = effect_string.split("\n")

	for effect in effect_lines:
		var args : Array = effect.split(" ")
		var effect_name = args[0]
		args.remove_at(0)
		
		if effects.has(effect_name):
			var new_args = parse_args(args)
			effects[effect_name].activate(new_args)
