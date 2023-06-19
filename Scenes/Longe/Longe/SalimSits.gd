extends TextureButton

var dialogs = ["NatureOfThisPlace", "Melodramas"]
var gen = RandomNumberGenerator.new()
var dialog
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save
var save_path

func _ready():
	match global.get("save"):
		1:
			save_path = "res://Saves/Save1.tres"
		2:
			save_path = "res://Saves/Save2.tres"
		3:
			save_path = "res://Saves/Save3.tres"
	save = load(save_path)
	if save.get("runs") >= 2:
		dialogs.append("TheRoom")
	if save.get("runs") >= 3:
		dialogs.append("Repeat")
	
	if dialogs.size() == save.get("dialogs_seen").size():
		save.set("dialogs_seen", [])
		save.save_game(save_path)
	
	dialog = dialogs[gen.randi_range(0, dialogs.size() - 1)]
	while dialog in save.get("dialogs_seen"):
		dialog = dialogs[gen.randi_range(0, dialogs.size() - 1)]

func _on_SalimSits_pressed():
	if not dialog in save.get("dialogs_seen"):
		var dialogs_seen = save.get("dialogs_seen")
		dialogs_seen.append(dialog)
		save.set("dialogs_seen", dialogs_seen)
		save.save_game(save_path)
	var new_dialog = Dialogic.start(dialog)
	get_node("../../Dialog").add_child(new_dialog)
