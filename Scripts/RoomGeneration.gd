class_name RoomGen
extends Resource

const save_path = "res://Prefabs/ScriptableObjects/Room.tres"

export var current_room_reward1 = ""
export var current_room_reward2 = ""
export var next_room_door1 = ""
export var next_room_door2 = ""
export var next_room_door3 = ""

func save_room():
	ResourceSaver.save(save_path, self)

static func load_room_data():
	if (ResourceLoader.exists(save_path)):
		return load(save_path)
	return null
