extends NinePatchRect

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
export var info = false

func _ready():
	var passives = run.get("passives")
	var passive_lvls = run.get("passive_lvls")
	if self.name in passives:
		$Description.text = str(str(self.name).to_upper(), "_", passive_lvls[passives.find(self.name)])
		if info == false:
			$"../../../NoPassives".visible = false
	else:
		self.visible = false
