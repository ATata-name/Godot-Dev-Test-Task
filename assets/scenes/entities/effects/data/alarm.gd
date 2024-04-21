extends EffectClass
class_name AlarmEffect


func get_effect_name() -> String:
	return "Alarm"


func activate(_arguments : Array) -> void:
	Globals.close_all_doors()
