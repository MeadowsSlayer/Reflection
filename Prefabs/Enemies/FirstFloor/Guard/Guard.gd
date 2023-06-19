extends Enemy

func _object_ready():
	#Main Stats
	Base_ATK = 7
	Base_DEF = 12
	Base_END = 9
	Base_SEN = 10
	Base_SPD = 10
	Base_RES = 10

	#Secondary Stats
	END = Base_END
	AVO = 5
	CRIT = 5
	maxHP = END * 15
	curHP = maxHP
	maxEN = 10

	#Resistances
	red_res = 0.5
	orange_res = 0.5
	yellow_res = 1
	green_res = 1
	blue_res = 2
	purple_res = 1
	
	tapes_reward = gen.randi_range(5, 8)
	icon = load("res://Sprites/Enemies/Guard/GuardBattleIcon.png")
	en_name = "Guard"
	
	items_check()
	
	HPbar.max_value = maxHP
	ENbar.max_value = maxEN
	ATK()
	DEF()
	SPD()
	SEN()
	RES()

func ActualTurn():
	if (curEN == maxEN && sleep_duration == 0 && silence_duration == 0):
		PerfectCut()
	elif (curEN != maxEN && sleep_duration == 0):
		Attack()

func Attack():
	get_parent().Move()
	get_node("AnimationPlayer").play("Attack")
	idle = false
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Attack"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, "phys", self, CRIT)
		curEN += 1
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)

func PerfectCut():
	get_parent().Move()
	get_node("AnimationPlayer").play("Attack")
	idle = false
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Supression"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK * 2 + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, "red", self, CRIT)
		player.StatusEffects(1, "silence", 1)
		curEN = 0
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)
