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
	DMG_Mod = get_parent().DMG_Mod + status_effects.BLUE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	ult_uses = get_parent().ults_num
	
	get_parent().get_node("../../SpecialBG").color = Color8(12, 90, 224)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("CycleOfSadness")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecialNormal")
	status_effects.CycleOfSadness(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "The way I live but I can't change..."
	
	fragile = (15 + 5 * skill_lvl) / 100
	if skill_lvl >= 3:
		duration += 1
	if skill_lvl >= 5:
		duration += 1
	
	get_parent().EN_Plus(-40)
	$UltTimer.start(1)

func _on_UltTimer_timeout():
	var attack = ATK + int(ATK * 0.2 * skill_lvl)
	
	if enemy.sleep_duration != 0:
		enemy.WakeUp()
	enemy.Taking_Damage(attack, DMG_Mod, "blue", CRIT, DMG_add)
	enemy.get_node("EffectsSpecial").animation = "Ice Cast"
	enemy.get_node("EffectsSpecial").modulate = Color8(255, 255, 255)
	
	for i in range(3):
		if (get_parent().get_nodel(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node_or_null(str("../Enemy", (i + 1))).get_child(1)
			if ult_uses % 2 == 0:
				enemy.Status_Effects("fragile", fragile, duration)
			else:
				enemy.curEN -= 2 + skill_lvl
	status_effects.WarningStrike_OFF()
	status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
