extends NinePatchRect

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")

func _ready():
	if run.get(self.name) == true:
		pass
	else:
		self.visible = false
