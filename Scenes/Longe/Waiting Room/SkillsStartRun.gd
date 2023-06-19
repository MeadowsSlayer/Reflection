extends BaseButton

var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var global_save = load("res://Prefabs/ScriptableObjects/Global.tres")
var save_path
var save
var exists = false
var lvl = 1
export var color = "Red"
export var color_small = "red"

func _ready():
	match global_save.get("save"):
		1:
			save_path = "res://Saves/Save1.tres"
		2:
			save_path = "res://Saves/Save2.tres"
		3:
			save_path = "res://Saves/Save3.tres"
	save = load(save_path)
	CheckColorLvl()
	Check()

func CheckColorLvl():
	if save.get("current_item") == "bottleofblood" && color == "Red":
		lvl = 2

func TurnOn():
	self.visible = true

func TurnOff():
	self.visible = false

func Check():
	for i in range(save.get("known_skills").size()):
		if self.name == save.get("known_skills")[i]:
			exists = true
	
	if exists == false:
		self.disabled = true
		$SkillName2.text = "Find this skill to unlock it."
		$TextureRect.self_modulate = Color8(49, 49, 49)
	else:
		$SkillName2.text = tr(str($SkillName2.text, "_", lvl))

func _on_self_pressed():
	SoundPlayer.play_sound("Click")
	if get_node("../../../..").current == 1:
		get_node("../../../..").skill1 = self.name
		get_node("../../../..").skill1_lvl = lvl
		get_node("../../../..").colors[0] = color_small
		get_node("../../../..").skill1_icon = load(str("res://Sprites/UI/Skills/", color, "/", self.name, ".png"))
	elif get_node("../../../..").current == 2:
		get_node("../../../..").skill2 = self.name
		get_node("../../../..").skill2_lvl = lvl
		get_node("../../../..").colors[1] = color_small
		get_node("../../../..").skill2_icon = load(str("res://Sprites/UI/Skills/", color, "/", self.name, ".png"))
	elif get_node("../../../..").current == 3:
		get_node("../../../..").skill3 = self.name
		get_node("../../../..").skill3_lvl = lvl
		get_node("../../../..").colors[2] = color_small
		get_node("../../../..").skill3_icon = load(str("res://Sprites/UI/Skills/", color, "/", self.name, ".png"))
