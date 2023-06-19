class_name CurrentRun
extends Resource

const save_path = "res://Prefabs/ScriptableObjects/CurrentRun.tres"
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
export var room = 1
export var all_rooms = 1
export var floor_num = 1
export var shops_per_floor = 0

export var shop_slots = 4
export var dif = "normal"

export var red_res = 1.0
export var orange_res = 1.0
export var yellow_res = 1.0
export var green_res = 1.0
export var blue_res = 1.0
export var purple_res = 1.0

export var skill1_name = ""
export var skill2_name = ""
export var skill3_name = ""
export var skill4_name = ""
export var skill5_name = ""
export var skill6_name = ""
export var ult_name = ""

export var skills = []
export var skills_lvls = []
export var passives = []
export var passive_lvls = []
export var max_num_of_green = 5
export var max_num_of_orange = 3
export var max_num_of_yellow = 0
export var max_num_of_red = 0
export var max_num_of_blue = 0
export var max_num_of_purple = 0
export var max_num_of_white = 0

export var max_actions = 2

export var Base_ATK = 15
export var Base_END = 15
export var Base_DEF = 15
export var Base_SEN = 10
export var Base_SPD = 20
export var Base_ENR = 10

export var HP_mod = 0
export var curEN = 0
export var curHP = 180

export var summ_of_stickers = 0
export var stickers = 0

#Base Upgrades
export var SWABB_Rank = 0
export var death_evasions = 0
export var death_evasions_max = 0
export var colorful_beats = 0
export var skill_rerolls = 0
export var room_rerolls = 0

#Base Items
export var thorns = false
export var umbrella = false
export var glasses = false
export var favoriteshirt = false
export var comfortableshoes = false
export var helmet = false
export var cup = false
export var notebook = false
export var sprout = false
export var violet = false
export var pieceofshield = false
export var bottleofblood = false
export var bottledlightnings = false
export var photographicfilm = false

#Common Items
export var stationeryknife = false
export var heartpin = false
export var bottleofwater = false
export var thermos = false
export var energydrink = false
export var bottleofacid = false
export var toyhammer = false
export var nails = false
export var needle = false
export var shocker = false
export var bloodpact = false
export var bottleofpaints = false
export var herbalistkit = false

#Uncommon Items
export var businesscard = false
export var catpin = false
export var heartspin = false
export var juice = false
export var coffee = false
export var magnifyingglass = false
export var saber = false
export var papership = false
export var waterpistol = false
export var alarmclock = false
export var mike = false
export var musicdisc = false
export var rootofdespair = false
export var papercranes = false
export var bandages = false
export var fan = false
export var bloodstainedarmor = false
export var backpack = false
export var usedbattery = false

#Rare Items
export var handspin = false
export var couponforhugs = false
export var pocketwatch = false
export var cocktail = false
export var battery = false
export var knife = false
export var viaofpoison = false
export var rootofvulnerability = false
export var brokenblade = false
export var trombone = false
export var shell = false
export var chargingdevice = false
export var oneforall = false
export var allforone = false
export var spikedsword = false
export var gloves = false
export var wonderremedy = false
export var firstaidkit = false
export var boomerang = false
export var whitecrest = false
export var lightningcrest = false
export var rosecrest = false
export var healthcrest = false
export var whirlcrest = false
export var needlecrest = false
export var stonecrest = false

func start_run(new):
	thorns = false
	glasses = false
	umbrella = false
	notebook = false
	favoriteshirt = false
	comfortableshoes = false
	helmet = false
	cup = false
	sprout = false
	violet = false
	pieceofshield = false
	bottleofblood = false
	bottledlightnings = false
	photographicfilm = false
	
	Base_ATK = 15
	Base_END = 15
	Base_DEF = 15
	Base_SEN = 10
	Base_SPD = 10
	Base_ENR = 10
	
	room = 1
	all_rooms = 1
	floor_num = 1
	stickers = 0
	summ_of_stickers = 0
	var save_slot = ""
	if (global.get("save") == 1):
		save_slot = "res://Saves/Save1.tres"
	elif (global.get("save") == 2):
		save_slot = "res://Saves/Save2.tres"
	elif (global.get("save") == 3):
		save_slot = "res://Saves/Save3.tres"
	var data = load(save_slot)
	dif = data.get("difficulty")
	HP_mod = data.get("HealthInsurance_Rank") * 10
	curHP = Base_END * 15 + HP_mod
	curEN = 0
	max_actions = 2 + data.get("PoiseForActions_Rank")
	if new == true:
		skill1_name = "Green_Healing"
		skill2_name = "Orange_Stone_Shield"
		skill3_name = "Blue_Energy_Vampire"
		ult_name = "White_White_Silence"
		skills = [skill1_name, skill2_name, skill3_name, ult_name]
		skills_lvls = [1, 1, 1, 1]
	else:
		skill1_name = data.get("skill1_name")
		skill2_name = data.get("skill2_name")
		skill3_name = data.get("skill3_name")
		ult_name = "White_White_Silence"
		skills = [skill1_name, skill2_name, skill3_name, ult_name]
		skills_lvls = [1, 1, 1, 1]
	
	skill4_name = ""
	skill5_name = ""
	skill6_name = ""
	passives = []
	passive_lvls = []
	
	max_num_of_green = 45
	max_num_of_orange = 45
	max_num_of_yellow = 45
	max_num_of_red = 45
	max_num_of_blue = 45
	max_num_of_purple = 45
	max_num_of_white = 40
	
	SWABB_Rank = data.get("SWABB_Rank")
	death_evasions = data.get("DeathEvasion_Rank")
	death_evasions_max = death_evasions
	stickers = 20 * data.get("StickersBag_Rank")
	colorful_beats = 0.2 * data.get("ColorfulBeats_Rank")
	shop_slots = 4 + data.get("RegularCustomer_Rank")
	skill_rerolls = data.get("FateChanger_Rank")
	room_rerolls = data.get("Navigator_Rank")
	
	match data.get("current_item"):
		"thorns":
			thorns = true
			Base_ATK += 5
		"cup":
			cup = true
			Base_ENR += 10
		"helmet":
			helmet = true
			Base_DEF += 10
		"comfortableshoes":
			comfortableshoes = true
			Base_SPD += 5
		"favoriteshirt":
			favoriteshirt = true
			Base_END += 5
			curHP += 5 * 15
		"glasses":
			glasses = true
			Base_SEN += 10
		
		"notebook":
			notebook = true
			stickers = 100
		
		"umbrella":
			umbrella = true
		"sprout":
			sprout = true
		"violet":
			violet = true
		"pieceofshield":
			pieceofshield = true
		"bottleofblood":
			bottleofblood = true
		"bottledlightnings":
			bottledlightnings = true
		
		"photographicfilm":
			photographicfilm = true
			max_actions += 2
		
		"":
			pass
	
	stationeryknife = false
	heartpin = false
	bottleofwater = false
	thermos = false
	energydrink = false
	bottleofacid = false
	toyhammer = false
	nails = false
	needle = false
	shocker = false
	bloodpact = false
	bottleofpaints = false
	herbalistkit = false
	
	businesscard = false
	catpin = false
	heartspin = false
	juice = false
	coffee = false
	magnifyingglass = false
	saber = false
	papership = false
	waterpistol = false
	alarmclock = false
	mike = false
	musicdisc = false
	rootofdespair = false
	papercranes = false
	bandages = false
	fan = false
	bloodstainedarmor = false
	backpack = false
	usedbattery = false
	
	handspin = false
	couponforhugs = false
	pocketwatch = false
	cocktail = false
	battery = false
	knife = false
	viaofpoison = false
	rootofvulnerability = false
	brokenblade = false
	trombone = false
	shell = false
	chargingdevice = false
	oneforall = false
	allforone = false
	spikedsword = false
	gloves = false
	wonderremedy = false
	firstaidkit = false
	boomerang = false
	whitecrest = false
	lightningcrest = false
	rosecrest = false
	healthcrest = false
	whirlcrest = false
	needlecrest = false
	stonecrest = false
	save_run()

func regen():
	curHP = int(curHP + curHP * 0.3)
	save_run()

func save_run():
	ResourceSaver.save(save_path, self)

static func load_run_data():
	if (ResourceLoader.exists(save_path)):
		return load(save_path)
	return null

func get_skill_lvl(skill_name):
	var lvl = 0
	for i in range(skills.size()):
		if skills[i] == skill_name:
			lvl = skills_lvls[i]
	return lvl
