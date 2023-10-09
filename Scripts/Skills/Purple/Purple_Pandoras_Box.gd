extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var target
var skill_lvl
var duration = 3
var enemy
var statuses = ["closure", "silence", "blind", "fragile"]
var closure_power
var blind_power
var fragile_power

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.PURPLE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	target = get_parent().target
	skill_lvl = get_parent().skill_lvl
	
	blind_power = 10 + 10 * skill_lvl
	fragile_power = blind_power / 100
	closure_power = skill_lvl * 2
	if skill_lvl >= 3:
		duration = 4
	if skill_lvl == 5:
		duration = 5
	
	get_parent().get_node("../../SpecialBG").color = Color8(216, 48, 182)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("PandorasBox")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("MassSpecial")
	get_parent().get_node("StatusEffects").PandorasBox(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "One little misfortune is only a beginning..."

	get_parent().EN_Plus(-40)
	
	get_node("UltTimer").start(0.5)

func _on_UltTimer_timeout():
	var attack = int(ATK * (0.7 + 0.3 * skill_lvl))
	for i in range(3):
		if (get_parent().get_nodel(str("../Enemy", (i + 1))).active == true):
			var status = statuses[gen.randi_range(0, statuses.size() - 1)]
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Damage(attack, DMG_Mod, "purple", CRIT, DMG_add)
			enemy.get_node("EffectsSpecial").animation = "Barrier"
			enemy.get_node("EffectsSpecial").modulate = Color8(217, 10, 240)
			enemy.Status_Effects("miasma", blind_power, duration)
			match status:
				"closure":
					enemy.Status_Effects("closure", closure_power, duration)
				"blind":
					enemy.Status_Effects("blind", blind_power, duration)
				"fragile":
					enemy.Status_Effects("fragile", fragile_power, duration)
				"silence":
					enemy.Status_Effects("silence", 0, duration)

	get_parent().status_effects.WaitingGameNULL()
	get_parent().status_effects.WarningStrike_OFF()
	
	get_parent().IterativeProcessCheck()
