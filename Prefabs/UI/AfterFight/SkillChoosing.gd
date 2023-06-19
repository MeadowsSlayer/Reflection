extends Control

var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var group
var gen = RandomNumberGenerator.new()
var num
var skill_name
var ult_name
var passive_name
var color
var current_skill
var bonus_lvl = 0
var upgrade = false

func ChangeColor(clr):
	if run_data.get("skill_rerolls") == 0:
		$Reroll.visible = false
	else:
		$Reroll.text = str(tr("Reroll"), " x", run_data.get("skill_rerolls"))
	gen.randomize()
	color = clr
	$Choose.disabled = true
	$AnimationPlayer.play("Start")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Red", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Orange", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Green", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "White", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Yellow", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Blue", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Purple", "TurnOff")
	
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-red", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-orange", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-green", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-white", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-yellow", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-blue", "TurnOff")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "Upgrade-purple", "TurnOff")
	match clr:
		"red":
			GetSkillsByColors("red")
			if run_data.get("bottleofblood") == true:
				bonus_lvl = 1
			else:
				bonus_lvl = 0
		"green":
			GetSkillsByColors("green")
			if run_data.get("sprout") == true:
				bonus_lvl = 1
			else:
				bonus_lvl = 0
		"blue":
			GetSkillsByColors("blue")
			if run_data.get("umbrella") == true:
				bonus_lvl = 1
			else:
				bonus_lvl = 0
		"yellow":
			GetSkillsByColors("yellow")
			if run_data.get("bottledlightnings") == true:
				bonus_lvl = 1
			else:
				bonus_lvl = 0
		"orange":
			GetSkillsByColors("orange")
			if run_data.get("pieceofshield") == true:
				bonus_lvl = 1
			else:
				bonus_lvl = 0
		"purple":
			GetSkillsByColors("purple")
			if run_data.get("violet") == true:
				bonus_lvl = 1
			else:
				bonus_lvl = 0
		"white":
			GetSkillsByColors("white")
			bonus_lvl = 0

func GetSkillsByColors(color):
	group = $ScrollContainer/VBoxContainer.get_children()

	var nodes = []
	for i in group:
		if i.color == color:
			nodes.append(i)
			i.TurnOff()
	if nodes.size() <= 3:
		for i in nodes:
			i.TurnOn()
	else:
		num = GenerateSkill(nodes)
		for i in range(3):
			nodes[num[i]].TurnOn()
	
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, str("Upgrade-", color), "TurnOn")

func GenerateSkill(skills):
	var numbers = [gen.randi_range(0, skills.size() - 1), gen.randi_range(0, skills.size() - 1), gen.randi_range(0, skills.size() - 1)]
	while numbers[0] == numbers[1] || numbers[0] == numbers[2] || numbers[1] == numbers[2]:
		numbers = GenerateSkill(skills)
	return numbers

func _on_Choose_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = false
	var skill_list = run_data.get("skills")
	var skill_lvl_list = run_data.get("skills_lvls")
	var passive_list = run_data.get("passives")
	var passive_lvls = run_data.get("passive_lvls")
	
	if upgrade == false:
		skill_lvl_list.append(1 + bonus_lvl)
		if ult_name != "":
			skill_list.append(ult_name)
		elif skill_name != "":
			skill_list.append(skill_name)
			current_skill.chosen()
		elif passive_name != "":
			skill_list.append(passive_name)
			passive_list.append(passive_name)
			passive_lvls.append(1)
	else:
		var skill_index = 0
		if ult_name != "":
			for i in range(skill_list.size()):
				if skill_list[i] == ult_name:
					skill_lvl_list[i] = skill_lvl_list[i] + 1
		elif skill_name != "":
			for i in range(skill_list.size()):
				if skill_list[i] == skill_name:
					skill_lvl_list[i] = skill_lvl_list[i] + 1
		elif passive_name != "":
			for i in range(skill_list.size()):
				if skill_list[i] == passive_name:
					skill_lvl_list[i] = skill_lvl_list[i] + 1
			for i in range(passive_list.size()):
				if passive_list[i] == passive_name:
					passive_lvls[i] = passive_lvls[i] + 1
	
	run_data.set(str("max_num_of_", color), run_data.get(str("max_num_of_", color)) - 1)
	
	run_data.set("skills", skill_list)
	run_data.set("skills_lvls", skill_lvl_list)
	run_data.set("passives", passive_list)
	run_data.set("passive_lvls", passive_lvls)
	run_data.save_run()

func _on_Reroll_pressed():
	run_data.set("skill_rerolls", run_data.get("skill_rerolls") - 1)
	run_data.save_run()
	ChangeColor(color)
