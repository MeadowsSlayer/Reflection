class_name SaveGame
extends Resource

export var red_res = 1
export var orange_res = 1
export var yellow_res = 1
export var green_res = 1
export var blue_res = 1
export var purple_res = 1

export var skill1_name = ""
export var skill2_name = ""
export var skill3_name = ""
export var skill4_name = ""
export var skill5_name = ""
export var skill6_name = ""
export var ult_name = "White_White_Silence"

export var s1_lvl = 1
export var s2_lvl = 1
export var s3_lvl = 1
export var s4_lvl = 1
export var s5_lvl = 1
export var s6_lvl = 1
export var ult_lvl = 1

export var max_actions = 2

export var Base_ATK = 15
export var Base_END = 15
export var Base_DEF = 15
export var Base_SEN = 10
export var Base_SPD = 15
export var Base_ENR = 10
export var SPD_mod = 0
export var HP_mod = 0
export var curEN = 20
export var curHP = 180

export var tapes = 0
export var tapes_all = 0
export var wasted_stickers = 0
export var wasted_actions = 0
export var difficulty = "normal"
export var runs = 1
export var dialogs_seen = []
export var tutorial = true
export var shop_visited = false
export var floor_three_cleared = false
export var current_item = ""

export var known_skills = ["Green_Healing", "Orange_Spiked_Shield", "Blue_Energy_Vampire", "Purple_Miasma", "Red_Warning_Strike", "Yellow_Lightning_Strike"]
export var known_red_skills = 1
export var known_orange_skills = 1
export var known_yellow_skills = 1
export var known_green_skills = 1
export var known_blue_skills = 1
export var known_purple_skills = 1
export var known_white_skills = 1

export var thorns = true
export var umbrella = false
export var glasses = false
export var favoriteshirt = true
export var comfortableshoes = true
export var helmet = false
export var cup = false
export var notebook = false
export var sprout = false
export var violet = false
export var pieceofshield = false
export var bottleofblood = false
export var bottledlightnings = false
export var photographicfilm = false

export var upgrade_lvl = 0
export var SWABB_Rank = 0
export var HealthInsurance_Rank = 0
export var PoiseForActions_Rank = 0
export var DeathEvasion_Rank = 0
export var StickersBag_Rank = 0
export var RegularCustomer_Rank = 0
export var ColorfulBeats_Rank = 0
export var tough_rank = 0
export var FateChanger_Rank = 0
export var Navigator_Rank = 0

func save_game(save_path):
	ResourceSaver.save(save_path, self)

func skills_known(save_path):
	if known_red_skills == 5:
		bottleofblood = true
	if known_orange_skills == 5:
		pieceofshield = true
	if known_yellow_skills == 5:
		bottledlightnings = true
	if known_green_skills == 5:
		sprout = true
	if known_blue_skills == 5:
		umbrella = true
	if known_purple_skills == 5:
		violet = true
	save_game(save_path)

func stickers_wasted(num, save_path):
	wasted_stickers += num
	if wasted_stickers >= 300:
		notebook = true
	save_game(save_path)

func actions_wasted(num, save_path):
	wasted_actions += num
	if wasted_actions >= 300:
		photographicfilm = true
	save_game(save_path)

static func load_save_data(save_path):
	if (ResourceLoader.exists(save_path)):
		return load(save_path)
	return null
