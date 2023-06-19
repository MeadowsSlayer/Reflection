extends TextureRect

var tapes = 0
var current_tapes
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save_path
var save

func _ready():
	if (global.get("save") == 1):
		save_path = "res://Saves/Save1.tres"
	elif (global.get("save") == 2):
		save_path = "res://Saves/Save2.tres"
	elif (global.get("save") == 3):
		save_path = "res://Saves/Save3.tres"
	save = load(save_path)
	current_tapes = save.get("tapes")
	get_node("../HBoxContainer2/TapesNow").text = str(current_tapes)
	get_node("../HBoxContainer2/TapesPlus").visible = false

func GetTapes():
	get_node("../HBoxContainer/StikersPlus").visible = true
	current_tapes = save.get("tapes")
	tapes = get_node("../../../../").tapes
	save.set("tapes", save.get("tapes") + tapes)
	save.set("tapes_all", save.get("tapes_all") + tapes)
	save.save_game(save_path)

func _process(delta):
	if tapes != 0:
		current_tapes += 1
		tapes -= 1
		get_node("../HBoxContainer2/TapesNow").text = str(current_tapes)
		get_node("../HBoxContainer2/TapesPlus").text = str("(+", tapes, ")")
		if tapes == 0:
			get_node("../HBoxContainer2/TapesPlus").visible = false
			set_process(false)
