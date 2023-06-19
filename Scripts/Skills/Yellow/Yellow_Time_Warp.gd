extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DEF
var DMG_Mod
var CRIT
var DMG_add
var target
var skill_lvl
var duration = 3
var enemy

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DEF = get_parent().DEF
	DMG_Mod = get_parent().DMG_Mod
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	target = get_parent().target
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(199, 216, 48)
	get_parent().sound_type = "TimeRewind"
	get_parent().get_node("StatusEffects").TimeWarp(skill_lvl)
	
	get_parent().EN_Plus(-40)
	
	get_parent().get_node("SpecialPlayer").play("TimeWarp")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("MassSpecial")
	get_parent().get_node("../../CanvasLayer/Text").text = "Enough with repetition of this all!"
	get_node("UltTimer").start(0.5)

func _on_UltTimer_timeout():
	var DMG = int(ATK * (0.8 + 0.2 * skill_lvl))
	match skill_lvl:
		5:
			DMG = int(ATK * 2)
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Pure_Damage(DMG, "yellow", true)
			enemy.get_node("EffectsSpecial").animation = "None"
	
	get_parent().status_effects.WaitingGameNULL()
	get_parent().status_effects.WarningStrike_OFF()
	
	get_parent().IterativeProcessCheck()
