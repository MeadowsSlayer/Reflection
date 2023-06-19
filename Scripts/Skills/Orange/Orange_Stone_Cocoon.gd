extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var fragile = 0
var duration = 2
var enemy

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.ORANGE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	skill_lvl = get_parent().skill_lvl
	
	fragile = 15 + 5 * skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(224, 146, 12)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("StoneCocoon")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("MassSpecial")
	get_parent().get_node("StatusEffects").StoneCocoon(skill_lvl)
	get_parent().GainTotalBlock(1 + skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "I don't want to be hurt in the end..."
	
	get_parent().EN_Plus(-45)
	
	get_node("UltTimer").start(0.5)

func _on_UltTimer_timeout():
	var attack = int(ATK + ATK * 0.5 * skill_lvl)
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Damage(attack, DMG_Mod, "orange", CRIT, DMG_add)
			enemy.get_node("EffectsSpecial").animation = "Explosion"
	get_parent().status_effects.WarningStrike_OFF()
	get_parent().status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
