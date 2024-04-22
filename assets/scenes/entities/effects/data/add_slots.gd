extends EffectClass
class_name AddSlotsEffect

#You need this because get_class() doesn't display custom class name :(
func get_effect_name() -> String:
	return "AddSlots"


func activate(arguments : Array) -> void:
	if arguments[0] is PlayerClass:
		if arguments[1] is int:
			arguments[0].inventory.size += arguments[1]
