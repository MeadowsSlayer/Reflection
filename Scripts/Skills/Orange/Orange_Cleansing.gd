extends Node

var DEF
var skill_lvl

func Action():
	DEF = get_parent().DEF
	skill_lvl = get_parent().skill_lvl
	
	var heal = DEF * (1.5 + 0.5 * skill_lvl)
	if skill_lvl == 4:
		heal = DEF * 4
	if skill_lvl == 5:
		heal = DEF * 6
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	get_parent().EN_Plus(4)
	get_parent().Healing(heal)
	get_parent().get_node("StatusEffects").Cleansing(skill_lvl)
	
