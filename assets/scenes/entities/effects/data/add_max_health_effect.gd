extends EffectClass
class_name AddMaxHealthEffect


func get_effect_name() -> String:
	return "AddMaxHealth"


func activate(arguments : Array) -> void:
	if arguments[0] is PlayerClass:
		if arguments[1] is int:
			arguments[0].max_health += arguments[1]
