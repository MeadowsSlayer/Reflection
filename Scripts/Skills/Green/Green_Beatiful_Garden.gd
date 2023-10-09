extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var enemy
var skill_lvl
var bind
var duration = 2

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.GREEN_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	skill_lvl = get_parent().skill_lvl
	
	bind = 25 + 5 * skill_lvl
	if skill_lvl >= 3:
		duration = 3
	if skill_lvl == 5:
		duration = 4
	
	get_parent().get_node("../../SpecialBG").color = Color8(12, 224, 25)
	get_parent().sound_type = "Blunt Hit"
	
	get_parent().get_node("SpecialPlayer").play("BeautifulGarden")
	get_parent().get_node("../../Camera2D/AnimationPlayer").play("MassSpecial")
	get_parent().status_effects.BeatifulGarden(skill_lvl)
	get_parent().get_node("../../CanvasLayer/Text").text = "The scenery I saw in dreams..."
	
	get_parent().EN_Plus(-40)
	
	get_node("UltTimer").start(0.5)

func _on_UltTimer_timeout():
	var attack = int(ATK * (1.75 + 0.25 * skill_lvl))
	for i in range(3):
		if (get_parent().get_nodel(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Damage(attack, DMG_Mod, "green", CRIT, DMG_add)
			enemy.Status_Effects("bind", bind, duration)
			enemy.get_node("EffectsSpecial").animation = "None"
			enemy.get_node("EffectsSpecial").modulate = Color8(255, 255, 255)
	get_parent().status_effects.WarningStrike_OFF()
	get_parent().status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
