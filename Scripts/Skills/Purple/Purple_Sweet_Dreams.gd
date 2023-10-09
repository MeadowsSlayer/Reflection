extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var attack
var enemy
var status_effects
var HIT

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.PURPLE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	HIT = gen.randi_range(1, 100) - status_effects.bind
	
	get_parent().SingleAttack()
	
	if HIT >= enemy.AVO || enemy.sleep_duration != 0 || get_parent().status_effects.BloodMoon_Duration != 0:
		if get_parent().get_node("StatusEffects").peace_of_mind_mod != 0:
			ATK += get_parent().get_node("StatusEffects").PeaceOfMind(get_parent().target)
		attack = ATK + int(ATK * 0.5 * skill_lvl)
		
		if enemy.sleep_duration != 0:
			enemy.WakeUp()
		enemy.Taking_Damage(attack, DMG_Mod, "purple", CRIT, DMG_add)
		enemy.get_node("EffectsSpecial").animation = "Reverse Ice"
		enemy.get_node("EffectsSpecial").modulate = Color8(217, 10, 240)
		enemy.Status_Effects("sleep", 0, 2)
		enemy.sleep_waking_damage = int(((attack + 1.0) * 40.0 / (10.0 + enemy.DEF) + DMG_add))
		
		get_parent().sound_type = "Blunt Hit"
		get_parent().EN_Plus(5)
		status_effects.WaitingGameNULL()
		status_effects.WarningStrike_OFF()
		get_parent().IterativeProcessCheck()
	else:
		enemy.Dodge()
		get_parent().sound_type = "Miss"
		status_effects.WaitingGamePlus(get_parent().action_cost)
	
	
