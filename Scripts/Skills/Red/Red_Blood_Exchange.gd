extends Node

var skill_lvl

func Action():
	skill_lvl = get_parent().skill_lvl
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	var DMG_self = int(get_parent().curHP * (0.55 - 0.05 * skill_lvl))
	if skill_lvl == 4:
		DMG_self = int(get_parent().curHP * 0.3)
	if skill_lvl == 5:
		DMG_self = int(get_parent().curHP * 0.2)
	
	get_parent().status_effects.BloodExchange(skill_lvl)
	get_parent().curHP -= DMG_self
	get_parent().SpawnDamage(DMG_self, false)
	get_parent().EN_Plus(4)
	
