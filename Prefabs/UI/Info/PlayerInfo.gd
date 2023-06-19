extends NinePatchRect

onready var player = $"../../../../../BattleOrder/Player"
onready var player_se = $"../../../../../BattleOrder/Player/StatusEffects"

func Open():
	#Stats
	$Stats/ATKNum.text = str(player.ATK)
	$Stats/DEFNum.text = str(player.DEF)
	$Stats/ENDNum.text = str(player.END)
	$Stats/SENNum.text = str(player.SEN)
	$Stats/SPDNum.text = str(player.SPD)
	$Stats/ENRNum.text = str(player.ENR)
	$Stats/RESNum.text = str(player.RES)
	$Stats/CRITNum.text = str(player.CRIT)
	$Stats/AVONum.text = str(player.AVO)
	
	#Resistances
	$Weaknesses/Red_res.text = Res(player.red_res)
	$Weaknesses/Orange_res.text = Res(player.orange_res)
	$Weaknesses/Yellow_res.text = Res(player.yellow_res)
	$Weaknesses/Green_res.text = Res(player.green_res)
	$Weaknesses/Blue_res.text = Res(player.blue_res)
	$Weaknesses/Purple_res.text = Res(player.purple_res)
	
	#Fragile
	if player_se.fragile_duration != 0:
		$StatusEffects/VBoxContainer/Fragile.visible = true
		$StatusEffects/VBoxContainer/Fragile/Status2.text = str(tr("Fragile"), ": ", player_se.fragile, "%")
		$StatusEffects/VBoxContainer/Fragile/Duration2.text = str("DURATION_", player_se.fragile_duration)
	else:
		$StatusEffects/VBoxContainer/Fragile.visible = false
	
	#Closure
	if player_se.closure_duration != 0:
		$StatusEffects/VBoxContainer/Closure.visible = true
		$StatusEffects/VBoxContainer/Closure/Status2.text = str(tr("Closure"), " ", player_se.closure)
		$StatusEffects/VBoxContainer/Closure/Duration2.text = str("DURATION_", player_se.closure_duration)
	else:
		$StatusEffects/VBoxContainer/Closure.visible = false
	
	#Aches
	if player_se.aches_duration != 0:
		$StatusEffects/VBoxContainer/Aches.visible = true
		$StatusEffects/VBoxContainer/Aches/Status2.text = str(tr("Aches"), ": ", player_se.aches, "%")
		$StatusEffects/VBoxContainer/Aches/Duration2.text = str("DURATION_", player_se.aches_duration)
	else:
		$StatusEffects/VBoxContainer/Aches.visible = false
	
	#Empowerment
	if player_se.empowerment_duration != 0:
		$StatusEffects/VBoxContainer/Empowerment.visible = true
		$StatusEffects/VBoxContainer/Empowerment/Icon.text = str(tr("Empowerment"), ": ", player_se.empowerment, "%")
		$StatusEffects/VBoxContainer/Empowerment/Duration2.text = str("DURATION_", player_se.empowerment_duration)
	else:
		$StatusEffects/VBoxContainer/Empowerment.visible = false
	
	#Blind
	if player_se.blind_duration != 0:
		$StatusEffects/VBoxContainer/Blind.visible = true
		$StatusEffects/VBoxContainer/Blind/name.text = str(tr("Blind"), ": ", player_se.blind, "%")
		$StatusEffects/VBoxContainer/Blind/Duration2.text = str("DURATION_", player_se.blind_duration)
	else:
		$StatusEffects/VBoxContainer/Blind.visible = false
	
	#Silence
	if player_se.silence_duration != 0:
		$StatusEffects/VBoxContainer/Silence.visible = true
		$StatusEffects/VBoxContainer/Silence/Duration2.text = str("DURATION_", player_se.blind_duration)
	else:
		$StatusEffects/VBoxContainer/Silence.visible = false
	
	#Exhaustion
	if player_se.exhaustion != 0:
		$StatusEffects/VBoxContainer/Exhaustion.visible = true
		$StatusEffects/VBoxContainer/Exhaustion/name.text = str(tr("Exhaustion"), ": ", player_se.exhaustion, " EN")
	else:
		$StatusEffects/VBoxContainer/Exhaustion.visible = false
	
	#Block
	if player.total_block != 0:
		$StatusEffects/VBoxContainer/Block/Duration2.text = str(player.total_block, " ", tr("Hits"))
		$StatusEffects/VBoxContainer/Block.visible = true
	else:
		$StatusEffects/VBoxContainer/Block.visible = false
	
	#Spread
	if player_se.spread_duration != 0:
		$StatusEffects/VBoxContainer/Spread/Duration2.text = str("DURATION_", player_se.spread_duration)
		$StatusEffects/VBoxContainer/Spread/Status2.text = str(tr("Spread"), " ", player_se.spread, "%")
		$StatusEffects/VBoxContainer/Spread.visible = true
	else:
		$StatusEffects/VBoxContainer/Spread.visible = false
	
	#Bind
	if player_se.bind_duration != 0:
		$StatusEffects/VBoxContainer/Bind/Duration2.text = str("DURATION_", player_se.bind_duration)
		$StatusEffects/VBoxContainer/Bind/Status2.text = str(tr("Bind"), " ", player_se.bind, "%")
		$StatusEffects/VBoxContainer/Bind.visible = true
	else:
		$StatusEffects/VBoxContainer/Bind.visible = false
	
	#Miasma
	if player_se.miasma_duration != 0:
		$StatusEffects/VBoxContainer/Miasma/Duration2.text = str("DURATION_", player_se.miasma_duration)
		$StatusEffects/VBoxContainer/Miasma/Status2.text = str(tr("Miasma"), " ", player_se.miasma, "%")
		$StatusEffects/VBoxContainer/Miasma.visible = true
	else:
		$StatusEffects/VBoxContainer/Miasma.visible = false
	
	#Haste
	if player_se.haste_duration != 0:
		$StatusEffects/VBoxContainer/Haste/Duration2.text = str("DURATION_", player_se.haste_duration)
		$StatusEffects/VBoxContainer/Haste/Status2.text = str(tr("Haste"), " (", player_se.haste_SPD, "/", player_se.haste_cd, ")")
		$StatusEffects/VBoxContainer/Haste.visible = true
	else:
		$StatusEffects/VBoxContainer/Haste.visible = false
	
	#Mental Shield
	if player_se.mental_shield == true:
		$StatusEffects/VBoxContainer/MentalShield.visible = true
		$StatusEffects/VBoxContainer/MentalShield/Duration2.text = str("DURATION_", player.shield_duration)
	else:
		$StatusEffects/VBoxContainer/MentalShield.visible = false
	
	#Orange Shield
	if player_se.orange_shield == true:
		$StatusEffects/VBoxContainer/OrangeShield.visible = true
		$StatusEffects/VBoxContainer/OrangeShield/Duration2.text = str("DURATION_", player.shield_duration)
	else:
		$StatusEffects/VBoxContainer/OrangeShield.visible = false
	
	#Spiked Shield
	if player_se.spiked_shield == true:
		$StatusEffects/VBoxContainer/SpikedShield.visible = true
		$StatusEffects/VBoxContainer/SpikedShield/Duration2.text = str("DURATION_", player.shield_duration)
	else:
		$StatusEffects/VBoxContainer/SpikedShield.visible = false
	
	#Warning Strike
	if player_se.WarningStrike_Duration != 0:
		$StatusEffects/VBoxContainer/FirstHit.visible = true
		$StatusEffects/VBoxContainer/FirstHit/Status.text = str(tr("Your next attack deals "), player_se.WarningStrike_Mod * 100, tr("% more damage."))
		$StatusEffects/VBoxContainer/FirstHit/Duration2.text = str("DURATION_", player_se.WarningStrike_Duration)
	else:
		$StatusEffects/VBoxContainer/FirstHit.visible = false
	
	#Cleansing
	if player_se.Cleansing_Duration != 0:
		$StatusEffects/VBoxContainer/Cleansing/Duration2.text = str("DURATION_", player_se.Cleansing_Duration)
		$StatusEffects/VBoxContainer/Cleansing/Status.text = str("RES +", player_se.Cleansing_Effect)
		$StatusEffects/VBoxContainer/Cleansing.visible = true
	else:
		$StatusEffects/VBoxContainer/Cleansing.visible = false
	
	#BDIGO
	if player_se.BDIGO_ATK_MOD != 0:
		$StatusEffects/VBoxContainer/BDIGO/Status.text = str("ATK +", player_se.BDIGO_ATK_MOD)
		$StatusEffects/VBoxContainer/BDIGO.visible = true
	else:
		$StatusEffects/VBoxContainer/BDIGO.visible = false
	
	#Studying
	$StatusEffects/VBoxContainer/Studying.visible = player.studying
	
	#Waiting Game
	if player_se.waiting_game_summ != 0:
		$StatusEffects/VBoxContainer/WaitingGame/name.text = str("CRIT +", player_se.waiting_game_summ)
		$StatusEffects/VBoxContainer/WaitingGame.visible = true
	else:
		$StatusEffects/VBoxContainer/WaitingGame.visible = false
	
	#Fury
	if player_se.fury != 0:
		$StatusEffects/VBoxContainer/Fury/Status.text = str("ATK +", player_se.fury)
		$StatusEffects/VBoxContainer/Fury.visible = true
	else:
		$StatusEffects/VBoxContainer/Fury.visible = false
	
	#ULTS
	#Dance Of Death
	if player_se.DanceOfDeath_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Dance_Of_Death/Status2.text = str("ATK +", player_se.DanceOfDeath_Mod)
		$StatusEffects/VBoxContainer/ULT_Dance_Of_Death/Duration2.text = str("DURATION_", player_se.DanceOfDeath_Duration)
		$StatusEffects/VBoxContainer/ULT_Dance_Of_Death.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Dance_Of_Death.visible = false
	
	#Blood Moon
	if player_se.BloodMoon_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Blood_Moon/Status2.text = str("ATK +", player_se.BloodMoon_Mod, ", DEF -", player_se.BloodMoon_Mod)
		$StatusEffects/VBoxContainer/ULT_Blood_Moon/Duration2.text = str("DURATION_", player_se.BloodMoon_Duration)
		$StatusEffects/VBoxContainer/ULT_Blood_Moon/Status.text = str("BLOOD_MOON_STATUS_", player.ult_lvl)
		$StatusEffects/VBoxContainer/ULT_Blood_Moon.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Blood_Moon.visible = false
	
	#Adaptation
	if player_se.Adaptation_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Adaptation/Status.text = str("ATK ",  tr("and"),  " DEF +", player_se.Adaptation_Mod)
		$StatusEffects/VBoxContainer/ULT_Adaptation/Duration2.text = str("DURATION_", player_se.Adaptation_Duration)
		$StatusEffects/VBoxContainer/ULT_Adaptation.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Adaptation.visible = false
	
	#Adaptation
	if player_se.StoneCocoon_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Stone_Cocoon/Status.text = str("RES ", tr("and"),  " DEF +", player_se.StoneCocoon_Mod)
		$StatusEffects/VBoxContainer/ULT_Stone_Cocoon/Duration2.text = str("DURATION_", player_se.StoneCocoon_Duration)
		$StatusEffects/VBoxContainer/ULT_Stone_Cocoon.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Stone_Cocoon.visible = false
	
	#Balanced Instability
	if player_se.BalancedInstability_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Balanced_Instability/Status2.text = str("ATK ",  tr("and"),  " SEN +", player_se.BalancedInstability_Mod)
		$StatusEffects/VBoxContainer/ULT_Balanced_Instability/Duration2.text = str("DURATION_", player_se.BalancedInstability_Duration)
		$StatusEffects/VBoxContainer/ULT_Balanced_Instability/Status.text = str("BALANCED_INSTABILITY_STATUS_", player.ult_lvl)
		$StatusEffects/VBoxContainer/ULT_Balanced_Instability.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Balanced_Instability.visible = false
	
	#Time Warp
	if player_se.TimeWarp_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Time_Warp/Status.text = str("SPD ",  tr("and"),  " SEN +", player_se.TimeWarp_Mod)
		$StatusEffects/VBoxContainer/ULT_Time_Warp/Duration2.text = str("DURATION_", player_se.TimeWarp_Duration)
		$StatusEffects/VBoxContainer/ULT_Time_Warp.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Time_Warp.visible = false
	
	#Growing Pain
	if player_se.GrowingPain_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Growing_Pain/Status.text = str("ATK ",  tr("and"),  " SEN +", player_se.GrowingPain_Mod)
		$StatusEffects/VBoxContainer/ULT_Growing_Pain/Duration2.text = str("DURATION_", player_se.GrowingPain_Duration)
		$StatusEffects/VBoxContainer/ULT_Growing_Pain.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Growing_Pain.visible = false
	
	#Beautiful Garden
	if player_se.BeautifulGarden_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Beautiful_Garden/Status.text = str("ATK +", player_se.BeautifulGarden_Mod)
		$StatusEffects/VBoxContainer/ULT_Beautiful_Garden/Duration2.text = str("DURATION_", player_se.BeautifulGarden_Duration)
		$StatusEffects/VBoxContainer/ULT_Beautiful_Garden.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Beautiful_Garden.visible = false
	
	#Mental Spiral
	if player_se.MentalSpiral_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Mental_Spiral/Status.text = str("ENR +", player_se.MentalSpiral_Mod)
		$StatusEffects/VBoxContainer/ULT_Mental_Spiral/Duration2.text = str("DURATION_", player_se.MentalSpiral_Duration)
		$StatusEffects/VBoxContainer/ULT_Mental_Spiral.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Mental_Spiral.visible = false
	
	#Cycle Of Sadness
	if player_se.CycleOfSadness_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Cycle_Of_Sadness/Status.text = str("ENR +", player_se.CycleOfSadness_Mod)
		$StatusEffects/VBoxContainer/ULT_Cycle_Of_Sadness/Duration2.text = str("DURATION_", player_se.CycleOfSadness_Duration)
		$StatusEffects/VBoxContainer/ULT_Cycle_Of_Sadness.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Cycle_Of_Sadness.visible = false
	
	#Pandora's Box
	if player_se.PandorasBox_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Pandoras_Box/Status.text = str("ATK ",  tr("and"),  " RES +", player_se.PandorasBox_Mod)
		$StatusEffects/VBoxContainer/ULT_Pandoras_Box/Duration2.text = str("DURATION_", player_se.PandorasBox_Duration)
		$StatusEffects/VBoxContainer/ULT_Pandoras_Box.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Pandoras_Box.visible = false
	
	#Growing Fracture
	if player_se.GrowingFracture_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_Growing_Fracture/Status.text = str("RES +", player_se.GrowingFracture_Mod)
		$StatusEffects/VBoxContainer/ULT_Growing_Fracture/Duration2.text = str("DURATION_", player_se.GrowingFracture_Duration)
		$StatusEffects/VBoxContainer/ULT_Growing_Fracture.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_Growing_Fracture.visible = false
	
	#White Silence
	if player_se.WhiteSilence_Duration != 0:
		$StatusEffects/VBoxContainer/ULT_White_Silence/Status.text = str("ATK +", player_se.WhiteSilence_Mod)
		$StatusEffects/VBoxContainer/ULT_White_Silence/Duration2.text = str("DURATION_", player_se.WhiteSilence_Duration)
		$StatusEffects/VBoxContainer/ULT_White_Silence.visible = true
	else:
		$StatusEffects/VBoxContainer/ULT_White_Silence.visible = false

func Res(num):
	match num:
		0:
			return "IM"
		1:
			return "-"
		2:
			return "W"
		0.5:
			return "R"
