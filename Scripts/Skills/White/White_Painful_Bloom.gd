extends Node

var gen = RandomNumberGenerator.new()
var ATK
var target
var skill_lvl
var enemies = []
var status_effects
var type
var damage

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	target = get_parent().target
	skill_lvl = get_parent().skill_lvl
	
	match skill_lvl:
			1:
				damage = 5
			2:
				damage = 7
			3:
				damage = 10
			4:
				damage = 14
			5:
				damage = 20
	
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemies.append(get_parent().get_node(str("../Enemy", (i + 1))))
	
	get_parent().get_node("AnimationPlayer").play("AttackNormal")
	get_node("../../../CanvasLayer/Animations").play("MassAttack")
	
	for enemy in enemies:
		var spread_stacks = enemy.spread / 10
		var miasma_stacks = enemy.miasma / 10
		if miasma_stacks > spread_stacks:
			type = "purple"
		elif spread_stacks > miasma_stacks:
			type = "green"
		else:
			match gen.randi_range(0, 1):
				0:
					type = "purple"
				1:
					type = "green"
	
		if spread_stacks != 0 || miasma_stacks != 0:
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			get_parent().sound_type = "Slice"
			var attack = damage * (spread_stacks + miasma_stacks)
			enemy.Taking_Pure_Damage(attack, type, true)
			match type:
				"green":
					enemy.get_node("EffectsSpecial").animation = "Poison Claw"
					enemy.get_node("EffectsSpecial").modulate = Color8(255, 255, 255)
				"purple":
					enemy.get_node("EffectsSpecial").animation = "Ice Shatter"
					enemy.get_node("EffectsSpecial").modulate = Color8(217, 10, 240)
			enemy.spread = 0
			enemy.miasma = 0
			enemy.spread_duration = 0
			enemy.miasma_duration = 0
			enemy.get_node("Control/StatusEffects/HBoxContainer/Spread").visible = false
			enemy.get_node("Control/StatusEffects/HBoxContainer/Miasma").visible = false
		
			get_parent().EN_Plus(5)
			status_effects.WaitingGamePlus(get_parent().action_cost)
		else:
			get_parent().sound_type = "Miss"
			enemy.Dodge()
			status_effects.WaitingGamePlus(get_parent().action_cost)
		
	
