extends Node

var END
var skill_lvl

func Action():
	END = get_parent().END
	skill_lvl = get_parent().skill_lvl
	get_parent().status_effects.WaitingGamePlus(get_parent().action_cost)
	get_node("../../../CanvasLayer/Animations").play("SelfSkill")
	
	get_parent().EN_Plus(3)
	var heal
	match skill_lvl:
		1:
			heal = int(END * 4)
		2:
			heal = int(END * 5)
		3:
			heal = int(END * 6)
		4:
			heal = int(END * 8)
		5:
			heal = int(END * 10)
	get_parent().Healing(heal)
	
