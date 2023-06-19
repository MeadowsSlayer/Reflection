extends Node

var gen = RandomNumberGenerator.new()
var ENR
var skill_lvl
var shield_power = 7
var duration = 3

func Action():
	gen.randomize()
	ENR = get_parent().ENR
	skill_lvl = get_parent().skill_lvl
	
	shield_power = 6 + skill_lvl
	
	if skill_lvl == 3:
		duration = 4
	if skill_lvl == 5:
		duration = 5
		shield_power = 12
	
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	get_parent().EN_Plus(6 + get_parent().blue_skills_en_boost)
	get_parent().ClearShield()
	get_parent().sound_type = "Shield"
	get_parent().Shielding(ENR * shield_power, duration)
	get_parent().get_node("StatusEffects").mental_shield = true
	get_parent().get_node("EffectsAnimator").play("BlueShielding")
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeShield").visible = false
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/SpikedShield").visible = false
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalShield").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalShield/Num").text = str(duration)
