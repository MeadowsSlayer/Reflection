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
	
	get_parent().get_node("AnimationPlayer").play("Stun")
	get_node("../../../CanvasLayer/Animations").play("MassAttack")
	get_parent().sound_type = "Blunt Hit"
	
	var attack = int(ATK + ATK * 0.2 * skill_lvl)
	if skill_lvl >= 3:
		duration += 1
	if skill_lvl == 5:
		attack = ATK * 2
	
	get_parent().EN_Plus(7)
	
	for i in range(3):
		if (get_parent().get_nodel(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.get_node("EffectsSpecial").modulate = Color8(255, 255, 255)
			enemy.get_node("EffectsSpecial").animation = "Explosion"
			enemy.Taking_Damage(attack, DMG_Mod, "orange", CRIT, DMG_add)
			enemy.Status_Effects("silence", 0, duration)
	get_parent().status_effects.WarningStrike_OFF()
	get_parent().status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
