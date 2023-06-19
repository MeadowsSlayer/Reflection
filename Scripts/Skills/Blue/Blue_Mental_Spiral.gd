extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var duration = 3
var attack
var ult_uses = 0
var mod
var enemy
var status_effects

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod + status_effects.BLUE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(12, 90, 224)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("MentalSpiral")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecialNormal")
	status_effects.MentalSpiral(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "Don't you feel tired of it all?"
	
	mod = 1
	if skill_lvl >= 3:
		mod = 2
		duration += 1
	if skill_lvl >= 5:
		mod = 3
		duration += 1
	
	get_parent().exhaustion_boost += mod
	
	get_parent().EN_Plus(-30)
	$UltTimer.start(1)

func _on_UltTimer_timeout():
	var status = 4 + get_parent().exhaustion_boost
	var attack = ATK + int(ATK * 0.2 * skill_lvl)
	
	if enemy.sleep_duration != 0:
		enemy.WakeUp()
	enemy.Taking_Damage(attack, DMG_Mod, "blue", CRIT, DMG_add)
	enemy.Status_Effects("exhaustion", status, duration)
	enemy.get_node("EffectsSpecial").animation = "Ice Cast"
	status_effects.WarningStrike_OFF()
	
	get_parent().status_effects.WaitingGameNULL()
	get_parent().IterativeProcessCheck()
