extends EffectClass
class_name AlarmEffect

#You need this because get_class() doesn't display custom class name :(
func get_effect_name() -> String:
	return "Alarm"


func activate(_arguments : Array) -> void:
	Globals.close_all_doors()
