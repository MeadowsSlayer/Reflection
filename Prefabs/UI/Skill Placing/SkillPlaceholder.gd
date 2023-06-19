extends TextureButton

var skill = ""
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
export var num = 1

func _ready():
	if num != 7:
		skill = run.get(str("skill", num, "_name"))
	elif num == 7:
		skill = run.get("ult_name")

func ChangeIcon(icon, new_skill):
	self.texture_normal = icon
	skill = new_skill
	if num != 7:
		run.set(str("skill", num, "_name"), skill)
	else:
		run.set("ult_name", skill)
	run.save_run()
