class_name EnemyIntel
extends Resource

export var Guard_seen = true
export var Gunner_seen = false
export var DP_Warm_seen = false
export var DP_Cold_seen = false

export var Gatekeeper_seen = false
export var Gatekeeper_weaknesses = ["??", "??", "??", "??", "??", "??"]

const save_path = "res://Prefabs/ScriptableObjects/EnemyIntelGlobal.tres"

func save_data():
	ResourceSaver.save(save_path, self)

static func load_game_data():
	if (ResourceLoader.exists(save_path)):
		return load(save_path)
	return null
