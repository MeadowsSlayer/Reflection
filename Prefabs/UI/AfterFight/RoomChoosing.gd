extends Button

export var room_num = 1
var gen = RandomNumberGenerator.new()
var room
var room_data = load("res://Prefabs/ScriptableObjects/Room.tres")
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var save
var save_path
var global = load("res://Prefabs/ScriptableObjects/Global.tres")

func _ready():
	gen.randomize()
	match global.get("save"):
		1:
			save_path = "res://Saves/Save1.tres"
		2:
			save_path = "res://Saves/Save2.tres"
		3:
			save_path = "res://Saves/Save3.tres"
	
	save = load(save_path)

func Start():
	if room_num == 1:
		room = get_node("../../../..").door1
	elif room_num == 2:
		room = get_node("../../../..").door2
	elif room_num == 3:
		room = get_node("../../../..").door3
	
	if room == "":
		queue_free()
	
	$RoomDescription.text = "NORMAL_BATTLE_DESCRIPTION"
	match room:
		"Gatekeeper":
			$RoomIcon.texture = load("res://Sprites/Gags/Сапфир.png")
			$RoomName.text = "GATEKEEPER"
		"green":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillGreen.png")
			$RoomName.text = "Reward: Green Skill"
		"red":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRed.png")
			$RoomName.text = "Reward: Red Skill"
		"orange":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillOrange.png")
			$RoomName.text = "Reward: Orange Skill"
		"blue":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillBlue.png")
			$RoomName.text = "Reward: Blue Skill"
		"purple":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillPurple.png")
			$RoomName.text = "Reward: Purple Skill"
		"yellow":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillYellow.png")
			$RoomName.text = "Reward: Yellow Skill"
		"white":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRainbow.png")
			$RoomName.text = "Rewards: White and Random Color Skill"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"shop":
			$RoomIcon.texture = load("res://Sprites/UI/Battle UI/Icons/Stickers.png")
			$RoomName.text = "Destination: Shop"
			$RoomDescription.text = "SHOP_DESCRIPTION"
		"memento":
			#$RoomIcon.texture = load("res://Sprites/UI/Items/3. Rare/Coffee.png")
			$RoomName.text = "Destination: Encounter"
			$RoomDescription.text = "ENCOUNTER_DESCRIPTION"
		"tapes":
			#$RoomIcon.texture = load("res://Sprites/UI/Items/3. Rare/Coffee.png")
			$RoomName.text = "Reward: Tapes"
			$RoomDescription.text = "TAPES_DESCRIPTION"
		"red/orange","orange/red":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Orange And Red Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"red/green","green/red":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Green And Red Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"red/yellow","yellow/red":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Yellow And Red Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"red/blue","blue/red":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Blue And Red Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"red/purple","purple/red":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Purple And Red Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"orange/green","green/orange":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Orange And Green Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"orange/yellow","yellow/orange":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Orange And Yellow Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"orange/blue","blue/orange":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Orange And Blue Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"orange/purple","purple/orange":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Orange And Purple Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"green/yellow","yellow/green":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Green And Yellow Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"green/blue","blue/green":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Green And Blue Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"green/purple","purple/green":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Green And Purple Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"blue/yellow","yellow/blue":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Blue And Yellow Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"purple/yellow","yellow/purple":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Purple And Yellow Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"
		"blue/purple","purple/blue":
			$RoomIcon.texture = load("res://Sprites/UI/Skills/NoSkill.png")
			$RoomName.text = "Reward: Blue And Purple Skills"
			$RoomDescription.text = "DIFFICULT_BATTLE_DESCRIPTION"

func SetBossRoom():
	if run.get("floor_num") == 1:
		room = "Gatekeeper"
		$RoomDescription.text = "FIRST_BOSS_BATTLE_DESCRIPTION"
		$RoomIcon.texture = load("res://Sprites/Gags/Сапфир.png")
		$RoomName.text = "GATEKEEPER"

func _on_Room1_pressed():
	SoundPlayer.play_sound("Click")
	run.set("room", run.get("room") + 1)
	run.set("all_rooms", run.get("all_rooms") + 1)
	run.save_run()
	match room:
		"green":
			room_data.set("current_room_reward1", "green")
			room_data.set("current_room_reward2", "")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"red":
			room_data.set("current_room_reward1", "red")
			room_data.set("current_room_reward2", "")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"orange":
			room_data.set("current_room_reward1", "orange")
			room_data.set("current_room_reward2", "")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"blue":
			room_data.set("current_room_reward1", "blue")
			room_data.set("current_room_reward2", "")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"purple":
			room_data.set("current_room_reward1", "purple")
			room_data.set("current_room_reward2", "")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"yellow":
			room_data.set("current_room_reward1", "yellow")
			room_data.set("current_room_reward2", "")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"white":
			room_data.set("current_room_reward1", "white")
			room_data.set("current_room_reward2", $"../../../..".rooms_content_common[gen.randi_range(0, $"../../../..".rooms_content_common.size() - 1)])
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"shop":
			run.set("shops_per_floor", 1)
			run.save_run()
			if save.get("shop_visited") == true:
				get_tree().change_scene("res://Scenes/Shop/Shop.tscn")
			else:
				save.set("shop_visited", true)
				save.save_game(save_path)
				get_tree().change_scene("res://Scenes/Dialogues/FirstFloor/DialogueShopFirstTime.tscn")
		"memento":
			pass
		"red/orange","orange/red":
			room_data.set("current_room_reward1", "orange")
			room_data.set("current_room_reward2", "red")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"red/green","green/red":
			room_data.set("current_room_reward1", "green")
			room_data.set("current_room_reward2", "red")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"red/yellow","yellow/red":
			room_data.set("current_room_reward1", "red")
			room_data.set("current_room_reward2", "yellow")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"red/blue","blue/red":
			room_data.set("current_room_reward1", "red")
			room_data.set("current_room_reward2", "blue")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"red/purple","purple/red":
			room_data.set("current_room_reward1", "red")
			room_data.set("current_room_reward2", "purple")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"orange/green","green/orange":
			room_data.set("current_room_reward1", "orange")
			room_data.set("current_room_reward2", "green")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"orange/yellow","yellow/orange":
			room_data.set("current_room_reward1", "orange")
			room_data.set("current_room_reward2", "yellow")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"orange/blue","blue/orange":
			room_data.set("current_room_reward1", "orange")
			room_data.set("current_room_reward2", "blue")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"orange/purple","purple/orange":
			room_data.set("current_room_reward1", "orange")
			room_data.set("current_room_reward2", "purple")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"green/yellow","yellow/green":
			room_data.set("current_room_reward1", "yellow")
			room_data.set("current_room_reward2", "green")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"green/blue","blue/green":
			room_data.set("current_room_reward1", "blue")
			room_data.set("current_room_reward2", "green")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"green/purple","purple/green":
			room_data.set("current_room_reward1", "purple")
			room_data.set("current_room_reward2", "green")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"blue/yellow","yellow/blue":
			room_data.set("current_room_reward1", "yellow")
			room_data.set("current_room_reward2", "blue")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"purple/yellow","yellow/purple":
			room_data.set("current_room_reward1", "yellow")
			room_data.set("current_room_reward2", "purple")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		"blue/purple","purple/blue":
			room_data.set("current_room_reward1", "blue")
			room_data.set("current_room_reward2", "purple")
			get_tree().change_scene("res://Scenes/First Floor/Battle/FirstFloor.tscn")
		
		"Gatekeeper":
			get_tree().change_scene("res://Scenes/First Floor/Boss Battle/GatekeeperRoom.tscn")
