extends BaseButton

export var color = "Green"
var lvl
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")

func SelfDestruct():
	queue_free()

func TurnOff():
	self.visible = false

func TurnOn():
	self.visible = true
	lvl = run.get_skill_lvl(self.name)
	$SkillName2.text = str(self.name.to_upper(), "_1")

func _on_self_pressed():
	SoundPlayer.play_sound("Click")
	$"../../..".skill_name = self.name
	$"../../..".skill_icon = load(str("res://Sprites/UI/Skills/", color, "/", self.name, ".png"))
