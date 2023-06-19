extends Button

var enemy_intel = load("res://Prefabs/ScriptableObjects/EnemyIntelGlobal.tres")

func _ready():
	if enemy_intel.get(str(self.name, "_seen")) == false:
		self.disabled = true
		$Label.text = "???"
		$Icon/Label.visible = true
		$Icon.modulate = Color8(0, 0, 0)
