extends Button

var gen = RandomNumberGenerator.new()
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var room_data = load("res://Prefabs/ScriptableObjects/Room.tres")
var save
var value

func _ready():
	if room_data.get("current_room_reward1") != "tapes":
		self.queue_free()
	match global.get("save"):
		1:
			save = load("res://Saves/Save1.tres")
		2:
			save = load("res://Saves/Save2.tres")
		3:
			save = load("res://Saves/Save3.tres")
	
	gen.randomize()
	value = 40 + gen.randi_range(1, 20)

func _on_Film_Reel_pressed():
	save.set("tapes", save.get("tapes") + value)
