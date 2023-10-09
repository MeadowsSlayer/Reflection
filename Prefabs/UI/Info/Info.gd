extends Control

var info_type = "status effects"
var target = 0
var targets = ["player"]
var character

onready var base_info = $BaseInfo
onready var talents = $Talents
onready var salim = $Talents/Salim
onready var guard = $Talents/Guard
onready var gunner = $Talents/Gunner
onready var dp_cold = $Talents/DP_Cold
onready var dp_warm = $Talents/DP_Warm
onready var camera_info = $"../../InfoCamera"
onready var camera_2d = $"../../Camera2D"
onready var control = $"../Control"

onready var atk_num = $BaseInfo/Stats/ATKNum
onready var res_num = $BaseInfo/Stats/RESNum
onready var def_num = $BaseInfo/Stats/DEFNum
onready var end_num = $BaseInfo/Stats/ENDNum
onready var sen_num = $BaseInfo/Stats/SENNum
onready var spd_num = $BaseInfo/Stats/SPDNum
onready var enr_num = $BaseInfo/Stats/ENRNum
onready var crit_num = $BaseInfo/Stats/CRITNum
onready var avo_num = $BaseInfo/Stats/AVONum

onready var immunities = $Vulnerabilities/VBoxContainer/Immunities
onready var resistances = $Vulnerabilities/VBoxContainer/Resistances
onready var weaknesses = $Vulnerabilities/VBoxContainer/Weaknesses
onready var fatals = $Vulnerabilities/VBoxContainer/Fatals

onready var fragile = $BaseInfo/StatusEffects/VBoxContainer/Fragile
onready var spread = $BaseInfo/StatusEffects/VBoxContainer/Spread
onready var bind = $BaseInfo/StatusEffects/VBoxContainer/Bind
onready var miasma = $BaseInfo/StatusEffects/VBoxContainer/Miasma
onready var haste = $BaseInfo/StatusEffects/VBoxContainer/Haste
onready var block = $BaseInfo/StatusEffects/VBoxContainer/Block
onready var closure = $BaseInfo/StatusEffects/VBoxContainer/Closure
onready var aches = $BaseInfo/StatusEffects/VBoxContainer/Aches
onready var empowerment = $BaseInfo/StatusEffects/VBoxContainer/Empowerment
onready var blindness = $BaseInfo/StatusEffects/VBoxContainer/Blindness
onready var silence = $BaseInfo/StatusEffects/VBoxContainer/Silence
onready var exhaustion = $BaseInfo/StatusEffects/VBoxContainer/Exhaustion
onready var sleep = $BaseInfo/StatusEffects/VBoxContainer/Sleep
onready var mental_protection = $BaseInfo/StatusEffects/VBoxContainer/MentalProtection
onready var protect_the_art = $BaseInfo/StatusEffects/VBoxContainer/ProtectTheArt
onready var burst_of_energy = $BaseInfo/StatusEffects/VBoxContainer/BurstOfEnergy
onready var scorching_heat = $BaseInfo/StatusEffects/VBoxContainer/ScorchingHeat
onready var dance_of_death = $BaseInfo/StatusEffects/VBoxContainer/DanceOfDeath
onready var mental_shield = $BaseInfo/StatusEffects/VBoxContainer/MentalShield
onready var warning_strike = $BaseInfo/StatusEffects/VBoxContainer/WarningStrike
onready var stone_shield = $BaseInfo/StatusEffects/VBoxContainer/StoneShield
onready var spiked_shield = $BaseInfo/StatusEffects/VBoxContainer/SpikedShield
onready var cleansing = $BaseInfo/StatusEffects/VBoxContainer/Cleansing
onready var bdigo = $BaseInfo/StatusEffects/VBoxContainer/BDIGO
onready var waiting_game = $BaseInfo/StatusEffects/VBoxContainer/WaitingGame
onready var studying = $BaseInfo/StatusEffects/VBoxContainer/Studying
onready var fury = $BaseInfo/StatusEffects/VBoxContainer/Fury
onready var blood_exchange = $BaseInfo/StatusEffects/VBoxContainer/BloodExchange
onready var ult__dance__of__death = $BaseInfo/StatusEffects/VBoxContainer/ULT_Dance_Of_Death
onready var ult__blood__moon = $BaseInfo/StatusEffects/VBoxContainer/ULT_Blood_Moon
onready var ult__adaptation = $BaseInfo/StatusEffects/VBoxContainer/ULT_Adaptation
onready var ult__stone__cocoon = $BaseInfo/StatusEffects/VBoxContainer/ULT_Stone_Cocoon
onready var ult__balanced__instability = $BaseInfo/StatusEffects/VBoxContainer/ULT_Balanced_Instability
onready var ult__time__warp = $BaseInfo/StatusEffects/VBoxContainer/ULT_Time_Warp
onready var ult__growing__pain = $BaseInfo/StatusEffects/VBoxContainer/ULT_Growing_Pain
onready var ult__beautiful__garden = $BaseInfo/StatusEffects/VBoxContainer/ULT_Beautiful_Garden
onready var ult__mental__spiral = $BaseInfo/StatusEffects/VBoxContainer/ULT_Mental_Spiral
onready var ult__cycle__of__sadness = $BaseInfo/StatusEffects/VBoxContainer/ULT_Cycle_Of_Sadness
onready var ult__pandoras__box = $BaseInfo/StatusEffects/VBoxContainer/ULT_Pandoras_Box
onready var ult__growing__fracture = $BaseInfo/StatusEffects/VBoxContainer/ULT_Growing_Fracture
onready var ult__white__silence = $BaseInfo/StatusEffects/VBoxContainer/ULT_White_Silence
onready var ult__regression = $BaseInfo/StatusEffects/VBoxContainer/ULT_Regression
onready var growing_fracture = $BaseInfo/StatusEffects/VBoxContainer/GrowingFracture
onready var regression = $BaseInfo/StatusEffects/VBoxContainer/Regression


func Open():
	camera_info.current = true
	camera_info.SetPosition("player")
	info_type = "status effects"
	target = 0
	CheckTargets()
	ChangeTarget()
	TurnOnStatusEffects()
	$AnimationPlayer.play("Open")
	self.visible = true
	control.visible = false
	get_tree().paused = true

func Close():
	$AnimationPlayer.play("Close")

func CloseFinal():
	camera_2d.current = true
	control.visible = true
	get_tree().paused = false

func CheckTargets():
	targets = ["player"]
	for i in range(3):
		if get_node(str("../../BattleOrder/Enemy", i + 1)).active == true:
			targets.append(str("enemy", i + 1))

func ChangeTarget():
	TurnOnStatusEffects()
	ClearAll()
	camera_info.SetPosition(targets[target])
	enr_num.text = "10"
	var color_res = []
	match targets[target]:
		"player":
			$Name.text = "Salim"
			character = get_node("../../BattleOrder/Player")
			enr_num.text = str(character.ENR)
			PlayerStatuses()
		"enemy1":
			character = get_node(str("../../BattleOrder/Enemy1")).get_child(1)
			$Name.text = character.en_name
			EnemyStatuses()
		"enemy2":
			character = get_node(str("../../BattleOrder/Enemy2")).get_child(1)
			$Name.text = character.en_name
			EnemyStatuses()
		"enemy3":
			character = get_node(str("../../BattleOrder/Enemy3")).get_child(1)
			$Name.text = character.en_name
			EnemyStatuses()
	
	atk_num.text = str(character.ATK)
	def_num.text = str(character.DEF)
	end_num.text = str(character.END)
	spd_num.text = str(character.SPD)
	sen_num.text = str(character.SEN)
	res_num.text = str(character.RES)
	crit_num.text = str(character.CRIT)
	avo_num.text = str(character.AVO)
	color_res = [character.red_res, character.orange_res, character.yellow_res, character.green_res,
		character.blue_res, character.purple_res]
	
	
	
	for i in range(6):
		immunities.get_child(i).visible = false
		resistances.get_child(i).visible = false
		weaknesses.get_child(i).visible = false
		fatals.get_child(i).visible = false
		
		match color_res[i]:
			0:
				immunities.get_child(i).visible = true
			0.5:
				resistances.get_child(i).visible = true
			1:
				pass
			2:
				weaknesses.get_child(i).visible = true
			4:
				fatals.get_child(i).visible = true
	

func EnemyStatuses():
	# Applied by Allies
	if character.mentalprotection_duration != 0:
		mental_protection.visible = true
		mental_protection.get_node("Duration").text = str("DURATION_", character.mentalprotection_duration)
	else:
		mental_protection.visible = false
	if character.protecttheart_duration != 0:
		protect_the_art.visible = true
		protect_the_art.get_node("Duration").text = str("DURATION_", character.protecttheart_duration)
	else:
		protect_the_art.visible = false
	if character.burstofenergy_duration != 0:
		burst_of_energy.visible = true
		burst_of_energy.get_node("Duration").text = str("DURATION_", character.burstofenergy_duration)
	else:
		burst_of_energy.visible = false
	if character.scorchingheat_duration != 0:
		scorching_heat.visible = true
		scorching_heat.get_node("Duration").text = str("DURATION_", character.scorchingheat_duration)
	else:
		scorching_heat.visible = false
	
	# Universal
	if character.sleep_duration != 0:
		sleep.visible = true
		sleep.get_node("Duration").text = str("DURATION_", character.sleep_duration)
	else:
		sleep.visible = false
	
	if character.fragile_duration != 0:
		fragile.visible = true
		fragile.get_node("Duration").text = str("DURATION_", character.fragile_duration)
		fragile.get_node("StatusText").text = str("Damage recieved increases by ", character.fragile * 100, "%.")
	else:
		fragile.visible = false
	if character.spread_duration != 0:
		spread.visible = true
		spread.get_node("Duration").text = str("DURATION_", character.spread_duration)
		spread.get_node("StatusText").text = str("CRIT of attacks made against this unit increases by ", character.spread, ". Effect is doubled if the attack is green.")
	else:
		spread.visible = false
	if character.spread_duration != 0:
		spread.visible = true
		spread.get_node("Duration").text = str("DURATION_", character.spread_duration)
		spread.get_node("StatusText").text = str("CRIT of attacks made against this unit increases by ", character.spread, ". Effect is doubled if the attack is green.")
	else:
		spread.visible = false
	if character.bind_duration != 0:
		bind.visible = true
		bind.get_node("Duration").text = str("DURATION_", character.bind_duration)
		bind.get_node("StatusText").text = str("Decreases hit chance by ", character.bind, " and SPD by third.")
	else:
		bind.visible = false
	if character.miasma_duration != 0:
		miasma.visible = true
		miasma.get_node("Duration").text = str("DURATION_", character.miasma_duration)
		miasma.get_node("StatusText").text = str("RES -", character.miasma)
	else:
		miasma.visible = false
	if character.haste_duration != 0:
		haste.visible = true
		haste.get_node("Duration").text = str("DURATION_", character.haste_duration)
		haste.get_node("StatusText").text = str("Increases SPD by ", character.haste, ".")
	else:
		haste.visible = false
	if character.block_num != 0:
		block.visible = true
		block.get_node("StatusText").text = str("Blocks ", character.block_num, " instances of damage.")
	else:
		block.visible = false
	if character.closure_duration != 0:
		closure.visible = true
		closure.get_node("Duration").text = str("DURATION_", character.closure_duration)
		closure.get_node("StatusText").text = str("SPD -", character.closure, " and can't gain additional actions.")
	else:
		closure.visible = false
	if character.aches_duration != 0:
		aches.visible = true
		aches.get_node("Duration").text = str("DURATION_", character.aches_duration)
		aches.get_node("StatusText").text = str("Damage dealt is decreased by ", character.aches * 100, ".")
	else:
		aches.visible = false
	if character.empowerment_duration != 0:
		empowerment.visible = true
		empowerment.get_node("Duration").text = str("DURATION_", character.empowerment_duration)
		empowerment.get_node("StatusText").text = str("Damage dealt is increased by ", character.empowerment, ".")
	else:
		empowerment.visible = false
	if character.blind_duration != 0:
		blindness.visible = true
		blindness.get_node("Duration").text = str("DURATION_", character.blind_duration)
		blindness.get_node("StatusText").text = str("Hit chance and AVO are decreased by ", character.blind, ".")
	else:
		blindness.visible = false
	if character.silence_duration != 0:
		silence.visible = true
		silence.get_node("Duration").text = str("DURATION_", character.silence_duration)
	else:
		silence.visible = false
	if character.exhaustion != 0:
		exhaustion.visible = true
		exhaustion.get_node("StatusText").text = str("At the start of each turn lose ", character.exhaustion, " EN and take ", character.exhaustion * (5 + character.exhaustion_plus), " blue damage.")
		exhaustion.get_node("Stacks").text = str(tr("Stacks: "), character.exhaustion)
	else:
		exhaustion.visible = false
	
	
	# Applied by Salim
	if character.growing_fracture_duration != 0:
		growing_fracture.visible = true
		growing_fracture.get_node("Duration").text = str("DURATION_", character.growing_fracture_duration)
		growing_fracture.get_node("StatusText").text = str(tr("Each turn increase Fragile on self by"), character.growing_fracture, ".")
	else:
		growing_fracture.visible = false
	if character.danceofdeath_duration != 0:
		dance_of_death.visible = true
		dance_of_death.get_node("Duration").text = str("DURATION_", character.danceofdeath_duration)
	else:
		dance_of_death.visible = false
	if character.regression_duration != 0:
		regression.visible = true
		regression.get_node("Duration").text = str("DURATION_", character.regression_duration)
		regression.get_node("StatusText").text = tr(str(character.regression_color, "_REGRESSION"))
	else:
		regression.visible = false

func PlayerStatuses():
	# Universal Statuses
	var status_effects = character.status_effects
	if status_effects.fragile_duration != 0:
		fragile.visible = true
		fragile.get_node("Duration").text = str("DURATION_", status_effects.fragile_duration)
		fragile.get_node("StatusText").text = str("Damage recieved increases by ", status_effects.fragile * 100, "%.")
	else:
		fragile.visible = false
	if status_effects.spread_duration != 0:
		spread.visible = true
		spread.get_node("Duration").text = str("DURATION_", status_effects.spread_duration)
		spread.get_node("StatusText").text = str("CRIT of attacks made against this unit increases by ", character.spread, ". Effect is doubled if the attack is green.")
	else:
		spread.visible = false
	if status_effects.spread_duration != 0:
		spread.visible = true
		spread.get_node("Duration").text = str("DURATION_", status_effects.spread_duration)
		spread.get_node("StatusText").text = str("CRIT of attacks made against this unit increases by ", character.spread, ". Effect is doubled if the attack is green.")
	else:
		spread.visible = false
	if status_effects.bind_duration != 0:
		bind.visible = true
		bind.get_node("Duration").text = str("DURATION_", status_effects.bind_duration)
		bind.get_node("StatusText").text = str("Decreases hit chance by ", status_effects.bind, " and SPD by third.")
	else:
		bind.visible = false
	if status_effects.miasma_duration != 0:
		miasma.visible = true
		miasma.get_node("Duration").text = str("DURATION_", status_effects.miasma_duration)
		miasma.get_node("StatusText").text = str("RES -", status_effects.miasma)
	else:
		miasma.visible = false
	if status_effects.haste_duration != 0:
		haste.visible = true
		haste.get_node("Duration").text = str("DURATION_", status_effects.haste_duration)
		haste.get_node("StatusText").text = str("Increases SPD by ", status_effects.haste_SPD, " and decreases skills' CD by ", status_effects.haste_cd,".")
	else:
		haste.visible = false
	if character.total_block != 0:
		block.visible = true
		block.get_node("StatusText").text = str("Blocks ", character.total_block, " instances of damage.")
	else:
		block.visible = false
	if status_effects.closure_duration != 0:
		closure.visible = true
		closure.get_node("Duration").text = str("DURATION_", status_effects.closure_duration)
		closure.get_node("StatusText").text = str("SPD -", status_effects.closure, " and can't gain additional actions.")
	else:
		closure.visible = false
	if status_effects.aches_duration != 0:
		aches.visible = true
		aches.get_node("Duration").text = str("DURATION_", status_effects.aches_duration)
		aches.get_node("StatusText").text = str("Damage dealt is decreased by ", status_effects.aches * 100, ".")
	else:
		aches.visible = false
	if status_effects.empowerment_duration != 0:
		empowerment.visible = true
		empowerment.get_node("Duration").text = str("DURATION_", status_effects.empowerment_duration)
		empowerment.get_node("StatusText").text = str("Damage dealt is increased by ", status_effects.empowerment, ".")
	else:
		empowerment.visible = false
	if status_effects.blind_duration != 0:
		blindness.visible = true
		blindness.get_node("Duration").text = str("DURATION_", status_effects.blind_duration)
		blindness.get_node("StatusText").text = str("Hit chance and AVO are decreased by ", status_effects.blind, ".")
	else:
		blindness.visible = false
	if status_effects.silence_duration != 0:
		silence.visible = true
		silence.get_node("Duration").text = str("DURATION_", status_effects.silence_duration)
	else:
		silence.visible = false
	if status_effects.exhaustion != 0:
		exhaustion.visible = true
		exhaustion.get_node("StatusText").text = str("At the start of each turn lose ", status_effects.exhaustion, " EN and take ", status_effects.exhaustion * 5, " blue damage.")
		exhaustion.get_node("Stacks").text = str(tr("Stacks: "), status_effects.exhaustion)
	else:
		exhaustion.visible = false
	
	# Passives
	if status_effects.mental_shield == true:
		mental_shield.visible = true
		mental_shield.get_node("Duration").text = str("DURATION_", character.shield_duration)
	else:
		mental_shield.visible = false
	if status_effects.orange_shield == true:
		stone_shield.visible = true
		stone_shield.get_node("Duration").text = str("DURATION_", character.shield_duration)
	else:
		stone_shield.visible = false
	if status_effects.spiked_shield == true:
		spiked_shield.visible = true
		spiked_shield.get_node("Duration").text = str("DURATION_", character.shield_duration)
	else:
		spiked_shield.visible = false
	if status_effects.WarningStrike_Duration != 0:
		warning_strike.visible = true
		warning_strike.get_node("StatusText").text = str("Next attack deals ", status_effects.WarningStrike_Mod * 100, "% more damage.")
	else:
		warning_strike.visible = false
	if status_effects.Cleansing_Duration != 0:
		cleansing.visible = true
		cleansing.get_node("Duration").text = str("DURATION_", character.Cleansing_Duration)
		cleansing.get_node("StatusText").text = str("RES +", status_effects.Cleansing_Effect, ".")
	else:
		cleansing.visible = false
	if status_effects.BDIGO_ATK_MOD != 0:
		bdigo.visible = true
		bdigo.get_node("StatusText").text = str("ATK +", status_effects.BDIGO_ATK_MOD, ".")
	else:
		bdigo.visible = false
	if status_effects.waiting_game_summ != 0:
		waiting_game.visible = true
		waiting_game.get_node("StatusText").text = str("CRIT +", status_effects.waiting_game_summ, ".")
	else:
		waiting_game.visible = false
	if character.studying == true:
		studying.visible = true
	else:
		studying.visible = false
	if status_effects.fury != 0:
		fury.visible = true
		fury.get_node("StatusText").text = str("ATK +", status_effects.fury, ".")
		fury.get_node("Stacks").text = str(tr("Stacks: "), status_effects.fury / status_effects.fury_gain)
	else:
		fury.visible = false
	if status_effects.BloodExchange_Duration != 0:
		blood_exchange.visible = true
		blood_exchange.get_node("Duration").text = str("DURATION_", status_effects.BloodExchange_Duration)
		blood_exchange.get_node("StatusText").text = str(tr("You gain "), status_effects.BloodExchange_Mod * 100, tr("% Empowerment."))
	
	# Ultimates
	if status_effects.DanceOfDeath_Duration != 0:
		ult__dance__of__death.visible = true
		ult__dance__of__death.get_node("Duration").text = str("DURATION_", status_effects.DanceOfDeath_Duration)
		ult__dance__of__death.get_node("StatusText").text = str("DANCE_OF_DEATH_", character.ult_lvl)
	else:
		ult__dance__of__death.visible = false
	if status_effects.BloodMoon_Duration != 0:
		ult__blood__moon.visible = true
		ult__blood__moon.get_node("Duration").text = str("DURATION_", status_effects.BloodMoon_Duration)
		ult__blood__moon.get_node("StatusText").text = str("BLOOD_MOON_", character.ult_lvl)
	else:
		ult__blood__moon.visible = false
	if status_effects.Adaptation_Duration != 0:
		ult__adaptation.visible = true
		ult__adaptation.get_node("Duration").text = str("DURATION_", status_effects.Adaptation_Duration)
		ult__adaptation.get_node("StatusText").text = str("ADAPTATION_", character.ult_lvl)
	else:
		ult__adaptation.visible = false
	if status_effects.StoneCocoon_Duration != 0:
		ult__stone__cocoon.visible = true
		ult__stone__cocoon.get_node("Duration").text = str("DURATION_", status_effects.StoneCocoon_Duration)
		ult__stone__cocoon.get_node("StatusText").text = str("STONE_COCOON_", character.ult_lvl)
	else:
		ult__stone__cocoon.visible = false
	if status_effects.BalancedInstability_Duration != 0:
		ult__balanced__instability.visible = true
		ult__balanced__instability.get_node("Duration").text = str("DURATION_", status_effects.BalancedInstability_Duration)
		ult__balanced__instability.get_node("StatusText").text = str("BALANCED_INSTABILITY_", character.ult_lvl)
	else:
		ult__balanced__instability.visible = false
	if status_effects.TimeWarp_Duration != 0:
		ult__time__warp.visible = true
		ult__time__warp.get_node("Duration").text = str("DURATION_", status_effects.TimeWarp_Duration)
		ult__time__warp.get_node("StatusText").text = str("TIME_WARP_", character.ult_lvl)
	else:
		ult__time__warp.visible = false
	if status_effects.GrowingPain_Duration != 0:
		ult__growing__pain.visible = true
		ult__growing__pain.get_node("Duration").text = str("DURATION_", status_effects.GrowingPain_Duration)
		ult__growing__pain.get_node("StatusText").text = str("GROWING_PAIN_", character.ult_lvl)
	else:
		ult__growing__pain.visible = false
	if status_effects.BeautifulGarden_Duration != 0:
		ult__beautiful__garden.visible = true
		ult__beautiful__garden.get_node("Duration").text = str("DURATION_", status_effects.BeautifulGarden_Duration)
		ult__beautiful__garden.get_node("StatusText").text = str("BEAUTIFUL_GARDER_", character.ult_lvl)
	else:
		ult__beautiful__garden.visible = false
	if status_effects.MentalSpiral_Duration != 0:
		ult__mental__spiral.visible = true
		ult__mental__spiral.get_node("Duration").text = str("DURATION_", status_effects.MentalSpiral_Duration)
		ult__mental__spiral.get_node("StatusText").text = str("MENTAL_SPIRAL_", character.ult_lvl)
	else:
		ult__mental__spiral.visible = false
	if status_effects.CycleOfSadness_Duration != 0:
		ult__cycle__of__sadness.visible = true
		ult__cycle__of__sadness.get_node("Duration").text = str("DURATION_", status_effects.CycleOfSadness_Duration)
		ult__cycle__of__sadness.get_node("StatusText").text = str("CYCLE_OF_SADNESS_", character.ult_lvl)
	else:
		ult__cycle__of__sadness.visible = false
	if status_effects.PandorasBox_Duration != 0:
		ult__pandoras__box.visible = true
		ult__pandoras__box.get_node("Duration").text = str("DURATION_", status_effects.PandorasBox_Duration)
		ult__pandoras__box.get_node("StatusText").text = str("PANDORAS_BOX_", character.ult_lvl)
	else:
		ult__pandoras__box.visible = false
	if status_effects.GrowingFracture_Duration != 0:
		ult__growing__fracture.visible = true
		ult__growing__fracture.get_node("Duration").text = str("DURATION_", status_effects.GrowingFracture_Duration)
		ult__growing__fracture.get_node("StatusText").text = str("GROWING_FRACTURE_", character.ult_lvl)
	else:
		ult__growing__fracture.visible = false
	if status_effects.WhiteSilence_Duration != 0:
		ult__white__silence.visible = true
		ult__white__silence.get_node("Duration").text = str("DURATION_", status_effects.WhiteSilence_Duration)
		ult__white__silence.get_node("StatusText").text = str("WHITE_SILENCE_", character.ult_lvl)
	else:
		ult__white__silence.visible = false
	if status_effects.Regression_Duration != 0:
		ult__regression.visible = true
		ult__regression.get_node("Duration").text = str("DURATION_", status_effects.Regression_Duration)
		ult__regression.get_node("StatusText").text = str("REGRESSION_", character.ult_lvl)
	else:
		ult__regression.visible = false

func ClearAll():
	for i in $BaseInfo/StatusEffects/VBoxContainer.get_children():
		i.visible = false

func _input(event):
	if event.is_action_pressed("left"):
		target -= 1
		if target < 0:
			target = targets.size() - 1
		
		ChangeTarget()
	if event.is_action_pressed("right"):
		target += 1
		if target > targets.size() - 1:
			target = 0
		
		ChangeTarget()

func TurnOnStatusEffects():
	base_info.visible = true
	talents.visible = false

func TurnOnPassives():
	base_info.visible = false
	talents.visible = true
	
	salim.visible = false
	guard.visible = false
	gunner.visible = false
	dp_cold.visible = false
	dp_warm.visible = false
	
	match targets[target]:
		"player":
			salim.visible = true
		"enemy1":
			get_node(str("Talents/", get_node(str("../../BattleOrder/Enemy1")).get_child(1).en_name)).visible = true
		"enemy2":
			get_node(str("Talents/", get_node(str("../../BattleOrder/Enemy2")).get_child(1).en_name)).visible = true
		"enemy3":
			get_node(str("Talents/", get_node(str("../../BattleOrder/Enemy3")).get_child(1).en_name)).visible = true


func _on_INFO_pressed():
	SoundPlayer.play_sound("Click")
	info_type = "status effects"
	TurnOnStatusEffects()

func _on_TALENTS_pressed():
	SoundPlayer.play_sound("Click")
	info_type = "talents"
	TurnOnPassives()

func _on_Close_pressed():
	SoundPlayer.play_sound("Click")
	Close()
