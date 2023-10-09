extends Sprite

#Base Stats
var Base_ATK = 15
var Base_END = 15
var Base_DEF = 15
var Base_SEN = 10
var Base_SPD = 10
var Base_ENR = 10

#Final Stats
var ATK
var DEF
var END
var SEN
var ENR
var SPD
var RES
var turnSPD

#Resistances
var red_res = 2
var orange_res = 1
var yellow_res = 1
var green_res = 1
var blue_res = 0.5
var purple_res = 1

#Secondary Stats
var maxHP = 0
var curHP = 0
var HP_mod = 0
var maxEN
var curEN = 20
var DMG
var DMG_Mod = 1
var DMG_add = 0
var AVO = 5
var CRIT

#Shields Properties
var weakness_ignore = false
var shield_maxHP = 1
var shield_curHP = 0
var shield_duration = 0
var total_block = 0

#Skills Properties
var empty_skill = preload("res://Resources/Skills/EmptySkill.tres")
var normal_attack = preload("res://Resources/Skills/Normal_Attack.tres")
var skills = [empty_skill, empty_skill, empty_skill, empty_skill, empty_skill, empty_skill]
var skill_colors = []
var skill_levels = [0, 0, 0, 0, 0, 0]
var skills_cd = [0, 0, 0, 0, 0, 0]
var skills_cd_mod = 0
var skills_cd_rest_mod = 0
var targeting = false
var target = 1
var last_target = 0
var skill
var skill_color
var skill_type
var skill_num = 0
var action_cost = 0
var skill_lvl = 1
var skill_color_last_used

#Ult Properties
var ult
var ult_cd = 0
var ult_name = ""
var ult_lvl = 1

#Properties for Items Unlock
var crits_num = 0
var shields_num = 0
var ults_num = 0

#Skills Stuff
var hit_critical = false
var studying = false
var attacking_target
var studying_attack
var studying_crit
var timewarp_cost = 0
var unfair_game_lvl = 0
var ofitg_lvl = 0
var red_critical_line = false
var blood_moon_def_ignore = 0

#Actions Properties
var actions = 0
var actions_total = 0
var max_actions = 2
var bi_actions = 0
var bi_x = 0
var bi_y = 0
var abs_max_axtions = 0
var additional_actions = 0

#Saves
var save = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var cd_save = load("res://Prefabs/ScriptableObjects/CDSave.tres")
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save_data_path
var save_data
var dif

#Other Stuff
var damage_num = load("res://Prefabs/UI/BattleUI/Damage.tscn")
var heal_num = load("res://Prefabs/UI/BattleUI/Healing.tscn")
var miss = load("res://Prefabs/UI/BattleUI/Miss.tscn")
var icon = preload("res://Sprites/Salim/SalimIcon.png")
var gen = RandomNumberGenerator.new()
var sound_type = "Blunt Hit"
var weakness_hit = false
var turn = false
var active = true
var already_in = false
var rosecrest = false
var idle = true
var death_evasions = 0
var exhaustion_boost = 0
var blue_skills_en_boost = 0
var shield_HP_mod = 1
export var can_act = false
export var shaking = false
onready var self_target = $"../../CanvasLayer/Control/SelfTarget"
onready var status_effects = get_node("StatusEffects")
onready var Enemy1 = get_node("../Enemy1")
onready var Enemy2 = get_node("../Enemy2")
onready var Enemy3 = get_node("../Enemy3")

func _ready():
	$"../../CanvasLayer/Control".visible = false
	$"../../CanvasLayer/Background".visible = false

func LoadRunData():
	dif = save.get("dif")
	ult_name = save.get("ult_name")
	ult_lvl = save.get_skill_lvl(ult_name)
	death_evasions = save.get("death_evasions")
	
	if ResourceLoader.exists(str("res://Resources/Skills/", save.get("ult_name"), ".tres")):
		ult = load(str("res://Resources/Skills/", save.get("ult_name"), ".tres"))
	else:
		ult = null
	
	for i in range(6):
		if ResourceLoader.exists(str("res://Resources/Skills/", save.get(str("skill", i + 1, "_name")), ".tres")):
			skills[i] = load(str("res://Resources/Skills/", save.get(str("skill", i + 1, "_name")), ".tres"))
			skill_levels[i] = save.get_skill_lvl(save.get(str("skill", i + 1, "_name")))
	
	for i in range(6):
		if skill_colors.has(skills[i].color) == false && skills[i] != empty_skill:
			skill_colors.append(skills[i].color)
	status_effects.colorful_beats = save.get("colorful_beats") * skill_colors.size()
	
	curHP = save.get("curHP")
	curEN = save.get("curEN")
	HP_mod = save.get("HP_mod")
	abs_max_axtions = save.get("max_actions")
	
	Base_ATK = save.get("Base_ATK")
	Base_END = save.get("Base_END")
	Base_DEF = save.get("Base_DEF")
	Base_SEN = save.get("Base_SEN")
	Base_SPD = save.get("Base_SPD")
	Base_ENR = save.get("Base_ENR")
	SPD = Base_SPD
	
	red_res = save.get("red_res")
	green_res = save.get("green_res")
	blue_res = save.get("blue_res")
	purple_res = save.get("purple_res")
	yellow_res = save.get("yellow_res")
	orange_res = save.get("orange_res")
	
	#Common Items
	if save.get("heartpin") == true:
		HP_mod += (save.get("summ_of_stickers") / 10) * 5
	if save.get("bloodpact") == true:
		HP_mod -= 30
	if save.get("bottleofpaints") == true:
		HP_mod += 30
	
	#Uncommon Items
	if save.get("heartspin") == true:
		HP_mod += (save.get("summ_of_stickers") / 10) * 15
	if save.get("catpin") == true:
		Base_SEN += (save.get("summ_of_stickers") / 10) * 1
	if save.get("papercrane") == true:
		Base_ATK += 1 * save.get("all_rooms")
		Base_DEF += 1 * save.get("all_rooms")
		Base_END += 1 * save.get("all_rooms")
	
	#Rare Items
	if save.get("handspin") == true:
		Base_SEN += (save.get("summ_of_stickers") / 10) * 3
	if save.get("whitecrest") == true:
		var colors_arr = [0, 0, 0, 0, 0, 0]
		var conditions_met = true
		for i in skill_colors:
			match i:
				"Red":
					colors_arr[0] += 1
					if colors_arr[0] > 1:
						conditions_met = false
				"Orange":
					colors_arr[1] += 1
					if colors_arr[1] > 1:
						conditions_met = false
				"Yellow":
					colors_arr[2] += 1
					if colors_arr[2] > 1:
						conditions_met = false
				"Green":
					colors_arr[3] += 1
					if colors_arr[3] > 1:
						conditions_met = false
				"Blue":
					colors_arr[4] += 1
					if colors_arr[4] > 1:
						conditions_met = false
				"Purple":
					colors_arr[5] += 1
					if colors_arr[5] > 1:
						conditions_met = false
		
		if conditions_met == true:
			Base_ATK += 20
		else:
			Base_ATK -= 5
	if save.get("lightningcrest") == true:
		var num_of_yellow = 0
		for i in skill_colors:
			if i == "Yellow":
				num_of_yellow += 1
		
		abs_max_axtions += int(round(num_of_yellow / 2.0))
	rosecrest = save.get("rosecrest")
	if save.get("healthcrest") == true:
		HP_mod += 50
	if save.get("whirlcrest") == true:
		Base_ENR += 10
	if save.get("stonecrest") == true:
		Base_DEF += 20
		shield_HP_mod = 2

func SaveData():
	save.set("curHP", curHP)
	save.set("curEN", curEN)
	save.save_run()

func Set_Skill_Icons():
	for i in range(6):
		if skills[i].skill_code != "":
			get_node("../../CanvasLayer/Control/SkillSet").get_child(i+1).texture = load(skills[i].icon)
		else:
			get_node("../../CanvasLayer/Control/SkillSet").get_child(i+1).texture = load("res://Sprites/UI/Skills/NoSkill.png")
	
	if ult != null:
		get_node("../../CanvasLayer/Control/SkillSet").get_child(7).texture = load(ult.icon)
	else:
		get_node("../../CanvasLayer/Control/SkillSet").get_child(7).texture = load("res://Sprites/UI/Skills/NoSkill.png")

func Set_CDs():
	for i in range(6):
		if (skills_cd[i] != 0):
			get_node(str("../../CanvasLayer/Control/SkillSet/Skill", i + 1, "/SkillCD")).max_value = Skill_CD(i) - 1
			get_node(str("../../CanvasLayer/Control/SkillSet/Skill", i + 1, "/SkillCD")).visible = true
			get_node(str("../../CanvasLayer/Control/SkillSet/Skill", i + 1, "/SkillCD")).value = skills_cd[i]
			get_node(str("../../CanvasLayer/Control/SkillSet/Skill", i + 1, "/SkillCD/Label")).text = String(skills_cd[i])
		else:
			get_node(str("../../CanvasLayer/Control/SkillSet/Skill", i + 1, "/SkillCD")).visible = false

func Ult_EN():
	if ult != null:
		maxEN = ult.en
	else:
		maxEN = 0
	get_node("../../CanvasLayer/Control/SkillSet/Q/Energy").max_value = maxEN
	get_node("../../CanvasLayer/Control/SkillSet/Q/Energy").value = maxEN - curEN
	get_node("../../CanvasLayer/Control/SkillSet/Q/EN").text = str("EN: ", curEN, "/", maxEN)

func Start():
	already_in = true
	match global.get("save"):
		1:
			save_data_path = "res://Saves/Save1.tres"
		2:
			save_data_path = "res://Saves/Save2.tres"
		3:
			save_data_path = "res://Saves/Save3.tres"
	save_data = load(save_data_path)
	$AnimationPlayer.play("Idle")
	gen.randomize()
	get_node("../../CanvasLayer/Control/SelfTarget/AnimationPlayer").play("Active")
	LoadRunData()
	Set_CDs()
	Set_Skill_Icons()
	DeathEvasionCount()
	
	ATK = Base_ATK + status_effects.ATK_MOD()
	END = Base_END + status_effects.END_MOD()
	DEF = Base_DEF + status_effects.DEF_MOD()
	SEN = Base_SEN + status_effects.SEN_MOD()
	ENR = Base_ENR + status_effects.ENR_MOD()
	DMG_Mod = status_effects.DMG_mod()
	DMG_add = status_effects.DMG_ADD()
	RES = status_effects.STATUS_RES()
	CRIT = SEN/2 + status_effects.CRIT_MOD()
	AVO = status_effects.AVO_MOD() + 2 + int(SEN/3)
	maxHP = END * 15 + HP_mod
	if curHP > maxHP:
		curHP = maxHP
	DetermineSPD()
	
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").max_value = maxHP
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = curHP
	get_node("../../CanvasLayer/Control/CharStats/CharHP/HP").text = str(curHP, "/", maxHP)
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").value = shield_curHP
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").max_value = shield_maxHP
	Ult_EN()
	
	$"../../CanvasLayer/Control".visible = true
	$"../../CanvasLayer/Background".visible = true
	
	#Common Items
	if save.get("bottleofwater") == true:
		EN_Plus(7)
	if save.get("needle") == true:
		exhaustion_boost += 1
	
	#Uncommon Items
	if save.get("juice") == true:
		EN_Plus(12)
	if save.get("mike") == true:
		exhaustion_boost += 1
	if save.get("musicdisc") == true:
		blue_skills_en_boost += 1
	
	#Rare Items
	if save.get("shell") == true:
		exhaustion_boost += 4
	if save.get("chragingdevice") == true:
		blue_skills_en_boost += 2
	if save.get("whirlcrest") == true:
		for i in range(3):
			if (get_node(str("../Enemy", (i + 1))).active == true):
				get_node(str("../Enemy", (i + 1))).get_child(1).Status_Effects("exhaustion", 10, 0)

func DetermineSPD():
	SPD = Base_SPD + status_effects.SPD_MOD()
	if status_effects.bind != 0:
		SPD = int(SPD / 3)
	turnSPD = gen.randi_range(int(SPD/2), SPD)

func turn():
	timewarp_cost = 0
	get_node("../../Camera2D").position = Vector2(0, 0)
	can_act = true
	
	# Common Items
	if save.get("energydrink") == true && curEN != maxEN:
		EN_Plus(1)
	if save.get("thermos") == true && curHP != maxHP:
		Healing(10)
	
	# Uncommon Items
	if save.get("coffee") == true && curEN != maxEN:
		EN_Plus(2)
	
	# Rare Items
	if save.get("cocktail") == true && curEN != maxEN:
		EN_Plus(4)
	if save.get("oneforall") == true && curHP != maxHP:
		var enemy_num = 0
		for i in range(3):
			if (get_node("../Enemy{}".format([i+1], "{}")).active == true):
				enemy_num += 1
		
		if enemy_num > 1:
			Healing(50)
	
	status_effects.new_turn()
	get_node("../../CanvasLayer/Control/TurnOrder/AnimationPlayer").play("StartTurn")
	if (shield_duration > 0):
		shield_duration -= 1
		get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeShield/Num").text = str(shield_duration)
		get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalShield/Num").text = str(shield_duration)
		get_node("../../CanvasLayer/Control/CharStats/GridContainer/SpikedShield/Num").text = str(shield_duration)
		if (shield_duration == 0):
			ClearShield()
	
	get_node("../../CanvasLayer/Control/TurnOrder/ActionNum/Actions").text = str(max_actions + additional_actions - actions)

func _process(delta):
	if (shaking == true):
		get_node("../../Camera2D").set_offset(Vector2(rand_range(-1.0, 1.0) * 20, rand_range(-1.0, 1.0) * 1))

func Targeting():
	if (targeting == true):
		for i in range(3):
			if (get_node("../Enemy{}".format([i+1], "{}")).active == true):
				if (target == i + 1 || target == 4):
					get_node("../Enemy{}".format([i+1], "{}")).get_child(1).get_node_or_null("Control/Target").visible = true
				else:
					get_node("../Enemy{}".format([i+1], "{}")).get_child(1).get_node_or_null("Control/Target").visible = false
	else:
		for i in range(3):
			if (get_node("../Enemy{}".format([i+1], "{}")).active == true):
				get_node("../Enemy{}".format([i+1], "{}")).get_child(1).get_node_or_null("Control/Target").visible = false

func _input(event):
	if (turn == true && can_act == true):
		if (event.is_action_pressed("NA")):
			targeting = true
			target = 1
			get_node("../../Camera2D").position = Vector2(64, 0)
			self_target.visible = false
			skill = "Normal_Attack"
			skill_num = 0
			action_cost = 1
			skill_color = "None"
			Targeting()
			Skill_Description()
		if (event.is_action_pressed("skill1")):
			SkillChoosed(1, skills[0].skill_code)
		if (event.is_action_pressed("skill2")):
			SkillChoosed(2, skills[1].skill_code)
		if (event.is_action_pressed("skill3")):
			SkillChoosed(3, skills[2].skill_code)
		if (event.is_action_pressed("skill4")):
			SkillChoosed(4, skills[3].skill_code)
		if (event.is_action_pressed("skill5")):
			SkillChoosed(5, skills[4].skill_code)
		if (event.is_action_pressed("skill6")):
			SkillChoosed(6, skills[5].skill_code)
		if (event.is_action_pressed("ult")):
			Ult()
		
		if (event.is_action_pressed("end_turn")):
			action_cost = max_actions + additional_actions - actions
			skill = "skip"
			skill_color = "None"
			self_target.visible = true
			targeting = false
			target = 0
			get_node("../../Camera2D").position = Vector2(-64, 0)
			Skill_Description()
		
		if (event.is_action_pressed("cancel")):
			get_node("../../CanvasLayer/Control/TurnOrder/ActionNum/ActionCost").visible = false
			get_node("../../Camera2D").position = Vector2(0, 0)
			skill = null
			targeting = false
			self_target.visible = false
			get_node("../../CanvasLayer/Control/SkillDescription").visible = false
			action_cost = 0
			Targeting()
		if event.is_action_pressed("accept") && skill != null && turn == true:
			var accept = false
			match skill:
				ult_name:
					if curEN == maxEN && ult_cd == 0 && status_effects.silence_duration == 0:
						accept = true
				"skip":
					accept = true
				"Normal_Attack":
					accept = true
				"Orange_Cleansing":
					if skills_cd[skill_num - 1] == 0:
						accept = true
				"Red_Blood_Exchange":
					if skills_cd[skill_num - 1] == 0:
						accept = true
				"White_Empty_Well":
					if skills_cd[skill_num - 1] == 0:
						accept = true
				
				_:
					if skills_cd[skill_num - 1] == 0 && status_effects.silence_duration == 0 && action_cost <= (max_actions + additional_actions - actions):
						accept = true
			
			if accept == true:
				Skill_Activation()
			
		if (event.is_action_pressed("down") && skill != null):
			match target:
				1:
					target = 3
					get_node("../../Camera2D").position = Vector2(64, 32)
					if (Enemy3.active == false):
						target = 1
						get_node("../../Camera2D").position = Vector2(64, 0)
				2:
					target = 1
					get_node("../../Camera2D").position = Vector2(64, 0)
					if (Enemy1.active == false && Enemy3.active == true):
						target = 3
						get_node("../../Camera2D").position = Vector2(64, 32)
					elif (Enemy1.active == false && Enemy3.active == false):
						target = 2
						get_node("../../Camera2D").position = Vector2(64, -32)
				3:
					target = 3
					get_node("../../Camera2D").position = Vector2(64, 32)
			
			Targeting()
		if (event.is_action_pressed("up") && skill != null):
			match target:
				1:
					target = 2
					get_node("../../Camera2D").position = Vector2(64, -32)
					if (Enemy2.active == false):
						target = 1
						get_node("../../Camera2D").position = Vector2(64, 0)
				2:
					target = 2
					get_node("../../Camera2D").position = Vector2(64, -32)
				3:
					target = 1
					get_node("../../Camera2D").position = Vector2(64, 0)
					if (Enemy1.active == false && Enemy2.active == true):
						target = 2
						get_node("../../Camera2D").position = Vector2(64, -32)
					elif (Enemy2.active == false && Enemy1.active == false):
						target = 3
						get_node("../../Camera2D").position = Vector2(64, 32)
			
			Targeting()

func SkillChoosed(num, s_name):
	if s_name != "":
		skill_num = num
		skill = skills[num - 1].skill_code
		skill_lvl = skill_levels[num - 1]
		skill_type = skills[num - 1].type
		skill_color = skills[num - 1].color
		action_cost = skills[skill_num - 1].actions - timewarp_cost
		if action_cost < 1:
			action_cost = 1
		
		if skill_type == "self":
			self_target.visible = true
			targeting = false
			target = 0
			get_node("../../Camera2D").position = Vector2(-64, 0)
		elif skill_type == "enemy":
			self_target.visible = false
			targeting = true
			target = 1
			get_node("../../Camera2D").position = Vector2(64, 0)
		elif skill_type == "all enemies":
			self_target.visible = false
			targeting = true
			target = 4
			get_node("../../Camera2D").position = Vector2(0, 0)
		
		Targeting()
		Skill_Description()

func Ult():
	skill = ult_name
	action_cost = 0
	skill_lvl = ult_lvl
	skill_color = ult.color
	skill_type = ult.type
	if ult.type == "self":
		self_target.visible = true
		targeting = false
		target = 0
		get_node("../../Camera2D").position = Vector2(-64, 0)
	elif ult.type == "enemy":
		self_target.visible = false
		targeting = true
		target = 1
		get_node("../../Camera2D").position = Vector2(64, 0)
	elif ult.type == "all enemies":
		self_target.visible = false
		targeting = true
		target = 4
		get_node("../../Camera2D").position = Vector2(0, 0)
	
	Skill_Description()

func Skill_Description():
	get_node("../../CanvasLayer/Control/TurnOrder/ActionNum/ActionCost").visible = true
	get_node("../../CanvasLayer/Control/TurnOrder/ActionNum/ActionCost").text = str("(-", action_cost, ")")
	
	if (Enemy1.active == false && Enemy2.active == true) && target != 0 && target != 4:
		target = 2
		get_node("../../Camera2D").position = Vector2(64, -32)
	elif (Enemy1.active == false && Enemy3.active == true) && target != 0 && target != 4:
		target = 3
		get_node("../../Camera2D").position = Vector2(64, 32)
	
	Targeting()
	
	get_node("../../CanvasLayer/Control/SkillDescription").visible = true
	
	if skill != ult_name && skill != "skip" && skill != "Normal_Attack":
		if skills[skill_num - 1].type == "enemy" || skills[skill_num - 1].type == "all enemies":
			get_node("../../CanvasLayer/Control/SkillDescription").set_position(Vector2(131, 344))
		elif skills[skill_num - 1].type == "self":
			get_node("../../CanvasLayer/Control/SkillDescription").set_position(Vector2(1120, 344))
		
		get_node("../../CanvasLayer/Control/SkillDescription/SkillName").text = skills[skill_num - 1].skill_name
		get_node("../../CanvasLayer/Control/SkillDescription/SkillDescription").text = tr(str(skills[skill_num - 1].description, "_", skill_lvl))
		get_node("../../CanvasLayer/Control/SkillDescription/EnergyGiven").text = str(skills[skill_num - 1].en)
		get_node("../../CanvasLayer/Control/SkillDescription/CostNum").text = str(skills[skill_num - 1].actions)
		get_node("../../CanvasLayer/Control/SkillDescription/CDNum").text = str(skills[skill_num - 1].CD)
		get_node("../../CanvasLayer/Control/SkillDescription/SkillIcon").texture = load(skills[skill_num - 1].icon)
	
	elif skill == "Normal_Attack":
		get_node("../../CanvasLayer/Control/SkillDescription").set_position(Vector2(131, 344))
		get_node("../../CanvasLayer/Control/SkillDescription/SkillName").text = normal_attack.skill_name
		get_node("../../CanvasLayer/Control/SkillDescription/SkillDescription").text = tr(normal_attack.description)
		get_node("../../CanvasLayer/Control/SkillDescription/EnergyGiven").text = str(normal_attack.en)
		get_node("../../CanvasLayer/Control/SkillDescription/CostNum").text = str(normal_attack.actions)
		get_node("../../CanvasLayer/Control/SkillDescription/CDNum").text = str(normal_attack.CD)
		get_node("../../CanvasLayer/Control/SkillDescription/SkillIcon").texture = load(normal_attack.icon)
		
	elif skill == "skip":
		get_node("../../CanvasLayer/Control/SkillDescription").visible = true
		get_node("../../CanvasLayer/Control/SkillDescription").set_position(Vector2(1120, 344))
		get_node("../../CanvasLayer/Control/SkillDescription/SkillName").text = "End Turn"
		get_node("../../CanvasLayer/Control/SkillDescription/SkillDescription").text = "END_TURN"
		get_node("../../CanvasLayer/Control/SkillDescription/EnergyGiven").text = "AP x2"
		get_node("../../CanvasLayer/Control/SkillDescription/CostNum").text = "All"
		get_node("../../CanvasLayer/Control/SkillDescription/CDNum").text = "-"
		get_node("../../CanvasLayer/Control/SkillDescription/SkillIcon").texture = load("res://Sprites/UI/Skills/NoSkill.png")
	
	elif skill == ult_name:
		if ult.type == "enemy" || ult.type == "all enemies":
			get_node("../../CanvasLayer/Control/SkillDescription").set_position(Vector2(131, 344))
		elif ult.type == "self":
			get_node("../../CanvasLayer/Control/SkillDescription").set_position(Vector2(1120, 344))
		
		get_node("../../CanvasLayer/Control/SkillDescription/SkillName").text = ult.skill_name
		get_node("../../CanvasLayer/Control/SkillDescription/SkillDescription").text = ult.description
		get_node("../../CanvasLayer/Control/SkillDescription/EnergyGiven").text = "-"
		get_node("../../CanvasLayer/Control/SkillDescription/CostNum").text = str(ult.actions, " action")
		get_node("../../CanvasLayer/Control/SkillDescription/CDNum").text = str(ult.CD)
		get_node("../../CanvasLayer/Control/SkillDescription/SkillIcon").texture = load(ult.icon)
	
func Skill_CD(skill_num):
	if skills[skill_num].skill_name != "":
		return skills[skill_num].CD
	else:
		return 1

func Skill_Activation():
	$AnimationPlayer.stop()
	can_act = false
	self_target.visible = false
	targeting = false
	get_node("../../CanvasLayer/Control/SkillDescription").visible = false
	Targeting()
	
	if skill == ult_name:
		ults_num += 1
		if ults_num == 3:
			save_data.set("cup", true)
	
	if skill_color != "None" && skill_color != "White":
		skill_color_last_used = skill_color
	
	if skill != "skip" && skill != ult_name:
		get_node("SkillTimer").start(1.5)
	if skill != "skip":
		get_node("../../CanvasLayer/SkillUsed").visible = true
		get_node("../../CanvasLayer/SkillUsed/CenterContainer/Label").text = skill
		get_node("../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
		$ScriptPlaceholder.set_script(load(str("res://Scripts/Skills/", skill_color, "/", skill, ".gd")))
		$ScriptPlaceholder.Action()
	else:
		EN_Plus(action_cost * 2)
		status_effects.WaitingGamePlus(action_cost)
		get_node("SkillTimer").start(0.5)

func StartSpecial():
	get_node("../../CanvasLayer/AnimationsSpecial").play("SpecialStart")

func EndSpecial():
	get_node("../../CanvasLayer/AnimationsSpecial").play("SpecialEnd")

func EN_Plus(energy):
	curEN += int(energy * ENR / 10)
	if (curEN > maxEN):
		curEN = maxEN
	if (curEN < 0):
		curEN = 0
	get_node("../../CanvasLayer/Control/SkillSet/Q/Energy").value = maxEN - curEN
	get_node("../../CanvasLayer/Control/SkillSet/Q/Energy").value = maxEN - curEN
	get_node("../../CanvasLayer/Control/SkillSet/Q/EN").text = str("EN: ", curEN, "/", maxEN)

func GainTotalBlock(num):
	total_block = num
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/Block/Num").text = str(total_block)
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/Block").visible = true

func SingleAttack(attack: = "AttackNormal"):
	get_node("Movement").play("Move")
	get_node("AnimationPlayer").play(attack)
	get_node(str("../Enemy", target)).Move()
	get_node("../../CanvasLayer/Animations").play("Attack")

func TakeExhaustionDamage(num):
	EN_Plus(-num)
	num = num * 5
	if shield_curHP > 0:
		if (status_effects.mental_shield == true):
			var shield_absorbtion = num
			if (num > shield_curHP):
				shield_absorbtion = shield_curHP
			shield_absorbtion = (shield_absorbtion / 10)
			if (shield_absorbtion == 0):
				shield_absorbtion = 1
			EN_Plus(shield_absorbtion)
		var DMG_left = num - shield_curHP
		if (DMG_left < 0):
			DMG_left = 0
		shield_curHP -= num
		
		if (shield_curHP <= 0):
			ClearShield()
		curHP -= DMG_left
	else:
		if status_effects.fury_gain != 0 && status_effects.silence_duration == 0:
			status_effects.FuryCheck()
		curHP -= num
	
	get_node("../../CanvasLayer/Control/CharStats/CharHP/HP").text = str(curHP, "/", maxHP)
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = curHP
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").value = shield_curHP
	if (shield_curHP > 0):
		get_node("../../CanvasLayer/Control/CharStats/ShieldHP/ShieldHP").text = str(shield_curHP, "/", shield_maxHP)
		get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").max_value = shield_maxHP
	else:
		get_node("../../CanvasLayer/Control/CharStats/ShieldHP/ShieldHP").text = "0/0"
		get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").max_value = 1
	
	SpawnDamage(num, false)

func WeaknessCheck(type_res, dmg, dod):
	match type_res:
		2:
			if weakness_ignore == false:
				dmg = dmg * 2
				weakness_hit = true
		0.5:
			if dod == false || status_effects.DanceOfDeath_Duration == 0:
				dmg = int(dmg * 0.5)
	return dmg

func Taking_Damage(dmg, type, enemy, crit):
	var crit_success = false
	weakness_hit = false
	shaking = true
	get_node("AnimationPlayer").play("TakingDamage")
	get_node("Movement").play("Move")
	crit += status_effects.spread
	match dif:
		"easy":
			dmg -= int(dmg * 0.3)
		"hard":
			dmg += int(dmg * 0.3)
	if total_block > 0:
		type = "phys"
		total_block -= 1
		get_node("../../CanvasLayer/Control/CharStats/GridContainer/Block/Num").text = str(total_block)
		if total_block == 0:
			get_node("../../CanvasLayer/Control/CharStats/GridContainer/Block").visible = false
		dmg = 0
	match type:
		"red":
			dmg = WeaknessCheck(red_res, dmg, enemy.danceofdeath)
		"orange":
			dmg = WeaknessCheck(orange_res, dmg, enemy.danceofdeath)
		"yellow":
			dmg = WeaknessCheck(yellow_res, dmg, enemy.danceofdeath)
		"green":
			crit += status_effects.spread
			dmg = WeaknessCheck(green_res, dmg, enemy.danceofdeath)
		"blue":
			dmg = WeaknessCheck(blue_res, dmg, enemy.danceofdeath)
		"purple":
			dmg = WeaknessCheck(purple_res, dmg, enemy.danceofdeath)
	
	dmg += int(dmg * status_effects.fragile)
	
	enemy.get_parent().weakness_hit = weakness_hit
	
	if gen.randi_range(1, 100) <= crit:
		dmg = dmg * 3
		crit_success = true
	
	if shield_curHP > 0:
		if (status_effects.mental_shield == true):
			var shield_absorbtion = dmg
			if (dmg > shield_curHP):
				shield_absorbtion = shield_curHP
			shield_absorbtion = (shield_absorbtion / 10)
			if (shield_absorbtion == 0):
				shield_absorbtion = 1
			EN_Plus(shield_absorbtion)
		var DMG_left = dmg - shield_curHP
		if (DMG_left < 0):
			DMG_left = 0
		shield_curHP -= dmg
		
		if status_effects.spiked_shield == true:
			var spike_DMG = dmg - DMG_left
			enemy.Taking_Pure_Damage(spike_DMG, "orange", false)
		
		if (shield_curHP <= 0):
			ClearShield()
		curHP -= DMG_left
	else:
		if status_effects.fury_gain != 0 && status_effects.silence_duration == 0:
			status_effects.FuryCheck()
		curHP -= dmg
		if dmg != 0:
			EN_Plus(-1)
	
	get_node("../../CanvasLayer/Control/CharStats/CharHP/HP").text = str(curHP, "/", maxHP)
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = curHP
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").value = shield_curHP
	if (shield_curHP > 0):
		get_node("../../CanvasLayer/Control/CharStats/ShieldHP/ShieldHP").text = str(shield_curHP, "/", shield_maxHP)
		get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").max_value = shield_maxHP
	else:
		get_node("../../CanvasLayer/Control/CharStats/ShieldHP/ShieldHP").text = "0/0"
		get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/ShieldHP").max_value = 1
	
	SpawnDamage(dmg, crit_success)
	
func SpawnDamage(dmg, crit):
	var damage_instance = damage_num.instance()
	damage_instance.text = str(dmg)
	if crit:
		damage_instance.text = str(dmg, "!")
	damage_instance.set_position(Vector2(gen.randi_range(-40, -10), gen.randi_range(-37, 37)))
	damage_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(damage_instance)
	damage_instance.get_node("AnimationPlayer").play("Salim")

func SpawnHeal(num):
	var heal_instance = heal_num.instance()
	heal_instance.text = str("+", num)
	heal_instance.set_position(Vector2(gen.randi_range(-40, -10), gen.randi_range(-37, 37)))
	heal_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(heal_instance)
	heal_instance.get_node("AnimationPlayer").play("Salim")

func CheckHealth():
	ATK = Base_ATK + status_effects.ATK_MOD()
	
	if curHP <= 0 && death_evasions == 0:
		SoundPlayer.stop_music()
		SoundPlayer.play_music("Lose")
		get_node("../../CanvasLayer/Animations").play("GameOver")
		get_parent().queue_free()
	elif curHP <= 0 && death_evasions > 0:
		DeathEvasion()

func DeathEvasion():
	death_evasions -= 1
	save.set("death_evasions", death_evasions)
	curHP = maxHP
	get_node("../../CanvasLayer/Control/CharStats/CharHP/HP").text = str(curHP, "/", maxHP)
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = curHP
	SoundPlayer.play_sound("TimeRewind")
	DeathEvasionCount()

func DeathEvasionCount():
	for i in range($"../../CanvasLayer/Control/CharStats/DeathEvasions".get_child_count()):
		if i + 1 > save.get("death_evasions_max"):
			$"../../CanvasLayer/Control/CharStats/DeathEvasions".get_child(i).visible = false
		if i + 1 > death_evasions:
			$"../../CanvasLayer/Control/CharStats/DeathEvasions".get_child(i).texture = load("res://Sprites/UI/Battle UI/DeathEvasion.png")

func StatusEffects(num, status, time):
	var resist = gen.randi_range(1, 100)
	if status == "miasma":
		resist = 1000
	if resist > RES:
		match status:
			#Standart Aligments
			"closure":
				if status_effects.closure_duration < time:
					status_effects.closure_duration = time
				if status_effects.closure < num:
					status_effects.closure = num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Closure").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Closure/Num").text = str(status_effects.closure_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Closure/Potency").text = str(status_effects.closure)
			"silence":
				if status_effects.silence_duration < time:
					status_effects.silence_duration = time
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Silence").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Silence/Num").text = str(status_effects.silence_duration)
			"fragile":
				if status_effects.fragile_duration < time:
					status_effects.fragile_duration = time
				if status_effects.fragile < num:
					status_effects.fragile = num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fragile").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fragile/Num").text = str(status_effects.fragile_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fragile/Potency").text = str(status_effects.fragile * 100)
			"spread":
				if status_effects.spread_duration < time:
					status_effects.spread_duration = time
				status_effects.spread += num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Spread").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Spread/Num").text = str(status_effects.spread_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Spread/Potency").text = str(status_effects.spread * 100)
			"exhaustion":
				status_effects.exhaustion += num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Exhaustion").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Exhaustion/Num").text = str(status_effects.exhaustion)
			"aches":
				if status_effects.aches_duration < time:
					status_effects.aches_duration = time
				status_effects.aches += num
				DMG_Mod = status_effects.DMG_mod()
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Aches").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Aches/Num").text = str(status_effects.aches_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Aches/Potency").text = str(status_effects.aches * 100)
			"bind":
				if status_effects.bind_duration < time:
					status_effects.bind_duration = time
				if status_effects.bind < num:
					status_effects.bind = num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Bind").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Bind/Num").text = str(status_effects.bind_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Bind/Potency").text = str(status_effects.bind)
			"empowerment":
				if status_effects.empowerment_duration < time:
					status_effects.empowerment_duration = time
				status_effects.empowerment += num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Empowerment").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Empowerment/Num").text = str(status_effects.empowerment_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Empowerment/Potency").text = str(status_effects.empowerment)
			"blind":
				if status_effects.blind_duration < time:
					status_effects.blind_duration = time
				if status_effects.blind < num:
					status_effects.blind += num
				status_effects.AVO_MOD() + 2 + int(SEN/3)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Blind").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Blind/Num").text = str(status_effects.blind_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Blind/Potency").text = str(status_effects.blind)
			"miasma":
				if status_effects.miasma_duration < time:
					status_effects.miasma_duration = time
				status_effects.miasma += num
				RES = status_effects.STATUS_RES()
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Miasma").visible = true
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Miasma/Num").text = str(status_effects.miasma_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/Miasma/Potency").text = str(status_effects.miasma)
			
			#Enemy skills Aligments
			"TargetTheWeak":
				status_effects.TargetTheWeak_duration = time
				status_effects.TargetTheWeak_DEF_debuff = num
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/TargetTheWeak/Num").text = str(status_effects.TargetTheWeak_duration)
				get_node("../../CanvasLayer/Control/CharStats/GridContainer/TargetTheWeak").visible = true
				DEF = Base_DEF + status_effects.DEF_MOD()

func CriticalLine(HEAL):
	HEAL = int(HEAL * status_effects.critical_line)
	SoundPlayer.play_sound("Heal")
	$EffectsAnimator.play("Healing")
	SpawnHeal(HEAL)
	curHP += HEAL
	if (curHP > maxHP):
		curHP = maxHP

func SkillSoundPlay():
	SoundPlayer.play_sound(sound_type)
	if hit_critical == true:
		crits_num += 1
		if crits_num == 3:
			save_data.set("glasses", true)
		hit_critical = false
		SoundPlayer.play_sound("Crit")

func Shielding(shield, duration):
	shields_num += 1
	if shields_num == 3:
		save_data.set("helmet", true)
	SoundPlayer.play_sound("Heal")
	shield_maxHP = shield * shield_HP_mod
	shield_curHP = shield_maxHP
	shield_duration = duration
	get_node("AnimationPlayer").play("Shielding")
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeShield/Num").text = str(shield_duration)
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalShield/Num").text = str(shield_duration)
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/SpikedShield/Num").text = str(shield_duration)
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = curHP
	get_node("../../CanvasLayer/Control/CharStats/ShieldHP").max_value = shield_maxHP
	get_node("../../CanvasLayer/Control/CharStats/ShieldHP").value = shield_curHP
	get_node("../../CanvasLayer/Control/CharStats/ShieldHP/ShieldHP").text = str(shield_curHP, "/", shield_maxHP)

func Healing(HEAL):
	var heal_mod = 0
	if save.get("herbalistkit") == true:
		heal_mod += 0.25
	if save.get("bandages") == true:
		heal_mod += 0.5
	if save.get("firstaidkit") == true:
		heal_mod += 0.75
	
	HEAL += int(HEAL * heal_mod)
	SoundPlayer.play_sound("Heal")
	can_act = false
	get_node("AnimationPlayer").play("Healing")
	SpawnHeal(HEAL)
	curHP += HEAL
	
	if save.get("healtcrest") == true:
		for i in range(3):
			if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
				get_parent().get_node(str("../Enemy", (i + 1))).get_child(1).Taking_Pure_Damage(int(HEAL * 0.5), "green", true)
	
	if status_effects.wonderremedy_summ != 25 && save.get("wonderremedy") == true:
		status_effects.wonderremedy += 5
	ATK = Base_ATK + status_effects.ATK_MOD() + int((Base_ATK + status_effects.ATK_MOD()) * status_effects.ATK_MULT())
	SEN = Base_SEN + status_effects.SEN_MOD()
	if (curHP > maxHP):
		curHP = maxHP
	
	get_node("../../CanvasLayer/Control/CharStats/CharHP/HP").text = str(curHP, "/", maxHP)
	get_parent().get_parent().get_node("CanvasLayer/Control/CharStats/CharHP").value = curHP

func ClearShield():
	if status_effects.recoil == true && status_effects.silence_duration == 0:
		var duration = 2
		if status_effects.recoil_lvl >= 3:
			duration += 1
		if status_effects.recoil_lvl >= 5:
			duration += 1
		for i in range(3):
			if (get_parent().get_node(str("../Enemy", (i + 1))).active == true):
				get_parent().get_node(str("../Enemy", (i + 1))).get_child(1).Status_Effects("fragile", status_effects.recoil_lvl * 10 / 100, duration)
	status_effects.mental_shield = false
	status_effects.spiked_shield = false
	weakness_ignore = false
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalShield").visible = false
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeShield").visible = false
	get_node("../../CanvasLayer/Control/CharStats/GridContainer/SpikedShield").visible = false
	shield_curHP = 0

func Dodge(enemy):
	get_node("Movement").play("Move")
	var miss_instance = miss.instance()
	miss_instance.set_position(Vector2(gen.randi_range(-48, -36), gen.randi_range(-45, -23)))
	miss_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(miss_instance)
	miss_instance.get_node("AnimationPlayer").play("Salim")
	get_node("AnimationPlayer").play("Dodge")
	
	if save.get("fan") == true:
		enemy.Taking_Pure_Damage(20, "phys", true)
	if save.get("boomerang") == true:
		enemy.Taking_Pure_Damage(40, "phys", true)
	
	if status_effects.fast_reaction != 0 && status_effects.silence_duration == 0:
		match enemy.get_parent().name:
			"Enemy1":
				attacking_target = 1
			"Enemy2":
				attacking_target = 2
			"Enemy3":
				attacking_target = 3
		get_node("AnimationPlayer").play("FastReaction")

func Studying(enemy):
	get_node("Movement").play("Move")
	var miss_instance = miss.instance()
	miss_instance.set_position(Vector2(gen.randi_range(-48, -36), gen.randi_range(-45, -23)))
	miss_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(miss_instance)
	miss_instance.get_node("AnimationPlayer").play("Salim")
	studying = false
	match enemy.get_parent().name:
		"Enemy1":
			attacking_target = 1
		"Enemy2":
			attacking_target = 2
		"Enemy3":
			attacking_target = 3
	sound_type = "Miss"
	get_node("AnimationPlayer").play("Studying")

func StudyingCounterattack():
	get_node(str("../Enemy", attacking_target)).get_child(1).Taking_Damage(studying_attack, DMG_Mod + status_effects.GREEN_DMG_MOD(), "green", studying_crit, DMG_add)
	get_node(str("../Enemy", target)).get_child(1).get_node("EffectsSpecial").animation = "Poison Claw"
	sound_type = "Slice"
	if status_effects.waiting_game != 0:
		status_effects.waiting_game_summ += status_effects.waiting_game
		CRIT = SEN/2 + status_effects.CRIT_MOD()
	status_effects.WarningStrike_OFF()
	if status_effects.fast_reaction != 0 && status_effects.silence_duration == 0:
		get_node(str("../Enemy", attacking_target)).get_child(1).Taking_Damage(int(status_effects.fast_reaction * ATK / 100), DMG_Mod + status_effects.YELLOW_DMG_MOD(), "yellow", CRIT, DMG_add)

func FastReactionCounterattack():
	get_node(str("../Enemy", attacking_target)).get_child(1).Taking_Damage(int(status_effects.fast_reaction * ATK / 100), DMG_Mod + status_effects.YELLOW_DMG_MOD(), "yellow", CRIT, DMG_add)

func IterativeProcessCheck():
	var AoE = false
	if target == 4:
		AoE = true
	if last_target != target:
		status_effects.IterativeProcess(true, AoE)
	else:
		status_effects.IterativeProcess(false, AoE)
	
	if target != 4:
		last_target = target
	else:
		last_target = 0

func DamageSound():
	SoundPlayer.play_sound("Hurt")

func PlayIdle():
	$AnimationPlayer.play("Idle")

func _on_SkillTimer_timeout():
	status_effects.ItemsMultATKMod_OFF()
	skills_cd_mod = status_effects.CD_MOD()
	get_node("../../Camera2D").position = Vector2(0, 0)
	target = 1
	if (ult_cd > 0):
		ult_cd -= action_cost
		get_node("../../CanvasLayer/Control/SkillSet/Q/CD").value = ult_cd
		get_node("../../CanvasLayer/Control/SkillSet/Q/CD/CD").text = str(ult_cd)
		if ult_cd == 0:
			get_node("../../CanvasLayer/Control/SkillSet/Q/CD").visible = false
	
	save_data.actions_wasted(action_cost, save_data_path)
	
	actions += action_cost
	for i in range(6):
		if (skill_num == i+1):
			skills_cd[i] = Skill_CD(i) - skills_cd_mod
			if (skills_cd[i] <= 0):
				skills_cd[i] = 1
	for i in range(6):
		if (skills_cd[i] > 0):
			skills_cd[i] -= action_cost + skills_cd_rest_mod
			if (skills_cd[i] < 0):
				skills_cd[i] = 0
	
	skills_cd_rest_mod = 0
	Set_CDs()
	action_cost = 0
	get_node("../../CanvasLayer/Control/TurnOrder/ActionNum/ActionCost").visible = false
	get_node("../../CanvasLayer/Control/TurnOrder/ActionNum/Actions").text = str(max_actions + additional_actions - actions)
	skill = null
	skill_num = 0
	skill_lvl = 1
	if get_node("../..").enemies > 0:
		can_act = true
	if (actions == max_actions + additional_actions) || get_node("../..").enemies == 0:
		turn = false
		get_node("../../CanvasLayer/Control/TurnOrder/AnimationPlayer").play("EndTurn")
		if get_node("../..").enemies != 0:
			get_parent().play_turn()
