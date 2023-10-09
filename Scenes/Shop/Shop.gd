extends Control

var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var room_data = load("res://Prefabs/ScriptableObjects/Room.tres")
var gen = RandomNumberGenerator.new()
var price_modifier = 0

# Door Data
var doors_num
var boss_door = false
var door1 = ""
var door2 = ""
var door3 = ""
var rooms_content_common = ["red", "green", "yellow", "blue", "orange", "purple", "tapes"]
var rooms_content_uncommon = ["rainbow", "memento", "memento", "memento"]
var rooms_content_rare = ["duo", "duo", "duo", "duo"]

# Items Data
var items = []
var items_prices = []
var items_common = ["stationeryknife", "heartpin", "bottleofwater", "thermos", "energydrink", "bottleofacid", "toyhammer", "nails", "needle", "shocker", "herbalistkit"]
var items_uncommon = ["businesscard", "catpin", "heartspin", "juice","coffee", "magnufyingglass", "saber", "papership", "waterpistol", "alarmclock", "mike", "musicdisc", "bandages", "fan", "bloodstainedarmor", "backpack"]
var items_rare = ["handspin", "couponforhugs", "pocketwatch", "cocktail", "battery", "knife", "vialofpoison", "rootofvulnerability", "brokenblade", "trombone", "shell", "chargingdevice", "spikedsword", "gloves", "wonderremedy", "firstaidkit", "boomerang", "whitecrest", "lightningcrest", "rosecrest", "healthcrest", "whirlcrest", "needlecrest", "stonecrest"]
var items_uncommon_num = 0
var items_common_num = 0
var items_rare_num = 0
var items_difference = false

func _ready():
	gen.randomize()
	if run_data.get("room") == 9:
		boss_door = true
	doors_num = gen.randi_range(1,4)
	if (doors_num == 4):
		doors_num = 2
	$Background/Label.text = str(tr("Floor "), run_data.get("floor_num"), tr(" Room "), run_data.get("room"), ": Shop")
	
	if run_data.get("couponforhugs") == true:
		price_modifier = 0.5
	
	for i in range($Shop/GridContainer.get_child_count()):
		if i+1 > run_data.get("shop_slots"):
			$Shop/GridContainer.get_child(i).queue_free()
		else:
			if i > 1:
				items.append("")
				items_prices.append(0)
	
	ItemsGeneration()
	
	$Shop/GridContainer/Skill1.Start()
	$Shop/GridContainer/Skill2.Start()

func ItemsGeneration():
	for i in range(items_common.size()):
		if run_data.get(items_common[i]) == true:
			items_common[i] = ""
			items_common_num += 1
	for i in range(items_uncommon.size()):
		if run_data.get(items_uncommon[i]) == true:
			items_uncommon[i] = ""
			items_uncommon_num += 1
	for i in range(items_rare.size()):
		if run_data.get(items_rare[i]) == true:
			items_rare[i] = ""
			items_rare_num += 1
	
	while items_difference == false:
		var has_dup = false
		for i in range(items.size()):
			var random = gen.randi_range(0, 100)
			if random <= 50 && items_common_num != items_common.size():
				items[i] = ItemSet("common")
				items_prices[i] = 30 - 30 * price_modifier
			elif random > 50 && random <= 85 && items_uncommon_num != items_uncommon.size():
				items[i] = ItemSet("uncommon")
				items_prices[i] = 45 - 45 * price_modifier
			elif random > 85 && random <= 100 && items_rare_num != items_rare.size():
				items[i] = ItemSet("rare")
				items_prices[i] = 60 - 60 * price_modifier
		
		for i in range(items.size() - 1):
			if has_dup == true:
				break
			for c in range(i + 1, items.size()):
				if items[i] == items[c]:
					has_dup = true
					break
		
		if has_dup == false:
			items_difference = true
	
	for i in range(2, run_data.get("shop_slots")):
		$Shop/GridContainer.get_child(i).Start(items[i - 2], items_prices[i - 2])

func ItemSet(rarity):
	var name
	if rarity == "common":
		var i = gen.randi_range(0, items_common.size()-1)
		if items_common[i] != "":
			name = items_common[i]
		else:
			name = ItemSet(rarity)
	elif rarity == "uncommon":
		var i = gen.randi_range(0, items_uncommon.size()-1)
		if items_uncommon[i] != "":
			name = items_uncommon[i]
		else:
			name = ItemSet(rarity)
	elif rarity == "rare":
		var i = gen.randi_range(0, items_rare.size()-1)
		if items_rare[i] != "":
			name = items_rare[i]
		else:
			name = ItemSet(rarity)
	
	return name

func _process(delta):
	$Background/StickersIcon/StickersNum.text = str(run_data.get("stickers"))

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

func _on_Regenerate_pressed():
	run_data.regen()
	$Regenerate.disabled = true

func _on_Continue_pressed():
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
	if run_data.get("max_num_of_rainbow") == 0:
		rooms_content_uncommon.erase("rainbow")
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
	run_data.save_run()
	if boss_door == true:
		run_data.set("shops_per_floor", 0)
		$RoomChoosing/CenterContainer/HBoxContainer/Room1.SetBossRoom()
		$RoomChoosing/CenterContainer/HBoxContainer/Room2.visible = false
		$RoomChoosing/CenterContainer/HBoxContainer/Room3.visible = false
	$RoomChoosing.Start()
