extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var target
var skill_lvl
var targets = []
var attack
var attack_num = 0
var max_attacks = 0
var HIT
var bind
var type
var color_types = ["yellow", "red", "orange", "green", "blue", "purple"]
var effect_type

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	target = get_parent().target
	skill_lvl = get_parent().skill_lvl
	bind = get_parent().get_node("StatusEffects").bind
	HIT = gen.randi_range(1, 100) - bind
	max_attacks = 4 + skill_lvl
	
	get_parent().sound_type = "Blunt Hit"
	get_parent().get_node("AnimationPlayer").play("AttackNormal")
	
	type = color_types[gen.randi_range(0, 5)]
	match type:
		"red":
			DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.RED_DMG_MOD()
			effect_type = "Explosion"
		"orange":
			DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.ORANGE_DMG_MOD()
			effect_type = "FireCast"
		"yellow":
			DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.YELLOW_DMG_MOD()
			effect_type = "Star"
		"green":
			DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.GREEN_DMG_MOD()
			effect_type = "Poison Claw"
		"blue":
			DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.BLUE_DMG_MOD()
			effect_type = "Ice Cast"
		"purple":
			DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.PURPLE_DMG_MOD()
			effect_type = "Ice Shatter"
	
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			targets.append(i+1)
	
	target = targets[gen.randi_range(0, targets.size() - 1)]
	get_parent().EN_Plus(8)
	
	attack = int(ATK * (0.5 + 0.1 * skill_lvl))

	if (HIT >= get_parent().get_node(str("../Enemy", target)).get_child(1).AVO):
		attack_num += 1
		get_parent().get_node(str("../Enemy", target)).get_child(1).Taking_Damage(attack, DMG_Mod, type, CRIT, DMG_add)
		get_parent().get_node(str("../Enemy", target)).get_child(1).get_node("EffectsSpecial").animation = effect_type
		get_parent().get_node(str("../Enemy", target)).get_child(1).get_node("EffectsSpecial").modulate = Color8(255, 255, 255)
	else:
		get_parent().sound_type = "Miss"
		get_parent().get_node(str("../Enemy", target)).get_child(1).Dodge()
	
	$Timer.start(0.1)

func _on_Timer_timeout():
	if get_parent().get_node(str("../Enemy", target)).get_child(1).curHP <= 0:
		targets.erase(target)
		if targets.size() == 0:
			target = null
	
	if target != null && attack_num != max_attacks:
		type = color_types[gen.randi_range(0, 5)]
		match type:
			"red":
				DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.RED_DMG_MOD()
				effect_type = "Explosion"
			"orange":
				DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.ORANGE_DMG_MOD()
				effect_type = "FireCast"
			"yellow":
				DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.YELLOW_DMG_MOD()
				effect_type = "Star"
			"green":
				DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.GREEN_DMG_MOD()
				effect_type = "Poison Claw"
			"blue":
				DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.BLUE_DMG_MOD()
				effect_type = "Ice Cast"
			"purple":
				DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.PURPLE_DMG_MOD()
				effect_type = "Ice Shatter"
		
		$Timer.start(0.1)
		attack_num += 1
		target = targets[gen.randi_range(0, targets.size() - 1)]
		HIT = gen.randi_range(1, 100) - bind
		
		if HIT >= get_parent().get_node(str("../Enemy", target)).get_child(1).AVO || get_parent().get_node(str("../Enemy", target)).get_child(1).sleep_duration != 0 || get_parent().status_effects.BloodMoon_Duration != 0:
			if get_parent().get_node(str("../Enemy", target)).get_child(1).sleep_duration != 0:
				get_parent().get_node(str("../Enemy", target)).get_child(1).WakeUp()
			get_parent().get_node(str("../Enemy", target)).get_child(1).Taking_Damage(attack, DMG_Mod, type, CRIT, DMG_add)
			get_parent().get_node(str("../Enemy", target)).get_child(1).get_node("EffectsSpecial").animation = effect_type
		else:
			get_parent().sound_type = "Miss"
			get_parent().get_node(str("../Enemy", target)).get_child(1).Dodge()
	
	if target == null || attack_num == max_attacks:
		get_parent().status_effects.WaitingGameNULL()
		get_parent().status_effects.WarningStrike_OFF()
		
		get_parent().IterativeProcessCheck()
