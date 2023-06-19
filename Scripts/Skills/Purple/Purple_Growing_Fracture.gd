extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var duration = 2
var attack
var ult_uses = 0
var fragile
var enemy
var status_effects

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod + status_effects.PURPLE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	ult_uses = get_parent().ults_num
	
	get_parent().get_node("../../SpecialBG").color = Color8(12, 90, 224)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("GrowingFracture")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecialNormal")
	status_effects.GrowingFracture(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "From now on your wounds will only get bigger"
	
	fragile = (10 + 10 * skill_lvl) / 100
	if skill_lvl >= 3:
		duration += 1
	if skill_lvl >= 5:
		duration += 1
	
	get_parent().EN_Plus(-35)
	$UltTimer.start(1)

func _on_UltTimer_timeout():
	var attack = int(ATK * (1.7 + 0.3 * skill_lvl))
	
	if enemy.sleep_duration != 0:
		enemy.WakeUp()
	enemy.Taking_Damage(attack, DMG_Mod, "blue", CRIT, DMG_add)
	enemy.get_node("EffectsSpecial").animation = "Barrier"
	enemy.Status_Effects("fragile", fragile, duration)
	enemy.Status_Effects("growing_fracture", (5 + skill_lvl) / 100, duration)
	status_effects.WarningStrike_OFF()
	status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
