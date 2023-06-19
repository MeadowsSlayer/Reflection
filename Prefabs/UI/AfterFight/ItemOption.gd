extends Button

var gen = RandomNumberGenerator.new()
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var items_common = ["stationeryknife", "heartpin", "bottleofwater", "thermos", "energydrink", "bottleofacid", "toyhammer", "nails", "needle", "shocker", "herbalistkit"]
var items_uncommon = ["businesscard", "catpin", "heartspin", "juice","coffee", "magnufyingglass", "saber", "papership", "waterpistol", "alarmclock", "mike", "musicdisc", "bandages", "fan", "bloodstainedarmor", "backpack"]
var items_rare = ["handspin", "couponforhugs", "pocketwatch", "cocktail", "battery", "knife", "vialofpoison", "rootofvulnerability", "brokenblade", "trombone", "shell", "chargingdevice", "spikedsword", "gloves", "wonderremedy", "firstaidkit", "boomerang", "whitecrest", "lightningcrest", "rosecrest", "healthcrest", "whirlcrest", "needlecrest", "stonecrest"]
var items_uncommon_num = 0
var items_common_num = 0
var items_rare_num = 0
var item_name
var image

func _ready():
	gen.randomize()
	if gen.randi_range(0, 100) >= 50:
		queue_free()
	for i in range(items_common.size()):
		if run.get(items_common[i]) == true:
			items_common[i] = ""
			items_common_num += 1
	for i in range(items_uncommon.size()):
		if run.get(items_uncommon[i]) == true:
			items_uncommon[i] = ""
			items_uncommon_num += 1
	
	var random = gen.randi_range(0, 100)
	if random <= 50 && items_common_num != items_common.size():
		item_name = ItemSet("common")
	elif random > 50 && random <= 85 && items_uncommon_num != items_uncommon.size():
		item_name = ItemSet("uncommon")
	elif random > 85 && random <= 100 && items_rare_num != items_rare.size():
		item_name = ItemSet("rare")
	else:
		queue_free()
	
	DescSet()
	
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

func DescSet():
	match item_name:
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

func Quit():
	queue_free()

func _on_Item_pressed():
	run.set(item_name, true)
	run.save_run()
	$AnimationPlayer.play("Quit")
