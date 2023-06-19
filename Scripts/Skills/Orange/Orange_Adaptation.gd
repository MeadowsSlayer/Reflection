extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DEF
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var duration = 3
var enemy
var status_effects
var HIT

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + status_effects.ORANGE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	skill_lvl = get_parent().skill_lvl
	DEF = get_parent().DEF
	
	get_parent().get_node("../../SpecialBG").color = Color8(224, 146, 12)
	get_parent().sound_type = "Blunt Hit"
	get_parent().get_node("StatusEffects").Adaptation(skill_lvl)
	
	get_parent().EN_Plus(-30)
	
	if get_parent().shield_curHP <= 0:
		get_parent().get_node("SpecialPlayer").play("AdaptationShield")
		get_parent().get_node("../../Camera2D/AnimationPlayer").play("SelfSpecial")
		get_parent().get_node("../../CanvasLayer/Text").text = "[I] will protect [me]"
		var shield = DEF * 7 + DEF * skill_lvl
		match skill_lvl:
			3:
				duration = 4
			4:
				duration = 4
			5:
				duration = 5
		get_parent().Shielding(shield, duration)
	else:
		get_parent().get_node("SpecialPlayer").play("AdaptationAttack")
		get_parent().get_node("../../Camera2D/AnimationPlayer").play("MassSpecial")
		get_parent().get_node("../../CanvasLayer/Text").text = "I've been holding this feelings to this moment..."
		get_node("UltTimer").start(0.5)

func _on_UltTimer_timeout():
	var DMG = get_parent().shield_curHP
	match skill_lvl:
		2:
			DMG = int(get_parent().shield_curHP * 1.3)
		3:
			DMG = int(get_parent().shield_curHP * 1.5)
		4:
			DMG = int(get_parent().shield_curHP * 2)
		5:
			DMG = int(get_parent().shield_curHP * 2.5)
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Pure_Damage(DMG, "orange", true)
			enemy.get_node("EffectsSpecial").animation = "None"
	
	status_effects.WaitingGameNULL()
	status_effects.WarningStrike_OFF()
	
	get_parent().IterativeProcessCheck()
	get_parent().ClearShield()
