extends Node

var SEN
var skill_lvl

func Action():
	SEN = get_parent().SEN
	skill_lvl = get_parent().skill_lvl
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	get_parent().EN_Plus(4)
	var heal = SEN * (4 + skill_lvl)
	var haste_SPD = 2 + skill_lvl
	var haste_CD
	var duration = 3
	match skill_lvl:
		1:
			haste_CD = 1
		2:
			haste_CD = 1
		3:
			haste_CD = 2
			duration = 4
		4:
			haste_CD = 2
			duration = 4
		5:
			haste_CD = 3
			duration = 5
	get_parent().Healing(heal)
	get_parent().get_node("StatusEffects").Haste(haste_SPD, haste_CD, duration)
