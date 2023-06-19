extends Node

var gen = RandomNumberGenerator.new()
var skill_lvl
var block_num

func Action():
	skill_lvl = get_parent().skill_lvl
	if skill_lvl >= 3:
		block_num += 1
	if skill_lvl >= 4:
		block_num += 1
	if skill_lvl >= 5:
		block_num += 1
	
	get_parent().GainTotalBlock(block_num)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	
	get_parent().EN_Plus(8)
	get_parent().sound_type = "Shield"
	get_parent().get_node("EffectsAnimator").play("WhiteBlocks")
	
