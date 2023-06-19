extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var save = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var types = []
var enemy
var status_effects
var HIT

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	var silence = status_effects.silence_duration
	HIT = gen.randi_range(1, 100) - status_effects.bind
	
	if save.get("knife") == true:
		CRIT += 10
	
	get_parent().SingleAttack()
	
	if HIT >= enemy.AVO || enemy.sleep_duration != 0 || get_parent().status_effects.BloodMoon_Duration != 0:
		if enemy.sleep_duration != 0:
			enemy.WakeUp()
		get_parent().sound_type = "Blunt Hit"
		var attack = ATK
		var type = "phys"
		var duration = 2
		var spread = 10
		var closure = 10
		var exhaust = 1 + get_parent().exhaustion_boost
		DMG_Mod += save.get("SWABB_Rank") * 0.1
		if save.get("nails") == true:
			DMG_Mod += 0.2
		if save.get("saber") == true:
			DMG_Mod += 0.5
		
		if "Green_Sprouting_From_Within" in save.get("passives") && silence == 0:
			var chance = 10 + save.get("passive_lvls")[save.get("passives").find("Green_Sprouting_From_Within")] * 5
			if save.get("passive_lvls")[save.get("passives").find("Green_Sprouting_From_Within")] >= 3:
				spread = 20
				duration = 3
			if save.get("passive_lvls")[save.get("passives").find("Green_Sprouting_From_Within")] >= 5:
				chance += 5
				spread = 30
				duration = 4
			if gen.randi_range(1, 100) <= chance:
				types.append("green")
		
		if "Yellow_Lightning_Break" in save.get("passives") && silence == 0:
			var chance = 10 + save.get("passive_lvls")[save.get("passives").find("Yellow_Lightning_Break")] * 5
			closure = 5 + 5 * save.get("passives")[save.get("passives").find("Yellow_Lightning_Break")] 
			if save.get("passive_lvls")[save.get("passives").find("Yellow_Lightning_Break")] >= 3:
				duration = 3
			if save.get("passive_lvls")[save.get("passives").find("Yellow_Lightning_Break")] >= 5:
				chance += 5
				duration = 4
			if gen.randi_range(1, 100) <= chance:
				types.append("yellow")
		
		if "Blue_Mental_Abuse" in save.get("passives") && silence == 0:
			var chance = 10 + save.get("passive_lvls")[save.get("passives").find("Blue_Mental_Abuse")] * 5
			if save.get("passive_lvls")[save.get("passives").find("Blue_Mental_Abuse")] >= 3:
				duration = 3
				exhaust = 2
			if save.get("passive_lvls")[save.get("passives").find("Blue_Mental_Abuse")] >= 5:
				exhaust = 3
			if save.get("passive_lvls")[save.get("passives").find("Blue_Mental_Abuse")] >= 5:
				chance += 5
				duration = 4
				exhaust = 4
			if gen.randi_range(1, 100) <= chance:
				types.append("blue")
		
		if types.size() >= 1:
			type = types[gen.randi_range(0, types.size() - 1)]
		
		enemy.Taking_Damage(attack, DMG_Mod, type, CRIT, DMG_add)
		
		match type:
			"green":
				enemy.Status_Effects("spread", spread, duration)
			"yellow":
				enemy.Status_Effects("closure", closure, duration)
			"blue":
				enemy.Status_Effects("exhaustion", exhaust, duration)
		
		get_parent().EN_Plus(1)
		if save.get("usedbattery") == true:
			get_parent().EN_Plus(2)
		if save.get("battery") == true:
			get_parent().EN_Plus(3)
		status_effects.WaitingGameNULL()
		status_effects.WarningStrike_OFF()
		get_parent().IterativeProcessCheck()
		DMG_Mod = status_effects.DMG_mod()
	else:
		get_parent().sound_type = "Miss"
		enemy.Dodge()
		status_effects.WaitingGamePlus(get_parent().action_cost)
	
	
