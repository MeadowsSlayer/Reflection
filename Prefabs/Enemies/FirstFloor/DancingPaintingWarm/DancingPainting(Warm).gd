extends Enemy

var ProtectTheArtCD = 0
var StopTheArtistCD = 0
var CleanMind = 20

func RES():
	RES = Base_RES + mentalprotection_buff - miasma + CleanMind

func _object_ready():
	#Main Stats
	Base_ATK = 9
	Base_DEF = 12
	Base_END = 12
	Base_SEN = 8
	Base_SPD = 15
	Base_RES = 10

	#Secondary Stats
	END = Base_END
	AVO = 5
	CRIT = 4
	maxHP = END * 15
	curHP = maxHP
	maxEN = 10

	#Resistances
	red_res = 0.5
	orange_res = 0.5
	yellow_res = 1
	green_res = 1
	blue_res = 2
	purple_res = 2
	
	tapes_reward = gen.randi_range(10, 15)
	icon = preload("res://icon.png")
	en_name = "DP_Warm"
	
	items_check()
	
	HPbar.max_value = maxHP
	ENbar.max_value = maxEN
	enemy_intel.set("DP_Warm_seen", true)
	enemy_intel.save_data()
	ATK()
	DEF()
	SPD()
	SEN()
	RES()

func SwitchPassives(silence):
	if silence:
		CleanMind = 0
	else:
		CleanMind = 20
	RES()

func ActualTurn():	
	if ProtectTheArtCD > 0:
		ProtectTheArtCD -= 1
	if StopTheArtistCD > 0:
		StopTheArtistCD -= 1
	
	if (curEN == maxEN && sleep_duration == 0 && silence_duration == 0):
		ScorchingHeat()
	elif (curEN != maxEN && sleep_duration == 0):
		var skill = gen.randi_range(1, 3)
		match skill:
			1:
				Attack()
			2:
				if ProtectTheArtCD == 0 && mentalprotection_duration == 0 && silence_duration == 0:
					ProtectTheArt()
				else:
					Attack()
			3:
				if StopTheArtistCD == 0 && silence_duration == 0 && player.status_effects.closure_duration == 0:
					StopTheArtist()
				else:
					Attack()

func Attack():
	idle = false
	var damage_type
	match gen.randi_range(1, 3):
		1:
			damage_type = "orange"
		2:
			damage_type = "red"
		3:
			damage_type = "yellow"
	get_node("AnimationPlayer").play("Attack")
	get_parent().Move()
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Attack"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, damage_type, self, CRIT)
		curEN += 1
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)

func StopTheArtist():
	idle = false
	get_node("AnimationPlayer").play("Attack")
	get_parent().Move()
	StopTheArtistCD = 3
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Stop The Artist"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, "yellow", self, CRIT)
		player.StatusEffects(2, "closure", 3)
		curEN += 1
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)

func ProtectTheArt():
	idle = false
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Protection of the Art"
	for i in range(3):
		if (get_node(str("../../Enemy", i + 1)).active == true):
			get_node(str("../../Enemy", i + 1)).get_child(1).ProtectTheArtActivated()
	
	ProtectTheArtCD = 4
	curEN += 2
	if curEN > maxEN:
		curEN = maxEN

func ScorchingHeat():
	idle = false
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Scorching Heat"
	curEN = 0
	for i in range(3):
		if get_node(str("../../Enemy", i + 1)).active == true && get_node(str("../../Enemy", i + 1)) != get_parent():
			get_node(str("../../Enemy", i + 1)).get_child(1).ScorchingHeatActivated()
