extends Node

var gen = RandomNumberGenerator.new()
var DEF
var skill_lvl

func Action():
	gen.randomize()
	DEF = get_parent().DEF
	skill_lvl = get_parent().skill_lvl
	
	var duration = 3
	var shield_power = int(DEF * 2 + DEF * skill_lvl)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	if skill_lvl >= 3:
		duration += 1
	if skill_lvl >= 5:
		shield_power += DEF
		duration += 1
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	
	get_parent().EN_Plus(3)
	get_parent().ClearShield()
	get_parent().sound_type = "Shield"
	get_parent().Shielding(shield_power, duration)
	get_parent().get_node("StatusEffects").spiked_shield = true
	get_parent().get_node("EffectsAnimator").play("OrangeShielding")
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeShield").visible = false
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/SpikedShield").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalShield").visible = false
