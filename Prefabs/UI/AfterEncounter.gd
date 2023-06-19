extends Control

var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var room_data = load("res://Prefabs/ScriptableObjects/Room.tres")
var gen = RandomNumberGenerator.new()
var doors_num

var rooms_content_common = ["red", "green", "yellow", "blue", "orange", "purple"]
var rooms_content_uncommon = ["white", "memento", "memento", "memento"]
var rooms_content_rare = ["shop", "duo", "duo", "duo", "duo"]

var door1 = ""
var door2 = ""
var door3 = ""

func _ready():
	gen.randomize()
	doors_num = gen.randi_range(1,6)
	if (doors_num >= 4):
		doors_num = 2
	if run_data.get("shops_per_floor") == 1:
		rooms_content_rare.erase("shop")
	if run_data.get("bottleofblood") == true && run_data.get("max_num_of_red") != 0:
		rooms_content_common.append("red")
		rooms_content_common.append("red")
	if run_data.get("pieceofshield") == true && run_data.get("max_num_of_orange") != 0:
		rooms_content_common.append("orange")
		rooms_content_common.append("orange")
	if run_data.get("bottledlightnings") == true && run_data.get("max_num_of_yellow") != 0:
		rooms_content_common.append("yellow")
		rooms_content_common.append("yellow")
	if run_data.get("sprout") == true && run_data.get("max_num_of_green") != 0:
		rooms_content_common.append("green")
		rooms_content_common.append("green")
	if run_data.get("umbrella") == true && run_data.get("max_num_of_blue") != 0:
		rooms_content_common.append("blue")
		rooms_content_common.append("blue")
	if run_data.get("violet") == true && run_data.get("max_num_of_purple") != 0:
		rooms_content_common.append("purple")
		rooms_content_common.append("purple")

func ShowRooms():
	if run_data.get("room_rerolls") == 0:
		$RoomChoosing/Reroll.visible = false
	else:
		$RoomChoosing/Reroll.text = str(tr("Reroll"), " x", run_data.get("room_rerolls"))
	SoundPlayer.play_sound("Click")
	if run_data.get("max_num_of_green") == 0:
		rooms_content_common.erase("green")
	if run_data.get("max_num_of_orange") == 0:
		rooms_content_common.erase("orange")
	if run_data.get("max_num_of_purple") == 0:
		rooms_content_common.erase("purple")
	if run_data.get("max_num_of_blue") == 0:
		rooms_content_common.erase("blue")
	if run_data.get("max_num_of_yellow") == 0:
		rooms_content_common.erase("yellow")
	if run_data.get("max_num_of_red") == 0:
		rooms_content_common.erase("red")
	if run_data.get("max_num_of_white") == 0:
		rooms_content_uncommon.erase("white")
	gen.randomize()
	if doors_num == 1:
		door1 = RoomFill()
		if run_data.get("room") == 8:
			door1 = "shop"
		room_data.set("next_room_door1", door1)
		room_data.set("next_room_door2", "")
		room_data.set("next_room_door3", "")
	elif doors_num == 2:
		door1 = RoomFill()
		if run_data.get("room") == 8:
			door1 = "shop"
		door2 = RoomFill()
		while door1 == door2:
			door2 = RoomFill()
		room_data.set("next_room_door1", door1)
		room_data.set("next_room_door2", door2)
		room_data.set("next_room_door3", "")
	elif doors_num == 3:
		door1 = RoomFill()
		if run_data.get("room") == 8:
			door1 = "shop"
		door2 = RoomFill()
		door3 = RoomFill()
		while door1 == door2 || door1 == door3 || door2 == door3:
			door2 = RoomFill()
			door3 = RoomFill()
		room_data.set("next_room_door1", door1)
		room_data.set("next_room_door2", door2)
		room_data.set("next_room_door3", door3)
	$RoomChoosing.visible = true
	get_tree().call_group("Rooms", "Start")
	run_data.save_run()

func RoomFill():
	var rooms_content = gen.randi_range(1, 100)
	if rooms_content <= 60:
		return rooms_content_common[gen.randi_range(0,rooms_content_common.size()-1)]
	if rooms_content > 60 && rooms_content <= 90:
		return rooms_content_uncommon[gen.randi_range(0,rooms_content_uncommon.size() - 1)]
	if rooms_content > 90 && rooms_content <= 100:
		var type = rooms_content_rare[gen.randi_range(0,2)]
		if type == "shop" || rooms_content_common.size() < 2:
			return "shop"
		elif type == "duo" && rooms_content_common.size() >= 2:
			var first = rooms_content_common[gen.randi_range(0,rooms_content_common.size()-1)]
			var second = rooms_content_common[gen.randi_range(0,rooms_content_common.size()-1)]
			while first == second:
				second = rooms_content_common[gen.randi_range(0,rooms_content_common.size()-1)]
			
			return str(first, "/", second)

func _on_Reroll_pressed():
	run_data.set("room_rerolls", run_data.get("room_rerolls") - 1)
	run_data.save_run()
	ShowRooms()
