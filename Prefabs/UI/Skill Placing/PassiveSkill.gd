extends NinePatchRect

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")

func _ready():
	var passives = run.get("passives")
	var passive_lvls = run.get("passive_lvls")
	if self.name in passives:
		$Description.text = str(str(self.name).to_upper(), "_", passive_lvls[passives.find(self.name)])
		get_node("../../../..").passives += 1
	else:
		self.visible = false
