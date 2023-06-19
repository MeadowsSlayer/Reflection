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
	type = get_parent().skill_color_last_used
	enemy = get_parent().get_node(str("../Enemy", target)).get_child(1)
	
	get_parent().get_node("../../SpecialBG").color = Color8(255, 255, 255)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("Regression")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecialNormal")
	get_parent().get_node("StatusEffects").Regression(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "Return to dust!"
	match type:
		"Red":
			DMG_Mod += get_parent().status_effects.RED_DMG_MOD()
			enemy.get_node("EffectsSpecial").animation = "Explosion"
			enemy.get_node("EffectsSpecial").modulate = Color8(163, 44, 35)
			type = "red"
		"Orange":
			DMG_Mod += get_parent().status_effects.ORANGE_DMG_MOD()
			enemy.get_node("EffectsSpecial").animation = "FireCast"
			type = "orange"
		"Yellow":
			DMG_Mod += get_parent().status_effects.YELLOW_DMG_MOD()
			enemy.get_node("EffectsSpecial").animation = "Star"
			type = "yellow"
		"Green":
			DMG_Mod += get_parent().status_effects.GREEN_DMG_MOD()
			enemy.get_node("EffectsSpecial").animation = "Poison Claw"
			type = "green"
		"Blue":
			DMG_Mod += get_parent().status_effects.BLUE_DMG_MOD()
			enemy.get_node("EffectsSpecial").animation = "Ice Cast"
			type = "blue"
		"Purple":
			DMG_Mod += get_parent().status_effects.PURPLE_DMG_MOD()
			enemy.get_node("EffectsSpecial").animation = "Ice Shatter"
			enemy.get_node("EffectsSpecial").modulate = Color8(141, 35, 163)
			type = "purple"
	
	get_parent().EN_Plus(-50)
	
	get_node("UltTimer").start(1)

func _on_UltTimer_timeout():
	var attack = int(ATK + ATK * (0.25 + 0.25 * skill_lvl))
	get_node(str("../../Enemy", target)).Move()
	enemy = get_parent().get_node(str("../Enemy", target)).get_child(1)
	if enemy.sleep_duration != 0:
		enemy.WakeUp()
	enemy.Taking_Damage(attack, DMG_Mod, type, CRIT, DMG_add)
	enemy.Regression(type, skill_lvl)
	
	get_parent().status_effects.WaitingGameNULL()
	get_parent().status_effects.WarningStrike_OFF()
	
	get_parent().IterativeProcessCheck()
