extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var HIT
var skill_lvl
var enemy
var status_effects

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod + status_effects.BLUE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	HIT = gen.randi_range(1, 100) - status_effects.bind
	
	get_parent().SingleAttack()
	
	if HIT >= enemy.AVO || enemy.sleep_duration != 0 || get_parent().status_effects.BloodMoon_Duration != 0:
		get_parent().sound_type = "Blunt Hit"
		var attack = int(ATK * (0.8 + 0.2 * skill_lvl))
		var energy = 1
		var taken
		var duration = 2
		
		if skill_lvl >= 3:
			energy = 2
			duration = 3
		if skill_lvl == 5:
			energy = 3
			duration = 4
			attack = ATK * 2
		
		taken = energy
		
		if enemy.curEN > 0:
			if enemy.curEN < taken:
				taken = enemy.curEN
		else:
			taken = 0
		
		if enemy.sleep_duration != 0:
			enemy.WakeUp()
		enemy.Taking_Damage(attack, DMG_Mod, "blue", CRIT, DMG_add)
		enemy.Comatose(energy, duration)
		enemy.get_node("EffectsSpecial").animation = "None"
		status_effects.WarningStrike_OFF()
		status_effects.WaitingGameNULL()
		get_parent().EN_Plus(taken + 2 + get_parent().blue_skills_en_boost)
		get_parent().IterativeProcessCheck()
	else:
		enemy.Dodge()
		get_parent().sound_type = "Miss"
		status_effects.WaitingGamePlus(get_parent().action_cost)
	
	
	
