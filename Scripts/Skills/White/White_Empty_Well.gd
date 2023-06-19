extends Node

var skill_lvl

func Action():
	skill_lvl = get_parent().skill_lvl
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	get_parent().EN_Plus(5)
	get_parent().get_node("StatusEffects").EmptyWell(skill_lvl)
