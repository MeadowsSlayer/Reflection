extends Node

var gen = RandomNumberGenerator.new()
var skill_lvl
var status
var duration = 3
var enemy

func Action():
	gen.randomize()
	skill_lvl = get_parent().skill_lvl
	status =  10 + 5 * skill_lvl
	
	if skill_lvl >= 3:
		duration = 4
	if skill_lvl == 5:
		duration = 5
		status = 40
	
	get_parent().get_node("AnimationPlayer").play("AttackNormal")
	get_node("../../../CanvasLayer/Animations").play("MassAttack")
	get_parent().EN_Plus(4)
	get_parent().sound_type = "Blunt Hit"
	for i in range(3):
		if (get_parent().get_node_or_null(str("../Enemy", (i + 1))) != null):
			enemy = get_parent().get_node(str("../Enemy", (i + 1))).get_child(1)
			if enemy.sleep_duration != 0:
				enemy.WakeUp()
			enemy.ClearPositiveEffects()
			enemy.Status_Effects("miasma", status, duration)
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	
