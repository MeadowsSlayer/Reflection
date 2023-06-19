extends Control

var rank
var max_rank
var bonus
var cost
var final_cost = 0
var tapes
var upgrade

var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save
var save_path

func _ready():
	match global.get("save"):
		1:
			save_path = "res://Saves/Save1.tres"
		2:
			save_path = "res://Saves/Save2.tres"
		3:
			save_path = "res://Saves/Save3.tres"
	save = load(save_path)
	
	if save.get("upgrade_lvl") >= 10:
		$"../SecondStep".visible = true
		$"../SecondStepCover".visible = false
	else:
		$"../SecondStep".visible = false
		$"../SecondStepCover".visible = true
	
	if save.get("upgrade_lvl") >= 25:
		$"../ThirdStepCover".visible = false
		$"../ThirdStep".visible = true
	else:
		$"../ThirdStepCover".visible = true
		$"../ThirdStep".visible = false
	
	tapes = save.get("tapes")
	$Tapes.text = str(": ",tapes)
	
	get_node("../FirstStep/SWABB/Rank").text = str(save.get("SWABB_Rank"))
	get_node("../FirstStep/Health/Rank").text = str(save.get("HealthInsurance_Rank"))
	get_node("../FirstStep/Actions/Rank").text = str(save.get("PoiseForActions_Rank"))

func CanBuy():
	final_cost = cost + bonus * rank
	$Upgrade/Label.text = str(final_cost)
	if final_cost > tapes:
		$Upgrade.disabled = true
	else:
		$Upgrade.disabled = false
	
	if rank == max_rank:
		$Upgrade.disabled = true
		$Upgrade/Label.text = "-"
	else:
		$Upgrade.disabled = false

func _on_Upgrade_pressed():
	SoundPlayer.play_sound("Click")
	if rank != max_rank && tapes >= final_cost:
		tapes -= final_cost
		$Tapes.text = str(": ",tapes)
		rank += 1
		final_cost = cost + bonus * rank
		$Upgrade/Label.text = str(final_cost)
		if rank == max_rank:
			$Upgrade.disabled = true
			$Upgrade/Label.text = "-"
		if tapes < final_cost:
			$Upgrade.disabled = true
		
		save.set("upgrade_lvl", save.get("upgrade_lvl") + 1)
		
		if save.get("upgrade_lvl") >= 10:
			$"../SecondStep".visible = true
			$"../SecondStepCover".visible = false
		else:
			$"../SecondStep".visible = false
			$"../SecondStepCover".visible = true
	
		if save.get("upgrade_lvl") >= 25:
			$"../ThirdStepCover".visible = false
			$"../ThirdStep".visible = true
		else:
			$"../ThirdStepCover".visible = true
			$"../ThirdStep".visible = false
		
		save.set("tapes", tapes)
		match upgrade:
			"SWABB":
				save.set("SWABB_Rank", rank)
				get_node("../FirstStep/SWABB/Rank").text = str(save.get("SWABB_Rank"))
			"Healt_Insurance":
				save.set("HealthInsurance_Rank", rank)
				get_node("../FirstStep/Health/Rank").text = str(save.get("HealthInsurance_Rank"))
			"Poise_For_Actions":
				save.set("PoiseForActions_Rank", rank)
				get_node("../FirstStep/Actions/Rank").text = str(save.get("PoiseForActions_Rank"))
			"Tough":
				save.set("tough_rank", rank)
				get_node("../ThirdStep/Tough/Rank").text = str(save.get("tough_rank"))
			"Stickers_Bag":
				save.set("StickersBag_Rank", rank)
				get_node("../SecondStep/StikersBag/Rank").text = str(save.get("StickersBag_Rank"))
			"Regular_Customer":
				save.set("RegularCustomer_Rank", rank)
				get_node("../SecondStep/RegularCustomer/Rank").text = str(save.get("RegularCustomer_Rank"))
			"Death_Evasion":
				save.set("DeathEvasion_Rank", rank)
				get_node("../SecondStep/DeathAvoidance/Rank").text = str(save.get("DeathEvasion_Rank"))
			"Colorful_Beats":
				save.set("ColorfulBeats_Rank", rank)
				get_node("../ThirdStep/ColorfulBeats/Rank").text = str(save.get("ColorfulBeats_Rank"))
			"Fate_Changer":
				save.set("FateChanger_Rank", rank)
				get_node("../ThirdStep/FateChanger/Rank").text = str(save.get("FateChanger_Rank"))
			"Navigator":
				save.set("Navigator_Rank", rank)
				get_node("../ThirdStep/Navigator/Rank").text = str(save.get("Navigator_Rank"))
			
		save.save_game(save_path)

func _on_Close_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = false

func _on_SWABB_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("SWABB_Rank")
	max_rank = 5
	cost = 10
	bonus = 10
	$Description.text = "SWABB_DESCRIPTION"
	$Name.text = "Sleep With A Baseball Bat"
	upgrade = "SWABB"
	CanBuy()

func _on_Health_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("HealthInsurance_Rank")
	max_rank = 10
	cost = 40
	bonus = 40
	$Description.text = "HEALTH_INSURANCE_DESCRIPTION"
	$Name.text = "Health Insurance"
	upgrade = "Healt_Insurance"
	CanBuy()

func _on_Actions_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("PoiseForActions_Rank")
	max_rank = 3
	cost = 100
	bonus = 100
	$Description.text = "POISE_FOR_ACTIONS_DESCRIPTION"
	$Name.text = "Poise For Actions"
	upgrade = "Poise_For_Actions"
	CanBuy()

func _on_Tough_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("tough_rank")
	max_rank = 1
	cost = 1000
	bonus = 0
	$Description.text = "TOUGH_DESCRIPTION"
	$Name.text = "Tough"
	upgrade = "Tough"
	CanBuy()

func _on_StikersBag_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("StickersBag_Rank")
	max_rank = 5
	cost = 20
	bonus = 10
	$Description.text = "STICKERS_BAG_DESCRIPTION"
	$Name.text = "Sticker's Bag"
	upgrade = "Stickers_Bag"
	CanBuy()

func _on_DeathAvoidance_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("DeathEvasion_Rank")
	max_rank = 3
	cost = 200
	bonus = 200
	$Description.text = "DEATH_EVASION_DESCRIPTION"
	$Name.text = "Death Evasion"
	upgrade = "Death_Evasion"
	CanBuy()

func _on_RegularCustomer_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("RegularCustomer_Rank")
	max_rank = 4
	cost = 100
	bonus = 100
	$Description.text = "REGULAR_CUSTOMER_DESCRIPTION"
	$Name.text = "Regular Customer"
	upgrade = "Regular_Customer"
	CanBuy()

func _on_ColorfulBeats_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("ColorfulBeats_Rank")
	max_rank = 5
	cost = 30
	bonus = 20
	$Description.text = "COLORFUL_BEATS_DESCRIPTION"
	$Name.text = "Colorful Beats"
	upgrade = "Colorful_Beats"
	CanBuy()

func _on_FateChanger_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("FateChanger_Rank")
	max_rank = 4
	cost = 200
	bonus = 50
	$Description.text = "FATE_CHANGER_DESCRIPTION"
	$Name.text = "Fate Changer"
	upgrade = "Fate_Changer"
	CanBuy()

func _on_Navigator_pressed():
	SoundPlayer.play_sound("Click")
	self.visible = true
	rank = save.get("Navigator_Rank")
	max_rank = 4
	cost = 200
	bonus = 100
	$Description.text = "NAVIGATOR_DESCRIPTION"
	$Name.text = "Navigator"
	upgrade = "Navigator"
	CanBuy()
