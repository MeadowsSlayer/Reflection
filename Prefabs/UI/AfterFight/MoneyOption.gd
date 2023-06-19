extends TextureRect

var stickers = 0
var current_stickers
var gen = RandomNumberGenerator.new()
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")

func _ready():
	current_stickers = run.get("stickers")
	get_node("../HBoxContainer/StikersNow").text = str(current_stickers)
	get_node("../HBoxContainer/StikersPlus").visible = false

func RandomizeMoney():
	get_node("../HBoxContainer/StikersPlus").visible = true
	current_stickers = run.get("stickers")
	gen.randomize()
	stickers = 5 * get_node("../../../../").max_enemies
	var sticker_bonus = 0
	if run.get("stationeryknife") == true:
		sticker_bonus += 0.2
	if run.get("businesscard") == true:
		sticker_bonus += 0.5
	stickers += int(stickers * sticker_bonus)
	run.set("stickers", run.get("stickers") + stickers)
	run.set("summ_of_stickers", run.get("summ_of_stickers") + stickers)
	run.save_run()

func _process(delta):
	if stickers != 0:
		current_stickers += 1
		stickers -= 1
		get_node("../HBoxContainer/StikersNow").text = str(current_stickers)
		get_node("../HBoxContainer/StikersPlus").text = str("(+", stickers, ")")
		if stickers == 0:
			get_node("../HBoxContainer/StikersPlus").visible = false
			set_process(false)
