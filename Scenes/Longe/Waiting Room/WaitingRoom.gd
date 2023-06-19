extends Control

var skill1
var skill2
var skill3
var skill1_lvl
var skill2_lvl
var skill3_lvl
var current
var skill1_icon
var skill2_icon
var skill3_icon
var colors = ["", "", ""]
var gen = RandomNumberGenerator.new()

var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var room = load("res://Prefabs/ScriptableObjects/Room.tres")
var cd_save = load("res://Prefabs/ScriptableObjects/CDSave.tres")

func _ready():
	cd_save.null_cd_data()
	if SoundPlayer.Check_Music("Dynamic") == false:
		SoundPlayer.stop_music()
		SoundPlayer.play_music("Dynamic")
	$SkillChoosing/Go.disabled = true

func _on_Skill1_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.visible = true
	$SkillChoosing.visible = false
	if skill1 != null:
		get_node(str("Skills/ScrollContainer/GridContainer/", skill1)).disabled = false
	current = 1

func _on_Skill2_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.visible = true
	$SkillChoosing.visible = false
	if skill2 != null:
		get_node(str("Skills/ScrollContainer/GridContainer/", skill2)).disabled = false
	current = 2

func _on_Skill3_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.visible = true
	$SkillChoosing.visible = false
	if skill3 != null:
		get_node(str("Skills/ScrollContainer/GridContainer/", skill3)).disabled = false
	current = 3

func _on_Choose_pressed():
	SoundPlayer.play_sound("Click")
	if current == 1 && skill1 != null:
		$Skills.visible = false
		$SkillChoosing.visible = true
		$SkillChoosing/CenterContainer/HBoxContainer/Skill1/TextureRect.texture = skill1_icon
		$SkillChoosing/CenterContainer/HBoxContainer/Skill1/Label.text = skill1
		$SkillChoosing/CenterContainer/HBoxContainer/Skill1/Label2.text = str(skill1.to_upper(), "_", skill1_lvl)
		get_node(str("Skills/ScrollContainer/GridContainer/", skill1)).disabled = true
	elif current == 2 && skill2 != null:
		$Skills.visible = false
		$SkillChoosing.visible = true
		$SkillChoosing/CenterContainer/HBoxContainer/Skill2/TextureRect.texture = skill2_icon
		$SkillChoosing/CenterContainer/HBoxContainer/Skill2/Label.text = skill2
		$SkillChoosing/CenterContainer/HBoxContainer/Skill2/Label2.text = str(skill2.to_upper(), "_", skill2_lvl)
		get_node(str("Skills/ScrollContainer/GridContainer/", skill2)).disabled = true
	elif current == 3 && skill3 != null:
		$Skills.visible = false
		$SkillChoosing.visible = true
		$SkillChoosing/CenterContainer/HBoxContainer/Skill3/TextureRect.texture = skill3_icon
		$SkillChoosing/CenterContainer/HBoxContainer/Skill3/Label.text = skill3
		$SkillChoosing/CenterContainer/HBoxContainer/Skill3/Label2.text = str(skill2.to_upper(), "_", skill2_lvl)
		get_node(str("Skills/ScrollContainer/GridContainer/", skill3)).disabled = true
	if skill1 != null && skill2 != null && skill3 != null && $SkillChoosing/Resistances.correct == true:
		$SkillChoosing/Go.disabled = false

func _on_Go_pressed():
	SoundPlayer.play_sound("Click")
	var save
	var save_path
	match global.get("save"):
		1:
			save = load("res://Saves/Save1.tres")
			save_path = "res://Saves/Save1.tres"
		2:
			save = load("res://Saves/Save2.tres")
			save_path = "res://Saves/Save2.tres"
		3:
			save = load("res://Saves/Save3.tres")
			save_path = "res://Saves/Save3.tres"
	
	save.set("runs", save.get("runs") + 1)
	save.set("skill1_name", skill1)
	save.set("skill2_name", skill2)
	save.set("skill3_name", skill3)
	save.set("skill4_name", "")
	save.set("skill5_name", "")
	save.set("skill6_name", "")
	var skills = [skill1, skill2, skill3, "White_White_Silence"]
	save.save_game(save_path)
	
	run.start_run(false)
	run.set("skills", skills)
	for i in range(3):
		match colors[i]:
			"green":
				run.set("max_num_of_green", run.get("max_num_of_green")- 1)
				if save.get("current_item") == "sprout":
					var skill_lvls = run.get("skills_lvls")
					skill_lvls[i] = 2
					run.set("skills_lvls", skill_lvls)
					run.save_run()
			"orange":
				run.set("max_num_of_orange", run.get("max_num_of_orange")- 1)
				if save.get("current_item") == "pieceofshield":
					var skill_lvls = run.get("skills_lvls")
					skill_lvls[i] = 2
					run.set("skills_lvls", skill_lvls)
					run.save_run()
			"blue":
				run.set("max_num_of_blue", run.get("max_num_of_blue")- 1)
				if save.get("current_item") == "umbrella":
					var skill_lvls = run.get("skills_lvls")
					skill_lvls[i] = 2
					run.set("skills_lvls", skill_lvls)
					run.save_run()
			"purple":
				run.set("max_num_of_purple", run.get("max_num_of_purple")- 1)
				if save.get("current_item") == "violet":
					var skill_lvls = run.get("skills_lvls")
					skill_lvls[i] = 2
					run.set("skills_lvls", skill_lvls)
					run.save_run()
			"red":
				run.set("max_num_of_purple", run.get("max_num_of_red")- 1)
				if save.get("current_item") == "bottleofblood":
					var skill_lvls = run.get("skills_lvls")
					skill_lvls[i] = 2
					run.set("skills_lvls", skill_lvls)
					run.save_run()
			"yellow":
				run.set("max_num_of_purple", run.get("max_num_of_yellow")- 1)
				if save.get("current_item") == "bottledlightnings":
					var skill_lvls = run.get("skills_lvls")
					skill_lvls[i] = 2
					run.set("skills_lvls", skill_lvls)
					run.save_run()
	for i in range($SkillChoosing/Resistances.ress.size()):
		run.set($SkillChoosing/Resistances.ress[i], 1)
		if i == $SkillChoosing/Resistances/HBoxContainer/Resistance1.get_selected_id():
			run.set($SkillChoosing/Resistances.ress[i], 0.5)
		elif save.get("difficulty") == "easy" && i == $SkillChoosing/Resistances/HBoxContainer/Resistance2.get_selected_id():
			run.set($SkillChoosing/Resistances.ress[i], 0.5)
		elif i == $SkillChoosing/Resistances/HBoxContainer/Weakness.get_selected_id():
			run.set($SkillChoosing/Resistances.ress[i], 2)
		elif save.get("difficulty") == "hard" && i == $SkillChoosing/Resistances/HBoxContainer/Weakness2.get_selected_id():
			run.set($SkillChoosing/Resistances.ress[i], 2)
	run.save_run()
	var rewards = ["green", "blue", "orange", "purple", "yellow", "red"]
	gen.randomize()
	room.set("current_room_reward1", rewards[gen.randi_range(0, rewards.size()) - 1])
	get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")

func _on_All_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOn")
	get_tree().call_group("Orange", "TurnOn")
	get_tree().call_group("Purple", "TurnOn")
	get_tree().call_group("Blue", "TurnOn")
	get_tree().call_group("Yellow", "TurnOn")
	get_tree().call_group("Red", "TurnOn")

func _on_Orange_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOff")
	get_tree().call_group("Red", "TurnOff")
	get_tree().call_group("Orange", "TurnOn")
	get_tree().call_group("Purple", "TurnOff")
	get_tree().call_group("Yellow", "TurnOff")
	get_tree().call_group("Red", "TurnOff")
	get_tree().call_group("Blue", "TurnOff")

func _on_Green_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOn")
	get_tree().call_group("Red", "TurnOff")
	get_tree().call_group("Yellow", "TurnOff")
	get_tree().call_group("Orange", "TurnOff")
	get_tree().call_group("Purple", "TurnOff")
	get_tree().call_group("Blue", "TurnOff")

func _on_Purple_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOff")
	get_tree().call_group("Orange", "TurnOff")
	get_tree().call_group("Purple", "TurnOn")
	get_tree().call_group("Yellow", "TurnOff")
	get_tree().call_group("Red", "TurnOff")
	get_tree().call_group("Blue", "TurnOff")

func _on_Blue_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOff")
	get_tree().call_group("Orange", "TurnOff")
	get_tree().call_group("Purple", "TurnOff")
	get_tree().call_group("Yellow", "TurnOff")
	get_tree().call_group("Red", "TurnOff")
	get_tree().call_group("Blue", "TurnOn")

func _on_Red_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOff")
	get_tree().call_group("Orange", "TurnOff")
	get_tree().call_group("Purple", "TurnOff")
	get_tree().call_group("Yellow", "TurnOff")
	get_tree().call_group("Red", "TurnOn")
	get_tree().call_group("Blue", "TurnOff")

func _on_Yellow_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().call_group("Green", "TurnOff")
	get_tree().call_group("Orange", "TurnOff")
	get_tree().call_group("Purple", "TurnOff")
	get_tree().call_group("Yellow", "TurnOn")
	get_tree().call_group("Red", "TurnOff")
	get_tree().call_group("Blue", "TurnOff")
