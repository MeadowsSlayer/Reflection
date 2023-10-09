extends BaseButton

export var color = "Green"
var lvl
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")

func SelfDestruct():
	if color != "None":
		queue_free()

func TurnOff():
	if color != "None":
		self.visible = false

func TurnOn():
	if color != "None":
		self.visible = true
		lvl = run.get_skill_lvl(self.name)
		$SkillName2.text = str(self.name.to_upper(), "_1")

func _on_self_pressed():
	SoundPlayer.play_sound("Click")
	if color != "None":
		$"../../..".skill_name = self.name
		$"../../..".skill_icon = load(str("res://Sprites/UI/Skills/", color, "/", self.name, ".png"))
	else:
		$"../../..".skill_name = ""
		$"../../..".skill_icon = load("res://Sprites/UI/Skills/NoSkill.png")
