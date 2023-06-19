extends Node

var skill_lvl

func Action():
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(199, 216, 48)
	get_parent().sound_type = "TimeRewind"
	get_parent().get_node("StatusEffects").BalancedInstability(skill_lvl)
	
	get_parent().EN_Plus(-35)
	
	get_parent().get_node("SpecialPlayer").play("BalancedInstability")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SelfSpecial")
	get_parent().get_node("../../CanvasLayer/Text").text = "Time to change the pacing!"
