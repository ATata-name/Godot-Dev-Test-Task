extends EffectClass
class_name AddHealthEffect

#You need this because get_class() doesn't display custom class name :(
func get_effect_name() -> String:
	return "AddHealth"


func activate(arguments : Array) -> void:
	if arguments[0] is PlayerClass:
		if arguments[1] is int:
			arguments[0].health += arguments[1]
