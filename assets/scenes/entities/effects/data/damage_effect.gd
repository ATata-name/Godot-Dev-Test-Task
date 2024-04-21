extends EffectClass
class_name DamageEffect


func get_effect_name() -> String:
	return "Damage"


func activate(arguments : Array) -> void:
	print(arguments)
	if arguments[0] is PlayerClass:
		if arguments[1] is int:
			arguments[0].health -= arguments[1]
