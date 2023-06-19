extends Node

var gen = RandomNumberGenerator.new()
var ATK
var target
var skill_lvl
var enemy
var status_effects

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	target = get_parent().target
	skill_lvl = get_parent().skill_lvl
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	
	get_parent().SingleAttack()
	
	var spread_stacks = enemy.spread / 5
	if spread_stacks != 0:
		if enemy.sleep_duration != 0:
			enemy.WakeUp()
		get_parent().sound_type = "Slice"
		var attack = int(ATK * (0.15 + 0.5 * skill_lvl)) * spread_stacks
		enemy.Taking_Damage(attack, 1, "green", 0, 0)
		enemy.get_node("EffectsSpecial").animation = "Poison Claw"
		enemy.spread_status = 0
		enemy.spread_duration = 0
		enemy.get_node("Control/StatusEffects/HBoxContainer/Spread").visible = false
		
		var heal
		heal = int(((attack + 1.0) * 40.0 / (10.0 + enemy.DEF)) * (0.75 + 0.25 * skill_lvl))
		get_parent().Healing(heal)
		get_parent().EN_Plus(4)
		status_effects.WarningStrike_OFF()
		status_effects.WaitingGameNULL()
		
		get_parent().IterativeProcessCheck()
	else:
		get_parent().sound_type = "Miss"
		enemy.Dodge()
		status_effects.WaitingGamePlus(get_parent().action_cost)
