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
	if self.name in save.get("known_skills") || type != "skill":
		$NEW.visible = false
	Check()

func TurnOn():
	if get_node("../../..").bonus_lvl != 0:
		$SkillName2.text = str(description, "_2")
	else:
		$SkillName2.text = str(description, "_1")
	Check()
	if (exists == false):
		self.visible = true

func TurnOff():
	self.visible = false

func Check():
	if run_data.get("skills").has(self.name):
		queue_free()

func _on_self_pressed():
	SoundPlayer.play_sound("Click")
	get_node("../../..").upgrade = false
	match type:
		"skill":
			get_node("../../..").skill_name = self.name
			get_node("../../..").ult_name = ""
			get_node("../../..").passive_name = ""
			get_node("../../..").current_skill = self
		"passive":
			get_node("../../..").skill_name = ""
			get_node("../../..").ult_name = ""
			get_node("../../..").passive_name = self.name
			get_node("../../..").current_skill = null
		"ult":
			get_node("../../..").skill_name = ""
			get_node("../../..").ult_name = self.name
			get_node("../../..").passive_name = ""
			get_node("../../..").current_skill = null
	get_node("../../../Choose").disabled = false

func chosen():
	match type:
		"skill":
			if self.name in save.get("known_skills"):
				pass
			else:
				var known_skills = save.get("known_skills")
				known_skills.append(self.name)
				save.set("known_skills", known_skills)
				save.set(str("known_", color, "_skills"), save.get(str("known_", color, "_skills")) + 1)
				save.skills_known(save_path)
				save.save_game(save_path)
