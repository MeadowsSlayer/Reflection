extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var duration = 3
var crit_hit = false
var hit_again_chance = 0
var crit_plus = 0
var attack
var enemy
var status_effects
var HIT

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK + status_effects.PeaceOfMind(get_parent().target)
	DMG_Mod = get_parent().DMG_Mod + status_effects.GREEN_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	enemy = get_parent().get_node(str("../Enemy", get_parent().target)).get_child(1)
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("../../SpecialBG").color = Color8(12, 224, 25)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("GrowingPain")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecial")
	status_effects.GrowingPain(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "May luck be on my side!"
	
	if enemy.sleep_duration != 0:
		enemy.WakeUp()
	
	attack = int(ATK * (0.75 + 0.25 * skill_lvl))
	hit_again_chance = 50 + 10 * skill_lvl
	crit_plus = 10
	
	if skill_lvl >= 3:
		crit_plus = 15
		duration += 1
	if skill_lvl >= 4:
		hit_again_chance = 100
		attack += int(ATK * 0.1)
	if skill_lvl == 5:
		crit_plus = 20
		hit_again_chance = 120
		attack = int(ATK * 2.2)
		duration += 1

	get_parent().EN_Plus(-35)
	$Timer.start(1)

func _on_UltTimer_timeout():
	if crit_hit == true:
		hit_again_chance += crit_plus
	else:
		hit_again_chance -= 10
	
	if gen.randi_range(1, 100) <= hit_again_chance:
		crit_hit = false
		enemy.GrowingPain(attack, DMG_Mod, CRIT, DMG_add)
		$UltTimer.start(0.5)
	else:
		get_parent().get_node("SpecialPlayer").play("GrowingPainFinish")
		get_parent().get_node("../../Camera2D/AnimationPlayer").play("SoloSpecialEnd")
		enemy.get_node("../AnimationPlayer").play("MoveFinish")
		status_effects.WarningStrike_OFF()
		
		status_effects.WaitingGameNULL()
		get_parent().IterativeProcessCheck()

func _on_Timer_timeout():
	enemy.GrowingPain(attack, DMG_Mod, CRIT, DMG_add)
	enemy.get_node("../AnimationPlayer").play("MoveStart")
	$UltTimer.start(0.5)
