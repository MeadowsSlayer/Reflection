extends Enemy

var HealingCD = 0

func _object_ready():
	#Main Stats
	Base_ATK = 8
	Base_DEF = 10
	Base_END = 10
	Base_SEN = 15
	Base_SPD = 10
	Base_RES = 10

	#Secondary Stats
	END = Base_END
	AVO = 7
	CRIT = 7
	maxHP = END * 15
	curHP = maxHP
	maxEN = 10

	#Resistances
	red_res = 1
	orange_res = 2
	yellow_res = 1
	green_res = 0.5
	blue_res = 0.5
	purple_res = 1
	
	tapes_reward = gen.randi_range(8, 12)
	icon = preload("res://icon.png")
	en_name = "Gunner"
	
	items_check()
	
	HPbar.max_value = maxHP
	ENbar.max_value = maxEN
	enemy_intel.set("Gunner_seen", true)
	enemy_intel.save_data()
	ATK()
	DEF()
	SPD()
	SEN()
	RES()

func ActualTurn():
	if HealingCD > 0:
		HealingCD -= 1
	
	var heal = false
	for i in range(3):
		if (get_node(str("../../Enemy", i + 1)).active == true):
			if ((get_node(str("../../Enemy", i + 1)).get_child(1).maxHP - get_node(str("../../Enemy", i + 1)).get_child(1).curHP) / (get_node(str("../../Enemy", i + 1)).get_child(1).maxHP / 100) >= 25):
				heal = true
	
	if (curEN == maxEN && sleep_duration == 0 && silence_duration == 0):
		AimedShot()
	elif (curEN != maxEN && sleep_duration == 0):
		if heal == true && HealingCD == 0 && silence_duration == 0 && save.get("rootofdespair") == false:
			HealingSkill()
		else:
			Attack()

func Attack():
	get_parent().Move()
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Attack"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		DMG += DMG
		player.Taking_Damage(DMG, "green", self, CRIT)
		curEN += 1
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)

func HealingSkill():
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Healing"
	var prioriy_target
	var minHP = 0
	var HEAL = SEN * 3
	for i in range(3):
		if (get_node(str("../../Enemy", i + 1)).active == true):
			if (get_node(str("../../Enemy", i + 1)).get_child(1).maxHP - get_node(str("../../Enemy", i + 1)).get_child(1).curHP > minHP):
				minHP = get_node(str("../../Enemy", i + 1)).get_child(1).maxHP - get_node(str("../../Enemy", i + 1)).get_child(1).curHP
				prioriy_target = i + 1
	
	if HEAL > minHP:
		HEAL = minHP
	get_node(str("../../Enemy", prioriy_target)).get_child(1).Healing(str(HEAL))
	HealingCD = 3
	curEN += 2
	if curEN > maxEN:
		curEN = maxEN

func AimedShot():
	get_parent().Move()
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Aimed Shot"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK * 2 + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, "green", self, CRIT)
		curEN = 0
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)
