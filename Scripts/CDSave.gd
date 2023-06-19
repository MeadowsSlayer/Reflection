extends Resource

export var skills_cd = [0, 0, 0, 0, 0, 0]
export var ult_cd = 0
export var shield_cur_HP = 0
export var shield_max_HP = 0
export var num_of_shields = 0
export var num_of_ults = 0
export var num_of_crits = 0
const save_path = "res://Prefabs/ScriptableObjects/CDSave.tres"

func null_cd_data():
	shield_cur_HP = 0
	shield_max_HP = 0
	skills_cd = [0, 0, 0, 0, 0, 0]
	ult_cd = 0
	save_cds()

func save_cds():
	ResourceSaver.save(save_path, self)

static func load_cd_data():
	if (ResourceLoader.exists(save_path)):
		return load(save_path)
	return null
