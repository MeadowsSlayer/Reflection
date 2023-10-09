extends Control

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var passives = 0

func _ready():
	$Skill1.texture_normal = DecideIcon(1)
	$Skill2.texture_normal = DecideIcon(2)
	$Skill3.texture_normal = DecideIcon(3)
	$Skill4.texture_normal = DecideIcon(4)
	$Skill5.texture_normal = DecideIcon(5)
	$Skill6.texture_normal = DecideIcon(6)
	$Ult.texture_normal = DecideIcon(7)

func _on_StartBattle_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = false
	get_node("../../BattleOrder").Start()
	get_node("../Control/SkillSet").visible = true
	if get_node_or_null("../BossHP") != null:
		get_node("../BossHP").visible = true

func DecideIcon(num):
	var skill_name = run.get(str("skill", num, "_name"))
	if num == 7:
		skill_name = run.get("ult_name")
	
	if skill_name != "":
		return load(load(str("res://Resources/Skills/", skill_name, ".tres")).get("icon"))
	else:
		return load("res://Sprites/UI/Skills/NoSkill.png")

func _on_Skill1_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(1)

func _on_Skill2_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(2)

func _on_Skill3_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(3)

func _on_Skill4_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(4)

func _on_Skill5_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(5)

func _on_Skill6_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(6)

func _on_Ult_pressed():
	SoundPlayer.play_sound("Click")
	$Skills.Open(7)

func turnActive(value):
	$Box1.visible = value
	$Box2.visible = value
	$SkillChoosing.visible = value
	$Skill1.visible = value
	$Skill2.visible = value
	$Skill3.visible = value
	$Skill4.visible = value
	$Skill5.visible = value
	$Skill6.visible = value
	$Ult.visible = value
	$Skills.visible = false

func _on_ActiveSkills_pressed():
	$PassiveSkillBox.visible = false
	$ItemsBox.visible = false
	turnActive(true)

func _on_PassiveSkills_pressed():
	$PassiveSkillBox.visible = true
	$ItemsBox.visible = false
	turnActive(false)

func _on_Items_pressed():
	$PassiveSkillBox.visible = false
	$ItemsBox.visible = true
	turnActive(false)
