extends Node

var skill_lvl

func Action():
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(216, 48, 48)
	get_parent().sound_type = "Slice"
	get_parent().get_node("StatusEffects").BloodMoon(skill_lvl)
	
	get_parent().EN_Plus(-50)
	
	get_parent().get_node("SpecialPlayer").play("BloodMoon")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SelfSpecial")
	get_parent().get_node("../../CanvasLayer/Text").text = "The moon I cherish now accepts my anguish."
	
