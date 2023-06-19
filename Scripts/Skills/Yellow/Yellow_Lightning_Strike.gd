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
		var attack = ATK + int(ATK * 0.2 * skill_lvl)
		var reset = 1
		var duration = 2
		if skill_lvl >= 3:
			duration = 3
			reset = 2
		if skill_lvl >= 5:
			reset = 3
			attack = int(ATK * 2.2)
			duration = 4
		
		enemy.Taking_Damage(attack, DMG_Mod, "yellow", CRIT, DMG_add)
		enemy.get_node("EffectsSpecial").animation = "None"
		get_parent().skills_cd_rest_mod = reset
		
		get_parent().EN_Plus(2)
		status_effects.WaitingGameNULL()
		status_effects.WarningStrike_OFF()
		get_parent().IterativeProcessCheck()
		$Timer.start(0.1)
	else:
		get_parent().sound_type = "Miss"
		enemy.Dodge()
		status_effects.WaitingGamePlus(get_parent().action_cost)
	
	

func _on_Timer_timeout():
	if enemy.curHP <= 0:
		get_parent().action_cost = 0
