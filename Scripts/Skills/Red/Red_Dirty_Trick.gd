extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var enemy
var status_effects
var HIT

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.RED_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	HIT = gen.randi_range(1, 100) - status_effects.bind
	
	get_parent().SingleAttack()
	
	if HIT >= enemy.AVO || enemy.sleep_duration != 0 || get_parent().status_effects.BloodMoon_Duration != 0:
		get_parent().sound_type = "Blunt Hit"
		var attack = int(ATK * (0.8 + 0.2 * skill_lvl))
		var duration = 2
		var blind = 15 + 5 * skill_lvl
		if skill_lvl >= 3:
			duration = 3
		if skill_lvl == 5:
			duration = 5
			attack = ATK * 2
		
		if enemy.sleep_duration != 0:
			enemy.WakeUp()
		enemy.Taking_Damage(attack, DMG_Mod, "red", CRIT, DMG_add)
		enemy.Status_Effects("blind", blind, duration)
		enemy.get_node("EffectsSpecial").animation = "Star"
		enemy.get_node("EffectsSpecial").modulate = Color8(163, 44, 35)
		
		get_parent().EN_Plus(3)
		status_effects.WarningStrike_OFF()
		status_effects.WaitingGameNULL()
		get_parent().IterativeProcessCheck()
	else:
		get_parent().sound_type = "Miss"
		enemy.Dodge()
		status_effects.WaitingGamePlus(get_parent().action_cost)
	
	
