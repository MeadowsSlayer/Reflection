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
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.YELLOW_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	HIT = gen.randi_range(1, 100) - status_effects.bind
	
	get_parent().SingleAttack()
	
	if HIT >= enemy.AVO || enemy.sleep_duration != 0 || get_parent().status_effects.BloodMoon_Duration != 0:
		get_parent().sound_type = "Blunt Hit"
		
		var attack
		var blind_power = 10 + 10 * skill_lvl
		var duration = 3
		match skill_lvl:
			1:
				attack = int(ATK * 1.2)
			2:
				attack = int(ATK * 1.5)
			3:
				attack = int(ATK * 1.7)
				duration = 4
			4:
				attack = int(ATK * 2)
				duration = 4
			5:
				attack = int(ATK * 2.5)
				duration = 5
		
		if enemy.sleep_duration != 0:
			enemy.WakeUp()
		enemy.Taking_Damage(attack, DMG_Mod, "yellow", CRIT, DMG_add)
		enemy.get_node("EffectsSpecial").animation = "Star"
		enemy.Status_Effects("blind", blind_power, duration)
		
		get_parent().EN_Plus(5)
		status_effects.WaitingGameNULL()
		status_effects.WarningStrike_OFF()
		get_parent().IterativeProcessCheck()
	else:
		get_parent().sound_type = "Miss"
		enemy.Dodge()
		status_effects.WaitingGamePlus(get_parent().action_cost)
	
	
