extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var target
var skill_lvl
var fragile = 0
var duration = 2
var types = ["red", "orange", "yellow", "green", "blue", "purple"]
var type
var enemy

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	target = get_parent().target
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(255, 255, 255)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("WhiteSilence")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("MassSpecial")
	get_parent().get_node("StatusEffects").WhiteSilence(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "Just disappear!"
	type = types[gen.randi_range(0, types.size() - 1)]
	match type:
		"red":
			DMG_Mod += get_parent().status_effects.RED_DMG_MOD()
			$"../EffectsSpecial".animation = "Explosion"
			$"../EffectsSpecial".modulate = Color8(163, 44, 35)
		"orange":
			DMG_Mod += get_parent().status_effects.ORANGE_DMG_MOD()
			$"../EffectsSpecial".animation = "FireCast"
			$"../EffectsSpecial".modulate = Color8(255, 255, 255)
		"yellow":
			DMG_Mod += get_parent().status_effects.YELLOW_DMG_MOD()
			$"../EffectsSpecial".animation = "Star"
			$"../EffectsSpecial".modulate = Color8(255, 255, 255)
		"green":
			DMG_Mod += get_parent().status_effects.GREEN_DMG_MOD()
			$"../EffectsSpecial".animation = "Poison Claw"
			$"../EffectsSpecial".modulate = Color8(255, 255, 255)
		"blue":
			DMG_Mod += get_parent().status_effects.BLUE_DMG_MOD()
			$"../EffectsSpecial".animation = "Ice Cast"
			$"../EffectsSpecial".modulate = Color8(255, 255, 255)
		"purple":
			DMG_Mod += get_parent().status_effects.PURPLE_DMG_MOD()
			$"../EffectsSpecial".animation = "Ice Shatter"
			$"../EffectsSpecial".modulate = Color8(141, 35, 163)
	
	get_parent().EN_Plus(-30)
	
	get_node("UltTimer").start(0.5)

func _on_UltTimer_timeout():
	var attack = int(ATK + ATK * 0.5 * skill_lvl)
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Damage(attack, DMG_Mod, type, CRIT, DMG_add)
			enemy.get_node("EffectsSpecial").animation = "None"
				
	get_parent().status_effects.WaitingGameNULL()
	get_parent().status_effects.WarningStrike_OFF()
	
	get_parent().IterativeProcessCheck()
