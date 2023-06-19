extends BaseButton

var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var exists = false
export var color = "green"
export var type = "skill"

var global_save = load("res://Prefabs/ScriptableObjects/Global.tres")
var save_path
var save
var description

func _ready():
	description = $SkillName2.text
	match global_save.get("save"):
		1:
			save_path = "res://Saves/Save1.tres"
		2:
			save_path = "res://Saves/Save2.tres"
		3:
			save_path = "res://Saves/Save3.tres"
	save = load(save_path)
	Check()

func TurnOn():
	$SkillName2.text = str(description, "_UPGRADE_", run_data.get_skill_lvl(self.name), "_", run_data.get_skill_lvl(self.name) + 1)
	Check()
	if (exists == true):
		self.visible = true

func TurnOff():
	self.visible = false

func Check():
	var can_upgrade = false
	if run_data.get("skills").has(self.name):
		if run_data.get_skill_lvl(self.name) < 5:
			can_upgrade = true
			exists = true
	
	if can_upgrade == false:
		queue_free()

func _on_self_pressed():
	get_node("../../..").upgrade = true
	get_node("../../..").current_skill = null
	SoundPlayer.play_sound("Click")
	match type:
		"skill":
			get_node("../../..").skill_name = self.name
			get_node("../../..").ult_name = ""
			get_node("../../..").passive_name = ""
		"passive":
			get_node("../../..").skill_name = ""
			get_node("../../..").ult_name = ""
			get_node("../../..").passive_name = self.name
		"ult":
			get_node("../../..").skill_name = ""
			get_node("../../..").ult_name = self.name
			get_node("../../..").passive_name = ""
	get_node("../../../Choose").disabled = false
