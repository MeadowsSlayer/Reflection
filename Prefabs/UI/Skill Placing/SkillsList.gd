extends Control

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var skill_num
var skill_name
var skill_icon

func _ready():
	for i in $ScrollContainer/VBoxContainer.get_children():
		var check = false
		for c in run.get("skills"):
			if i.name == c:
				check = true
		if check == false:
			i.SelfDestruct()

func Open(num):
	skill_name = ""
	skill_num = num
	self.visible = true
	var ready_skills = []
	for i in range(7):
		if i+1 < 7:
			ready_skills.append(get_node(str("../Skill", i+1)).skill)
		else:
			ready_skills.append(get_node("../Ult").skill)
	
	if num == 7:
		get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME,"Not-Ult", "TurnOff")
		get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME,"Ult", "TurnOn")
	else:
		get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME,"Not-Ult", "TurnOn")
		get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME,"Ult", "TurnOff")
	
	for i in $ScrollContainer/VBoxContainer.get_children():
		for c in ready_skills:
			if i.name == c:
				i.visible = false
		

func _on_Choose_pressed():
	SoundPlayer.play_sound("Click")
	var skill = str("../Skill", skill_num)
	if skill_num == 7:
		skill = "../Ult"
	if skill_name != "":
		get_node(skill).ChangeIcon(skill_icon, skill_name)
	self.visible = false
