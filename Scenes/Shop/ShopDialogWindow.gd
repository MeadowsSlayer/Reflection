extends Control

var current_item
var current_cost
var current_slot
var skill = false
var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save_data_path
var save_data
var skills = ["red", "green", "yellow", "blue", "orange", "purple", "rainbow"]
var image

func _ready():
	match global.get("save"):
		1:
			save_data_path = "res://Saves/Save1.tres"
		2:
			save_data_path = "res://Saves/Save2.tres"
		3:
			save_data_path = "res://Saves/Save3.tres"
	save_data = load(save_data_path)

func Open(item, cost, slot):
	skill = false
	self.visible = true
	current_item = item
	current_cost = cost
	current_slot = slot
	$BuyIt/Label.text = str("Buy it for ", current_cost, " stickers")
	if cost > run_data.get("stickers"):
		$BuyIt.disabled = true
	else:
		$BuyIt.disabled = false
	for i in skills:
		if item == i:
			skill = true
	
	match current_item:
		# Skills
		"red":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRed.png")
			$Name.text = "Red Skill"
			$Description.text = "RED_SKILL_DESCRIPTION"
		"orange":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillOrange.png")
			$Name.text = "Orange Skill"
			$Description.text = "ORANGE_SKILL_DESCRIPTION"
		"yellow":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillYellow.png")
			$Name.text = "Yellow Skill"
			$Description.text = "YELLOW_SKILL_DESCRIPTION"
		"green":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillGreen.png")
			$Name.text = "Green Skill"
			$Description.text = "GREEN_SKILL_DESCRIPTION"
		"blue":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillBlue.png")
			$Name.text = "Blue Skill"
			$Description.text = "BLUE_SKILL_DESCRIPTION"
		"purple":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillPurple.png")
			$Name.text = "Purple Skill"
			$Description.text = "PURPLE_SKILL_DESCRIPTION"
		"white":
			image = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRainbow.png")
			$Name.text = "White Skill"
			$Description.text = "WHITE_SKILL_DESCRIPTION"
		
		# Common Items
		"stationeryknife":
			image = load("res://Sprites/UI/Items/1. Common/StationeryKnife.png")
			$Name.text = "Stationery Knife"
			$Description.text = "STATIONERY_KNIFE_DESCRIPTION"
		"heartpin":
			image = load("res://Sprites/UI/Items/1. Common/HeartPin.png")
			$Name.text = "Heart Pin"
			$Description.text = "HEART_PIN_DESCRIPTION"
		"bottleofwater":
			image = load("res://Sprites/UI/Items/1. Common/BottleOfWater.png")
			$Name.text = "Bottle Of Water"
			$Description.text = "BOTTLE_OF_WATER_DESCRIPTION"
		"thermos":
			image = load("res://Sprites/UI/Items/1. Common/Thermos.png")
			$Name.text = "Thermos"
			$Description.text = "THERMOS_DESCRIPTION"
		"energydrink":
			image = load("res://Sprites/UI/Items/1. Common/EnergyDrink.png")
			$Name.text = "Energy Drink"
			$Description.text = "ENERGY_DRINK_DESCRIPTION"
		"bottleofacid":
			image = load("res://Sprites/UI/Items/1. Common/BottleOfAcid.png")
			$Name.text = "Bottle Of Acid"
			$Description.text = "BOTTLE_OF_ACID_DESCRIPTION"
		"toyhammer":
			image = load("res://Sprites/UI/Items/1. Common/ToyHammer.png")
			$Name.text = "Toy Hammer"
			$Description.text = "TOY_HAMMER_DESCRIPTION"
		"nails":
			image = load("res://Sprites/UI/Items/1. Common/Nails.png")
			$Name.text = "Nails"
			$Description.text = "NAILS_DESCRIPTION"
		"needle":
			image = load("res://Sprites/UI/Items/1. Common/Needle.png")
			$Name.text = "Needle"
			$Description.text = "NEEDLE_DESCRIPTION"
		"shocker":
			image = load("res://Sprites/UI/Items/1. Common/Shocker.png")
			$Name.text = "Shocker"
			$Description.text = "SHOCKER_DESCRIPTION"
		"herbalistkit":
			image = load("res://Sprites/UI/Items/1. Common/HerbalismKit.png")
			$Name.text = "Herbalist Kit"
			$Description.text = "HERBALIST_KIT_DESCRIPTION"
		
		# Uncommon Items
		"businesscard":
			image = load("res://Sprites/UI/Items/2. Uncommon/BusinessCard.png")
			$Name.text = "Business Card"
			$Description.text = "BUSINESS_CARD_DESCRIPTION"
		"catpin":
			image = load("res://Sprites/UI/Items/2. Uncommon/CatPin.png")
			$Name.text = "Cat Pin"
			$Description.text = "CAT_PIN_DESCRIPTION"
		"heartspin":
			image = load("res://Sprites/UI/Items/2. Uncommon/HeartsPin.png")
			$Name.text = "Hearts Pin"
			$Description.text = "HEARTS_PIN_DESCRIPTION"
		"juice":
			image = load("res://Sprites/UI/Items/2. Uncommon/Juice.png")
			$Name.text = "Juice"
			$Description.text = "JUICE_DESCRIPTION"
		"coffee":
			image = load("res://Sprites/UI/Items/2. Uncommon/Coffee.png")
			$Name.text = "Coffee"
			$Description.text = "COFFEE_DESCRIPTION"
		"magnifyingglass":
			image = load("res://Sprites/UI/Items/2. Uncommon/MagnifyingGlass.png")
			$Name.text = "Magnifying Glass"
			$Description.text = "MAGNIFYING_GLASS_DESCRIPTION"
		"saber":
			image = load("res://Sprites/UI/Items/2. Uncommon/Saber.png")
			$Name.text = "Saber"
			$Description.text = "SABER_DESCRIPTION"
		"papership":
			image = load("res://Sprites/UI/Items/2. Uncommon/PaperShip.png")
			$Name.text = "Paper Ship"
			$Description.text = "PAPER_SHIP_DESCRIPTION"
		"waterpistol":
			image = load("res://Sprites/UI/Items/2. Uncommon/WaterPistol.png")
			$Name.text = "Water Pistol"
			$Description.text = "WATER_PISTOL_DESCRIPTION"
		"alarmclock":
			image = load("res://Sprites/UI/Items/2. Uncommon/AlarmClock.png")
			$Name.text = "Alarm Clock"
			$Description.text = "ALARM_CLOCK_DESCRIPTION"
		"mike":
			image = load("res://Sprites/UI/Items/2. Uncommon/Mike.png")
			$Name.text = "Mike"
			$Description.text = "MIKE_DESCRIPTION"
		"musicdisc":
			image = load("res://Sprites/UI/Items/2. Uncommon/MusicDisc.png")
			$Name.text = "Music Disc"
			$Description.text = "MUSIC_DISC_DESCRIPTION"
		"bandages":
			image = load("res://Sprites/UI/Items/2. Uncommon/Bandages.png")
			$Name.text = "Bandages"
			$Description.text = "BANDAGES_DESCRIPTION"
		"fan":
			image = load("res://Sprites/UI/Items/2. Uncommon/Fan.png")
			$Name.text = "Fan"
			$Description.text = "FAN_DESCRIPTION"
		"bloodstainedarmor":
			image = load("res://Sprites/UI/Items/2. Uncommon/BloodstainedArmor.png")
			$Name.text = "Bloodstained Armor"
			$Description.text = "BLOODSTAINED_ARMOR_DESCRIPTION"
		
		# Rare Items
		"handspin":
			image = load("res://Sprites/UI/Items/3. Rare/HandsPin.png")
			$Name.text = "Hands Pin"
			$Description.text = "HANDS_PIN_DESCRIPTION"
		"couponforhugs":
			image = load("res://Sprites/UI/Items/3. Rare/CouponForHugs.png")
			$Name.text = "CouponForHugs"
			$Description.text = "COUPON_FOR_HUGS_DESCRIPTION"
		"pocketwatch":
			image = load("res://Sprites/UI/Items/3. Rare/PocketWatch.png")
			$Name.text = "Pocket Watch"
			$Description.text = "POCKET_WATCH_DESCRIPTION"
		"cocktail":
			image = load("res://Sprites/UI/Items/3. Rare/Cocktail.png")
			$Name.text = "Cocktail"
			$Description.text = "COCKTAIL_DESCRIPTION"
		"battery":
			image = load("res://Sprites/UI/Items/3. Rare/Battery.png")
			$Name.text = "Battery"
			$Description.text = "BATTERY_DESCRIPTION"
		"knife":
			image = load("res://Sprites/UI/Items/3. Rare/Knife.png")
			$Name.text = "Knife"
			$Description.text = "KNIFE_DESCRIPTION"
		"vialofpoison":
			image = load("res://Sprites/UI/Items/3. Rare/VialOfPoison.png")
			$Name.text = "Vial Of Poison"
			$Description.text = "VIAL_OF_POISON_DESCRIPTION"
		"rootofvulnerability":
			image = load("res://Sprites/UI/Items/3. Rare/RootOfVulnerability.png")
			$Name.text = "Root Of Vulnerability"
			$Description.text = "ROOT_OF_VULNERABILITY_DESCRIPTION"
		"brokenblade":
			image = load("res://Sprites/UI/Items/3. Rare/BrokenBlade.png")
			$Name.text = "Broken Blade"
			$Description.text = "BROKEN_BLADE_DESCRIPTION"
		"trombone":
			image = load("res://Sprites/UI/Items/3. Rare/Trombone.png")
			$Name.text = "Trombone"
			$Description.text = "TROMBONE_DESCRIPTION"
		"shell":
			image = load("res://Sprites/UI/Items/3. Rare/Shell.png")
			$Name.text = "Shell"
			$Description.text = "SHELL_DESCRIPTION"
		"chargingdevice":
			image = load("res://Sprites/UI/Items/3. Rare/ChargingDevice.png")
			$Name.text = "Charging Device"
			$Description.text = "CHARGING_DEVICE_DESCRIPTION"
		"spikedsword":
			image = load("res://Sprites/UI/Items/3. Rare/SpikedSword.png")
			$Name.text = "Spiked Sword"
			$Description.text = "SPIKED_SWORD_DESCRIPTION"
		"gloves":
			image = load("res://Sprites/UI/Items/3. Rare/Gloves.png")
			$Name.text = "Gloves"
			$Description.text = "GLOVES_DESCRIPTION"
		"wonderremedy":
			image = load("res://Sprites/UI/Items/3. Rare/WonderRemedy.png")
			$Name.text = "Wonder-Remedy"
			$Description.text = "WONDER_REMEDY_DESCRIPTION"
		"firstaidkit":
			image = load("res://Sprites/UI/Items/3. Rare/FirstAidKit.png")
			$Name.text = "First Aid Kit"
			$Description.text = "FIRST_AID_KIT_DESCRIPTION"
		"boomerang":
			image = load("res://Sprites/UI/Items/3. Rare/Boomerang.png")
			$Name.text = "Boomerang"
			$Description.text = "BOOMERANG_DESCRIPTION"
		"whitecrest":
			image = load("res://Sprites/UI/Items/3. Rare/WhiteCrest.png")
			$Name.text = "White Crest"
			$Description.text = "WHITE_CREST_DESCRIPTION"
		"lightningcrest":
			image = load("res://Sprites/UI/Items/3. Rare/LightningCrest.png")
			$Name.text = "Lightning Crest"
			$Description.text = "LIGHTNING_CREST_DESCRIPTION"
		"rosecrest":
			image = load("res://Sprites/UI/Items/3. Rare/RoseCrest.png")
			$Name.text = "Rose Crest"
			$Description.text = "ROSE_CREST_DESCRIPTION"
		"healthcrest":
			image = load("res://Sprites/UI/Items/3. Rare/HealthCrest.png")
			$Name.text = "Health Crest"
			$Description.text = "HEALTH_CREST_DESCRIPTION"
		"whirlcrest":
			image = load("res://Sprites/UI/Items/3. Rare/WhirlCrest.png")
			$Name.text = "Whirl Crest"
			$Description.text = "WHIRL_CREST_DESCRIPTION"
		"needlecrest":
			image = load("res://Sprites/UI/Items/3. Rare/NeedleCrest.png")
			$Name.text = "Needle Crest"
			$Description.text = "NEEDLE_CREST_DESCRIPTION"
		"stonecrest":
			image = load("res://Sprites/UI/Items/3. Rare/StoneCrest.png")
			$Name.text = "Stone Crest"
			$Description.text = "STONE_CREST_DESCRIPTION"
	
	$Item.texture = image
	$Shadow.texture = image
	$Description.text = tr($Description.text)


func _on_Cancel_pressed():
	self.visible = false

func _on_BuyIt_pressed():
	get_node("../Shop/GridContainer").get_child(current_slot - 1).disabled = true
	run_data.set("stickers", run_data.get("stickers") - current_cost)
	
	save_data.stickers_wasted(current_cost, save_data_path)
	
	if skill == true:
		get_node("../SkillChoosing").ChangeColor(current_item)
		get_node("../SkillChoosing").visible = true
	else:
		run_data.set(current_item, true)
	run_data.save_run()
	self.visible = false
