class_name Global
extends Resource

export var language = "en"
export (float) var volume = 1
export (float) var music = 1
export (float) var se = 1
export var save = 1
export var glitches = true

const save_path = "res://Prefabs/ScriptableObjects/Global.tres"

func save_game():
	ResourceSaver.save(save_path, self)

static func load_game_data():
	if (ResourceLoader.exists(save_path)):
		return load(save_path)
	return null
