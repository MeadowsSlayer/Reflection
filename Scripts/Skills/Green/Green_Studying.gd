extends Node

var ATK
var skill_lvl

func Action():
	ATK = get_parent().ATK
	skill_lvl = get_parent().skill_lvl
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	
	get_parent().studying = true
	get_parent().studying_attack = int(ATK * (1.5 + 0.5 * skill_lvl))
	get_parent().studying_crit = get_parent().CRIT + 45 + 5 * skill_lvl
	
	
	
	get_parent().EN_Plus(6)
