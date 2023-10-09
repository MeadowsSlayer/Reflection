extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var enemy

func Action():
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.PURPLE_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("AnimationPlayer").play("AttackNormal")
	get_node("../../../CanvasLayer/Animations").play("MassAttack")
	
	var attack = ATK + int(ATK * 0.1 * skill_lvl)
	get_parent().EN_Plus(8)
	get_parent().sound_type = "Blunt Hit"
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Damage(attack, DMG_Mod, "purple", CRIT, DMG_add)
			enemy.get_node("EffectsSpecial").animation = "Reverse Ice"
			enemy.get_node("EffectsSpecial").modulate = Color8(217, 10, 240)
			enemy.Status_Effects("blind", 15 + 5 * skill_lvl, 2)
	
	get_parent().status_effects.WaitingGameNULL()
	get_parent().status_effects.WarningStrike_OFF()
	
	get_parent().IterativeProcessCheck()
