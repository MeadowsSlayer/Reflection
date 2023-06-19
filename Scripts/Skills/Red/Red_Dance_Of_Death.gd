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
var enemy
var status_effects

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.RED_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	ult_uses = get_parent().ults_num
	
	get_parent().get_node("../../SpecialBG").color =  Color8(216, 48, 48)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("DanceOfDeath")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecialNormal")
	status_effects.DanceOfDeath(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "Let's give into the temptation and dance together!"
	
	get_parent().EN_Plus(-40)
	$UltTimer.start(1)

func _on_UltTimer_timeout():
	var attack = int(ATK * (1.5 + 0.5 * skill_lvl))
	if skill_lvl >= 3:
		duration += 1
	if skill_lvl == 4:
		attack = ATK * 4
	if skill_lvl == 5:
		duration += 1
		attack = ATK * 5
	
	if enemy.sleep_duration != 0:
		enemy.WakeUp()
	enemy.Taking_Damage(attack, DMG_Mod, "red", CRIT, DMG_add)
	enemy.DanceOfDeath(duration)
	enemy.get_node("EffectsSpecial").animation = "Barrier"
	
	status_effects.WarningStrike_OFF()
	status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
