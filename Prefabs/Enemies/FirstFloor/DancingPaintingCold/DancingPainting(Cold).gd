extends Enemy

var MentalProtectionCD = 0
var TargetTheWeak_CD = 0
var CleanMind = 20

func RES():
	RES = Base_RES + mentalprotection_buff - miasma + CleanMind

func _object_ready():
	#Main Stats
	Base_ATK = 7
	Base_DEF = 12
	Base_END = 10
	Base_SEN = 10
	Base_SPD = 6
	Base_RES = 10

	#Secondary Stats
	END = Base_END
	AVO = 4
	CRIT = 5
	maxHP = END * 15
	curHP = maxHP
	maxEN = 10

	#Resistances
	red_res = 2
	orange_res = 2
	yellow_res = 1
	green_res = 1
	blue_res = 0.5
	purple_res = 0.5
	
	tapes_reward = gen.randi_range(10, 15)
	icon = preload("res://icon.png")
	en_name = "DP_Cold"
	
	items_check()
	
	HPbar.max_value = maxHP
	ENbar.max_value = maxEN
	enemy_intel.set("DP_Cold_seen", true)
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
	if MentalProtectionCD > 0:
		MentalProtectionCD -= 1
	if TargetTheWeak_CD > 0:
		TargetTheWeak_CD -= 1
	
	if (curEN == maxEN && sleep_duration == 0 && silence_duration == 0):
		BurstOfEnergy()
	elif (curEN != maxEN && sleep_duration == 0):
		var skill = gen.randi_range(1, 3)
		match skill:
			1:
				Attack()
			2:
				if MentalProtectionCD == 0 && mentalprotection_duration == 0 && silence_duration == 0:
					MentalProtection()
				else:
					Attack()
			3:
				if TargetTheWeak_CD == 0 && silence_duration == 0 && player.status_effects.closure_duration == 0:
					TargetTheWeak()
				else:
					Attack()

func Attack():
	idle = false
	var damage_type
	match gen.randi_range(1, 3):
		1:
			damage_type = "blue"
		2:
			damage_type = "green"
		3:
			damage_type = "purple"
	get_parent().Move()
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Colorful Bash"
	if gen.randi_range(1, 100) >= (player.AVO + blind) && player.studying == false:
		DMG = int(((ATK + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, damage_type, self, CRIT)
		curEN += 1
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)

func TargetTheWeak():
	idle = false
	TargetTheWeak_CD = 3
	get_parent().Move()
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Target The Weak"
	if (gen.randi_range(1, 100) >= player.AVO + blind) && player.studying == false:
		DMG = int(((ATK + 1.0) * (1 + aches) * 40.0 / (10.0 + player.DEF)))
		player.Taking_Damage(DMG, "purple", self, CRIT)
		player.StatusEffects(5, "TargetTheWeak", 2)
		curEN += 1
	else:
		if player.studying == false:
			player.Dodge(self)
		else:
			player.Studying(self)

func MentalProtection():
	idle = false
	get_node("AnimationPlayer").play("Attack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Mental Protection"
	for i in range(3):
		if (get_node(str("../../Enemy", i + 1)).active == true):
			get_node(str("../../Enemy", i + 1)).get_child(1).MentalProtectionActivated()
	
	MentalProtectionCD = 4
	curEN += 2
	if curEN > maxEN:
		curEN = maxEN

func BurstOfEnergy():
	idle = false
	curEN = 0
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Busrt Of Energy"
	for i in range(3):
		if (get_node(str("../../Enemy", i + 1)).active == true && get_node(str("../../Enemy", i + 1)) != get_parent()):
			get_node(str("../../Enemy", i + 1)).get_child(1).BurstOfEnergyActivated()
