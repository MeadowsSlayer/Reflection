extends Button

var item_name
var item_price
var image
export var slot = 0

func Start(it_name, price):
	item_name = it_name
	item_price = price
	$StickersCost/Cost.text = str(item_price)
	DescSet()

func DescSet():
	match item_name:
		# Common Items
		"stationeryknife":
			image = load("res://Sprites/UI/Items/1. Common/StationeryKnife.png")
			$Name.text = "Stationery Knife"
		"heartpin":
			image = load("res://Sprites/UI/Items/1. Common/HeartPin.png")
			$Name.text = "Heart Pin"
		"bottleofwater":
			image = load("res://Sprites/UI/Items/1. Common/BottleOfWater.png")
			$Name.text = "Bottle Of Water"
		"thermos":
			image = load("res://Sprites/UI/Items/1. Common/Thermos.png")
			$Name.text = "Thermos"
		"energydrink":
			image = load("res://Sprites/UI/Items/1. Common/EnergyDrink.png")
			$Name.text = "Energy Drink"
		"bottleofacid":
			image = load("res://Sprites/UI/Items/1. Common/BottleOfAcid.png")
			$Name.text = "Bottle Of Acid"
		"toyhammer":
			image = load("res://Sprites/UI/Items/1. Common/ToyHammer.png")
			$Name.text = "Toy Hammer"
		"nails":
			image = load("res://Sprites/UI/Items/1. Common/Nails.png")
			$Name.text = "Nails"
		"needle":
			image = load("res://Sprites/UI/Items/1. Common/Needle.png")
			$Name.text = "Needle"
		"shocker":
			image = load("res://Sprites/UI/Items/1. Common/Shocker.png")
			$Name.text = "Shocker"
		"herbalistkit":
			image = load("res://Sprites/UI/Items/1. Common/HerbalismKit.png")
			$Name.text = "Herbalist Kit"
		
		# Uncommon Items
		"businesscard":
			image = load("res://Sprites/UI/Items/2. Uncommon/BusinessCard.png")
			$Name.text = "Business Card"
		"catpin":
			image = load("res://Sprites/UI/Items/2. Uncommon/CatPin.png")
			$Name.text = "Cat Pin"
		"heartspin":
			image = load("res://Sprites/UI/Items/2. Uncommon/HeartsPin.png")
			$Name.text = "Hearts Pin"
		"juice":
			image = load("res://Sprites/UI/Items/2. Uncommon/Juice.png")
			$Name.text = "Juice"
		"coffee":
			image = load("res://Sprites/UI/Items/2. Uncommon/Coffee.png")
			$Name.text = "Coffee"
		"magnifyingglass":
			image = load("res://Sprites/UI/Items/2. Uncommon/MagnifyingGlass.png")
			$Name.text = "Magnifying Glass"
		"saber":
			image = load("res://Sprites/UI/Items/2. Uncommon/Saber.png")
			$Name.text = "Saber"
		"papership":
			image = load("res://Sprites/UI/Items/2. Uncommon/PaperShip.png")
			$Name.text = "Paper Ship"
		"waterpistol":
			image = load("res://Sprites/UI/Items/2. Uncommon/WaterPistol.png")
			$Name.text = "Water Pistol"
		"alarmclock":
			image = load("res://Sprites/UI/Items/2. Uncommon/AlarmClock.png")
			$Name.text = "Alarm Clock"
		"mike":
			image = load("res://Sprites/UI/Items/2. Uncommon/Mike.png")
			$Name.text = "Mike"
		"musicdisc":
			image = load("res://Sprites/UI/Items/2. Uncommon/MusicDisc.png")
			$Name.text = "Music Disc"
		"bandages":
			image = load("res://Sprites/UI/Items/2. Uncommon/Bandages.png")
			$Name.text = "Bandages"
		"fan":
			image = load("res://Sprites/UI/Items/2. Uncommon/Fan.png")
			$Name.text = "Fan"
		"bloodstainedarmor":
			image = load("res://Sprites/UI/Items/2. Uncommon/BloodstainedArmor.png")
			$Name.text = "Bloodstained Armor"
		
		# Rare Items
		"handspin":
			image = load("res://Sprites/UI/Items/3. Rare/HandsPin.png")
			$Name.text = "Hands Pin"
		"couponforhugs":
			image = load("res://Sprites/UI/Items/3. Rare/CouponForHugs.png")
			$Name.text = "CouponForHugs"
		"pocketwatch":
			image = load("res://Sprites/UI/Items/3. Rare/PocketWatch.png")
			$Name.text = "Pocket Watch"
		"cocktail":
			image = load("res://Sprites/UI/Items/3. Rare/Cocktail.png")
			$Name.text = "Cocktail"
		"battery":
			image = load("res://Sprites/UI/Items/3. Rare/Battery.png")
			$Name.text = "Battery"
		"knife":
			image = load("res://Sprites/UI/Items/3. Rare/Knife.png")
			$Name.text = "Knife"
		"vialofpoison":
			image = load("res://Sprites/UI/Items/3. Rare/VialOfPoison.png")
			$Name.text = "Vial Of Poison"
		"rootofvulnerability":
			image = load("res://Sprites/UI/Items/3. Rare/RootOfVulnerability.png")
			$Name.text = "Root Of Vulnerability"
		"brokenblade":
			image = load("res://Sprites/UI/Items/3. Rare/BrokenBlade.png")
			$Name.text = "Broken Blade"
		"trombone":
			image = load("res://Sprites/UI/Items/3. Rare/Trombone.png")
			$Name.text = "Trombone"
		"shell":
			image = load("res://Sprites/UI/Items/3. Rare/Shell.png")
			$Name.text = "Shell"
		"chargingdevice":
			image = load("res://Sprites/UI/Items/3. Rare/ChargingDevice.png")
			$Name.text = "Charging Device"
		"spikedsword":
			image = load("res://Sprites/UI/Items/3. Rare/SpikedSword.png")
			$Name.text = "Spiked Sword"
		"gloves":
			image = load("res://Sprites/UI/Items/3. Rare/Gloves.png")
			$Name.text = "Gloves"
		"wonderremedy":
			image = load("res://Sprites/UI/Items/3. Rare/WonderRemedy.png")
			$Name.text = "Wonder-Remedy"
		"firstaidkit":
			image = load("res://Sprites/UI/Items/3. Rare/FirstAidKit.png")
			$Name.text = "First Aid Kit"
		"boomerang":
			image = load("res://Sprites/UI/Items/3. Rare/Boomerang.png")
			$Name.text = "Boomerang"
		"whitecrest":
			image = load("res://Sprites/UI/Items/3. Rare/WhiteCrest.png")
			$Name.text = "White Crest"
		"lightningcrest":
			image = load("res://Sprites/UI/Items/3. Rare/LightningCrest.png")
			$Name.text = "Lightning Crest"
		"rosecrest":
			image = load("res://Sprites/UI/Items/3. Rare/RoseCrest.png")
			$Name.text = "Rose Crest"
		"healthcrest":
			image = load("res://Sprites/UI/Items/3. Rare/HealthCrest.png")
			$Name.text = "Health Crest"
		"whirlcrest":
			image = load("res://Sprites/UI/Items/3. Rare/WhirlCrest.png")
			$Name.text = "Whirl Crest"
		"needlecrest":
			image = load("res://Sprites/UI/Items/3. Rare/NeedleCrest.png")
			$Name.text = "Needle Crest"
		"stonecrest":
			image = load("res://Sprites/UI/Items/3. Rare/StoneCrest.png")
			$Name.text = "Stone Crest"
	
	$Item.texture = image
	$Shadow.texture = image

func _on_seld_pressed():
	get_node("../../../DialogWindow").Open(item_name, item_price, slot)
