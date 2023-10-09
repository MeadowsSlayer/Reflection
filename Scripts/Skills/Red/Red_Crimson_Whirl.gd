extends Node

var gen = RandomNumberGenerator.new()
var ATK
var DMG_Mod
var CRIT
var DMG_add
var skill_lvl
var enemy
var status_effects
var HEAL

func Action():
	status_effects = get_parent().get_node("StatusEffects")
	gen.randomize()
	ATK = get_parent().ATK
	DMG_Mod = get_parent().DMG_Mod + get_parent().status_effects.RED_DMG_MOD()
	CRIT = get_parent().CRIT
	DMG_add = get_parent().DMG_add
	skill_lvl = get_parent().skill_lvl
	
	get_parent().get_node("AnimationPlayer").play("AttackNormal")
	get_node("../../../CanvasLayer/Animations").play("MassAttack")
	
	get_parent().sound_type = "Blunt Hit"
	var attack = int(ATK * (0.8 + 0.2 * skill_lvl))
	if skill_lvl == 5:
		attack = ATK * 2
	HEAL = 15 + 5 * skill_lvl
		
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.Taking_Damage(attack, DMG_Mod, "red", CRIT, DMG_add)
			enemy.get_node("EffectsSpecial").animation = "Explosion"
			enemy.get_node("EffectsSpecial").modulate = Color8(163, 44, 35)
		
	get_parent().EN_Plus(5)
	status_effects.WarningStrike_OFF()
	status_effects.WaitingGameNULL()
	
	get_parent().IterativeProcessCheck()
	$Timer.start(0.2)

func _on_Timer_timeout():
	for i in range(3):
		if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
			if get_parent().get_node(str("../Enemy", (i + 1))).get_child(1).curHP <= 0:
				get_parent().curHP += HEAL
				get_parent().SpawnHeal(HEAL)
				get_parent().get_node("../../CanvasLayer/Control/CharStats/CharHP/HP").text = str(get_parent().curHP, "/", get_parent().maxHP)
				get_parent().get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = get_parent().curHP
