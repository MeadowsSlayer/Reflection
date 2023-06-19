extends Node2D

var save = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var passives = save.get("passives")
var gen = RandomNumberGenerator.new()

var status_resistance = 10

#Standart Aligments
var fragile = 0
var fragile_duration = 0
var spread = 0
var spread_duration = 0
var silence_duration = 0
var closure = 0
var closure_duration = 0
var exhaustion = 0
var aches = 0
var aches_duration = 0
var bind = 0
var bind_duration = 0
var haste_SPD = 0
var haste_cd = 0
var haste_duration = 0
var empowement = 0
var empowerment_duration = 0
var blind = 0
var blind_duration = 0
var miasma = 0
var miasma_duration = 0

#Enemies' Alighments
var TargetTheWeak_DEF_debuff = 0
var TargetTheWeak_duration = 0

#Skills Aligmnets
var Cleansing_Duration = 0
var Cleansing_Effect = 0
var Adaptation_Mod = 0
var Adaptation_Duration = 0
var StoneCocoon_Mod = 0
var StoneCocoon_Duration = 0
var GrowingPain_Mod = 0
var GrowingPain_Duration = 0
var BeautifulGarden_Mod = 0
var BeautifulGarden_Duration = 0
var MentalSpiral_Duration = 0
var MentalSpiral_Mod = 0
var CycleOfSadness_Duration = 0
var CycleOfSadness_Mod = 0
var TimeWarp_Mod = 0
var TimeWarp_Duration = 0
var BalancedInstability_Mod = 0
var BalancedInstability_Duration = 0
var PandorasBox_Mod = 0
var PandorasBox_Duration = 0
var GrowingFracture_Mod = 0
var GrowingFracture_Duration = 0
var DanceOfDeath_Mod = 0
var DanceOfDeath_Duration = 0
var BloodMoon_Mod = 0
var BloodMoon_Duration = 0
var WhiteSilence_Mod = 0
var WhiteSilence_Duration = 0
var Regression_Mod = 0
var Regression_Duration = 0

var WarningStrike_Mod = 0
var WarningStrike_Duration = 0
var BloodExchange_Mod = 0
var BloodExchange_Duration = 0
var EmptyWell_Mod = 0
var EmptyWell_Duration = 0
var EmptyWell_ATK = false
var EmptyWell_DEF = false
var EmptyWell_SEN = false
var EmptyWell_SPD = false
var EmptyWell_RES = false
var EmptyWell_ENR = false

#Shields
var mental_shield = false
var orange_shield = false
var spiked_shield = false

#Passives
var BDIGO_ATK_MOD = 0
var peace_of_mind_mod = 0
var recoil = false
var recoil_lvl = 0
var waiting_game = 0
var waiting_game_summ = 0
var fast_reaction = 0
var fury_chance = 0
var fury_gain = 0
var fury = 0
var critical_line = 0
var ChangingMood = ""
var ChangingMood_Mod = 0
var colors = ["red", "orange", "yellow", "green", "blue", "purple"]
var iterativeprocess_mod = 0
var iterativeprocess_summ = 0

var colorful_beats = 0

#Common Items

#Uncommon Items
var backpack_DEF_Mod = 0
var backpack_DMG_add = 0
var magnifyingglass_mod = 0
var bloodstained_armor = 0

#Rare Items
var gloves_DEF_Mod = 0
var gloves_DMG_add = 0
var pocketwatch_mod = 0
var spikedsword_mod = 0
var allforone = false
var allforone_mod = 0
var wonderremedy_summ = 0
var rosecrest = 0
var needlecrest = 0

func _ready():
	gen.randomize()
	for i in range(passives.size()):
		match passives[i]:
			"Orange_BDIGO":
				BDIGO_ATK_MOD = 0.1 * save.get_skill_lvl("Orange_BDIGO")
			"Orange_Recoil":
				recoil_lvl = save.get_skill_lvl("Orange_Recoil")
				recoil = true
			"Blue_Peace_Of_Mind":
				match save.get_skill_lvl("Blue_Peace_Of_Mind"):
					1:
						peace_of_mind_mod = 5
					2:
						peace_of_mind_mod = 7
					3:
						peace_of_mind_mod = 9
					4:
						peace_of_mind_mod = 12
					5:
						peace_of_mind_mod = 15
			"Green_Waiting_Game":
				waiting_game = 2 + 2 * save.get_skill_lvl("Green_Waiting_Game")
			"Yellow_Fast_Reaction":
				fast_reaction = 40 + 10 * save.get_skill_lvl("Yellow_Fast_Reaction")
				if save.get_skill_lvl("Yellow_Fast_Reaction") == 5:
					fast_reaction = 100
			"Purple_Unfair_Game":
				get_parent().unfair_game_lvl = save.get_skill_lvl("Purple_Unfair_Game")
			"Purple_One_Foot_In_The_Grave":
				get_parent().unfair_game_lvl = save.get_skill_lvl("Purple_One_Foot_In_The_Grave")
			"Red_Fury":
				fury_gain = 1 + save.get_skill_lvl("Red_Fury")
				fury_chance = 20 + 10 * save.get_skill_lvl("Red_Fury")
			"Red_Critical_Line":
				get_parent().red_critical_line = true
				critical_line = 0.4 + 0.1 * save.get_skill_lvl("Red_Critical_Line")
				if save.get_skill_lvl("Red_Critical_Line") >= 3:
					critical_line += 0.1
			"White_Changing_Mood":
				match save.get_skill_lvl("White_Changing_Mood"):
					1:
						ChangingMood_Mod = 0.1
					2:
						ChangingMood_Mod = 0.15
					3:
						ChangingMood_Mod = 0.2
					4:
						ChangingMood_Mod = 0.3
					5:
						ChangingMood_Mod = 0.4
			"White_Iterative_Process":
				match save.get_skill_lvl("White_Iterative_Process"):
					1:
						iterativeprocess_mod = 0.02
					2:
						iterativeprocess_mod = 0.03
					3:
						iterativeprocess_mod = 0.05
					4:
						iterativeprocess_mod = 0.07
					5:
						iterativeprocess_mod = 0.1
	
	#Umcommon Items
	if (save.get("backpack") == true):
		backpack_DEF_Mod = 10
		backpack_DMG_add = 0.2
	if save.get("bloodstainedarmor") == true:
		bloodstained_armor = 5
	
	#Rare Items
	if (save.get("gloves") == true):
		gloves_DEF_Mod = 20
		gloves_DMG_add = 0.4
	if save.get("spikedsword") == true:
		spikedsword_mod = 10
	if save.get("rosecrest") == true:
		rosecrest = 5 
	if save.get("needlecrest") == true:
		needlecrest += 10

func ATK_MOD():
	var skills_Mod = Adaptation_Mod + GrowingPain_Mod + WhiteSilence_Mod + BeautifulGarden_Mod + BalancedInstability_Mod + PandorasBox_Mod
	skills_Mod += int((get_parent().Base_DEF + DEF_MOD()) * BDIGO_ATK_MOD) + fury + BloodMoon_Mod + DanceOfDeath_Mod + Regression_Mod
	if EmptyWell_ATK == true:
		skills_Mod += EmptyWell_Mod
	if silence_duration != 0:
		skills_Mod = 0
	var artefact_Mod = wonderremedy_summ
	
	if get_parent().curHP <= get_parent().maxHP * 0.5:
		artefact_Mod += bloodstained_armor + spikedsword_mod
	
	return skills_Mod + artefact_Mod

func ATK_MULT():
	var artefact_Mod = magnifyingglass_mod + pocketwatch_mod + allforone_mod
	
	return artefact_Mod

func END_MOD():
	var artefact_Mod = bloodstained_armor
	return artefact_Mod

func DEF_MOD():
	var skills_Mod = Adaptation_Mod + StoneCocoon_Mod - BloodMoon_Mod
	if EmptyWell_DEF == true:
		skills_Mod += EmptyWell_Mod
	if silence_duration != 0:
		skills_Mod = 0
	var artefact_Mod = gloves_DEF_Mod + backpack_DEF_Mod
	var enemy_mod = -TargetTheWeak_DEF_debuff
	return skills_Mod + artefact_Mod + enemy_mod

func SEN_MOD():
	var skills_Mod = GrowingPain_Mod + TimeWarp_Mod + BalancedInstability_Mod
	if EmptyWell_SEN == true:
		skills_Mod += EmptyWell_Mod
	if silence_duration != 0:
		skills_Mod = 0
	var artefact_Mod = wonderremedy_summ
	return skills_Mod + artefact_Mod

func AVO_MOD():
	return -blind

func ENR_MOD():
	var skills_mod = MentalSpiral_Mod + CycleOfSadness_Mod
	if EmptyWell_ENR == true:
		skills_mod += EmptyWell_Mod
	if silence_duration != 0:
		skills_mod = 0
	var artefact_mod = 0
	return skills_mod + artefact_mod

func SPD_MOD():
	var skills_Mod = TimeWarp_Mod
	if EmptyWell_SPD == true:
		skills_Mod += EmptyWell_Mod
	if silence_duration != 0:
		skills_Mod = 0
	var artefact_mod = 0
	return closure + haste_SPD + skills_Mod + artefact_mod

func DMG_mod():
	var skills_Mod = WarningStrike_Mod + BloodExchange_Mod + colorful_beats + iterativeprocess_summ
	return 1 - aches + skills_Mod

func DMG_ADD():
	var artefact_Mod = (gloves_DMG_add + backpack_DMG_add) * get_parent().DEF
	return artefact_Mod

func STATUS_RES():
	var skill_mod = Cleansing_Effect + StoneCocoon_Mod + PandorasBox_Mod + GrowingFracture_Mod
	if EmptyWell_RES == true:
		skill_mod += EmptyWell_Mod
	if silence_duration != 0:
		skill_mod = 0
	var artefact_mod = needlecrest
	return status_resistance + skill_mod + artefact_mod - miasma

func CD_MOD():
	return haste_cd

func CRIT_MOD():
	var artefact_Mod = rosecrest
	if silence_duration != 0:
		waiting_game_summ = 0
	
	if get_parent().curHP <= get_parent().maxHP * 0.5:
		artefact_Mod += spikedsword_mod / 2
	
	return waiting_game_summ + artefact_Mod

func RED_DMG_MOD():
	var skills_mod = 0
	if ChangingMood == "red":
		skills_mod += ChangingMood_Mod
	return skills_mod

func ORANGE_DMG_MOD():
	var skills_mod = 0
	if ChangingMood == "orange":
		skills_mod += ChangingMood_Mod
	return skills_mod

func YELLOW_DMG_MOD():
	var skills_mod = 0
	if ChangingMood == "yellow":
		skills_mod += ChangingMood_Mod
	return skills_mod

func GREEN_DMG_MOD():
	var skills_mod = 0
	if ChangingMood == "green":
		skills_mod += ChangingMood_Mod
	return skills_mod

func BLUE_DMG_MOD():
	var skills_mod = 0
	if ChangingMood == "blue":
		skills_mod += ChangingMood_Mod
	return skills_mod

func PURPLE_DMG_MOD():
	var skills_mod = 0
	if ChangingMood == "purple":
		skills_mod += ChangingMood_Mod
	return skills_mod

func new_turn():
	if ChangingMood_Mod != 0:
		ChangingMood = colors[gen.randi_range(0, 5)]
	
	#Standart Aligments
	if closure_duration > 0:
		closure_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Closure/Num").text = str(closure_duration)
		if closure_duration == 0:
			closure = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Closure").visible = false
	if silence_duration > 0:
		silence_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Silence/Num").text = str(silence_duration)
		if silence_duration == 0:
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Silence").visible = false
	if fragile_duration > 0:
		fragile_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fragile/Num").text = str(fragile_duration)
		if fragile_duration == 0:
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fragile").visible = false
	if spread_duration > 0:
		spread_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Spread/Num").text = str(spread_duration)
		if spread_duration == 0:
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Spread").visible = false
	if exhaustion > 0:
		get_parent().TakeExhaustionDamage(exhaustion)
		exhaustion -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Exhaustion/Num").text = str(exhaustion)
		if exhaustion == 0:
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Exhaustion").visible = false
	if aches_duration > 0:
		aches_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Aches/Num").text = str(aches_duration)
		if aches_duration == 0:
			aches = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Aches").visible = false
	if bind_duration > 0:
		bind_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Bind/Num").text = str(bind_duration)
		if bind_duration == 0:
			bind = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Bind").visible = false
	if haste_duration > 0:
		haste_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Haste/Num").text = str(haste_duration)
		if haste_duration == 0:
			haste_SPD = 0
			haste_cd = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Haste").visible = false
	if empowerment_duration > 0:
		empowerment_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Empowerment/Num").text = str(empowerment_duration)
		if empowerment_duration == 0:
			empowement = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Empowerment").visible = false
	if blind_duration > 0:
		blind_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Blind/Num").text = str(blind_duration)
		if blind_duration == 0:
			blind = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Blind").visible = false
	if miasma_duration > 0:
		miasma_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Miasma/Num").text = str(miasma_duration)
		if miasma_duration == 0:
			miasma = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Miasma").visible = false
	
	#Skills
	if WarningStrike_Duration > 0:
		WarningStrike_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WarningStrike/Num").text = str(WarningStrike_Duration)
		if WarningStrike_Duration == 0:
			WarningStrike_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WarningStrike").visible = false
	if BloodExchange_Duration > 0:
		BloodExchange_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodExchange/Num").text = str(BloodExchange_Duration)
		if BloodExchange_Duration == 0:
			BloodExchange_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodExchange").visible = false
	if EmptyWell_Duration != 0:
		EmptyWell_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/EmptyWell/Num").text = str(EmptyWell_Duration)
		if EmptyWell_Duration == 0:
			EmptyWell_Mod = 0
			EmptyWell_ATK = false
			EmptyWell_DEF = false
			EmptyWell_SEN = false
			EmptyWell_ENR = false
			EmptyWell_SPD = false
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/EmptyWell").visible = false
	
	#Ult Aligmnets
	if Adaptation_Duration > 0:
		Adaptation_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Adaptation/Num").text = str(Adaptation_Duration)
		if Adaptation_Duration == 0:
			Adaptation_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Adaptation").visible = false
	if StoneCocoon_Duration > 0:
		StoneCocoon_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/StoneCocoon/Num").text = str(StoneCocoon_Duration)
		if StoneCocoon_Duration == 0:
			StoneCocoon_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/StoneCocoon").visible = false
	if GrowingPain_Duration > 0:
		GrowingPain_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingPain/Num").text = str(GrowingPain_Duration)
		if GrowingPain_Duration == 0:
			GrowingPain_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingPain").visible = false
	if BeautifulGarden_Duration > 0:
		BeautifulGarden_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BeautifulGarden/Num").text = str(BeautifulGarden_Duration)
		if BeautifulGarden_Duration == 0:
			BeautifulGarden_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BeautifulGarden").visible = false
	if MentalSpiral_Duration > 0:
		MentalSpiral_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalSpiral/Num").text = str(MentalSpiral_Duration)
		if MentalSpiral_Duration == 0:
			MentalSpiral_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalSpiral").visible = false
	if CycleOfSadness_Duration > 0:
		CycleOfSadness_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/CycleOfSadness/Num").text = str(CycleOfSadness_Duration)
		if CycleOfSadness_Duration == 0:
			CycleOfSadness_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/CycleOfSadness").visible = false
	if TimeWarp_Duration > 0:
		TimeWarp_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TimeWarp/Num").text = str(TimeWarp_Duration)
		if TimeWarp_Duration == 0:
			TimeWarp_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TimeWarp").visible = false
	if BalancedInstability_Duration > 0:
		BalancedInstability_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BalancedInstability/Num").text = str(BalancedInstability_Duration)
		if BalancedInstability_Duration == 0:
			BalancedInstability_Mod = 0
			get_parent().bi_x = 0
			get_parent().bi_y = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BalancedInstability").visible = false
	if PandorasBox_Duration > 0:
		PandorasBox_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/PandorasBox/Num").text = str(PandorasBox_Duration)
		if PandorasBox_Duration == 0:
			PandorasBox_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/PandorasBox").visible = false
	if GrowingFracture_Duration > 0:
		GrowingFracture_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingFracture/Num").text = str(GrowingFracture_Duration)
		if GrowingFracture_Duration == 0:
			GrowingFracture_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingFracture").visible = false
	if DanceOfDeath_Duration > 0:
		DanceOfDeath_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath/Num").text = str(DanceOfDeath_Duration)
		if DanceOfDeath_Duration == 0:
			DanceOfDeath_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath").visible = false
	if BloodMoon_Duration > 0:
		BloodMoon_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodMoon/Num").text = str(BloodMoon_Duration)
		if BloodMoon_Duration == 0:
			BloodMoon_Mod = 0
			get_parent().blood_moon_def_ignore = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodMoon").visible = false
	if WhiteSilence_Duration > 0:
		WhiteSilence_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WhiteSilence/Num").text = str(WhiteSilence_Duration)
		if WhiteSilence_Duration == 0:
			WhiteSilence_Mod = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WhiteSilence").visible = false
	if Cleansing_Duration > 0:
		Cleansing_Duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeCleansing/Num").text = str(Cleansing_Duration)
		if Cleansing_Duration == 0:
			Cleansing_Effect = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeCleansing").visible = false
	
	#Aligments From Enemies
	if TargetTheWeak_duration > 0:
		TargetTheWeak_duration -= 1
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TargetTheWeak/Num").text = str(TargetTheWeak_duration)
		if TargetTheWeak_duration == 0:
			TargetTheWeak_DEF_debuff = 0
			get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TargetTheWeak").visible = false
	
	CheckItemsMultATKMod()
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().DEF = get_parent().Base_DEF + DEF_MOD()
	get_parent().SEN = get_parent().Base_SEN + SEN_MOD()
	get_parent().DMG_add = DMG_ADD()
	get_parent().DMG_Mod = DMG_mod()
	get_parent().ENR = ENR_MOD() + get_parent().Base_ENR
	get_parent().RES = STATUS_RES()
	get_parent().CRIT = get_parent().SEN/2 + CRIT_MOD()
	get_parent().AVO = AVO_MOD() + 2 + int(get_parent().SEN/3)
	get_parent().skills_cd_mod = CD_MOD()
	
	if get_parent().bi_x != 0:
		get_parent().bi_actions = gen.randi_range(get_parent().bi_x, get_parent().bi_y)
	else:
		get_parent().bi_actions = 0
	get_parent().turn = true
	get_parent().actions = 0
	get_parent().additional_actions = 0
	
	get_parent().max_actions = get_parent().abs_max_axtions + get_parent().bi_actions

func Haste(x, y, time):
	haste_SPD = x
	haste_cd = y
	haste_duration = time
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Haste").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Haste/Num").text = str(time)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Haste/Potency").text = str(haste_SPD, "/", haste_cd)

func WaitingGameNULL():
	if waiting_game != 0:
		waiting_game_summ = 0
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WaitingGame").visible = false
		get_parent().CRIT = get_parent().SEN/2 + CRIT_MOD()

func WaitingGamePlus(actions_num):
	if waiting_game != 0:
		waiting_game_summ += waiting_game * actions_num
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WaitingGame").visible = true
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WaitingGame/Num").text = str(waiting_game_summ)
		get_parent().CRIT = get_parent().SEN/2 + CRIT_MOD()

func FuryCheck():
	if gen.randi_range(1, 100) <= fury_chance && fury != fury_gain * 5:
		fury += fury_gain
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fury").visible = true
		get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Fury/Num").text = str(fury)
		get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())

func IterativeProcess(reset, AoE):
	if reset == true:
		iterativeprocess_summ = iterativeprocess_mod
		if AoE == true:
			iterativeprocess_summ = 0
	elif reset == false && iterativeprocess_summ < iterativeprocess_mod * 5:
		iterativeprocess_summ += iterativeprocess_mod

func RemoveNegativeStatus():
	fragile = 0
	fragile_duration = 0
	spread = 0
	spread_duration = 0
	silence_duration = 0

func Cleansing(lvl):
	RemoveNegativeStatus()
	Cleansing_Effect = 5 + 5 * lvl
	Cleansing_Duration = 3
	if lvl >= 3:
		Cleansing_Duration += 1
	if lvl >= 5:
		Cleansing_Duration += 1
	get_parent().RES = STATUS_RES()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeCleansing").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeCleansing/Num").text = str(Cleansing_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/OrangeCleansing/Potency").text = str(Cleansing_Effect)

func EmptyWell(lvl):
	RemoveNegativeStatus()
	var num = 1
	match lvl:
		1:
			EmptyWell_Mod = 5
			EmptyWell_Duration = 3
		2:
			EmptyWell_Mod = 7
			EmptyWell_Duration = 3
		3:
			EmptyWell_Mod = 10
			EmptyWell_Duration = 4
			num = 2
		4:
			EmptyWell_Mod = 15
			EmptyWell_Duration = 4
			num = 2
		5:
			EmptyWell_Mod = 20
			EmptyWell_Duration = 5
			num = 3
	for i in range(num):
		var check = false
		while check == false:
			var stat = gen.randi_range(1, 5)
			match stat:
				1:
					if EmptyWell_ATK == false:
						check = true
						EmptyWell_ATK = true
				2:
					if EmptyWell_DEF == false:
						check = true
						EmptyWell_DEF = true
				3:
					if EmptyWell_SEN == false:
						check = true
						EmptyWell_SEN = true
				4:
					if EmptyWell_SPD == false:
						check = true
						EmptyWell_SPD = true
				5:
					if EmptyWell_ENR == false:
						check = true
						EmptyWell_ENR = true
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().DEF = get_parent().Base_DEF + DEF_MOD()
	get_parent().SEN = get_parent().Base_SEN + SEN_MOD()
	get_parent().SPD = get_parent().Base_SPD + SPD_MOD()
	get_parent().ENR = get_parent().Base_ENR + ENR_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/EmptyWell").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/EmptyWell/Num").text = str(EmptyWell_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/EmptyWell/Potency").text = str(EmptyWell_Mod)

func BloodExchange(lvl):
	RemoveNegativeStatus()
	BloodExchange_Duration = 2
	BloodExchange_Mod = 20
	match lvl:
		2:
			BloodExchange_Mod = 25
		3:
			BloodExchange_Mod = 30
			BloodExchange_Duration = 3
		4:
			BloodExchange_Mod = 40
			BloodExchange_Duration = 3
		5:
			BloodExchange_Mod = 50
			BloodExchange_Duration = 4
	get_parent().DMG_Mod = DMG_mod()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodExchange").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodExchange/Num").text = str(BloodExchange_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BloodExchange/Potency").text = str(BloodExchange_Mod)

func PeaceOfMind(target):
	var enemyEN = (get_parent().get_node(str("../Enemy", target)).get_child(1).curEN / get_parent().get_node(str("../Enemy", target)).get_child(1).maxEN) * 100
	var selfEN = (get_parent().curEN / get_parent().maxEN) * 100
	if selfEN > enemyEN:
		return peace_of_mind_mod
	else:
		return 0

func WarningStrike_ON(lvl):
	WarningStrike_Duration = 2
	WarningStrike_Mod = 0.25 + 0.05 * lvl
	if lvl >= 4:
		WarningStrike_Mod += 0.05
	
	get_parent().DMG_Mod = DMG_mod()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WarningStrike").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WarningStrike/Num").text = str(WarningStrike_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WarningStrike/Potency").text = str(WarningStrike_Mod * 100)

func WarningStrike_OFF():
	WarningStrike_Duration = 0
	WarningStrike_Mod = 0
	
	get_parent().DMG_Mod = DMG_mod()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WarningStrike").visible = false

func Adaptation(lvl):
	Adaptation_Mod = 4 + lvl * 2
	Adaptation_Duration = 3
	match lvl:
		3:
			Adaptation_Duration = 4
		4:
			Adaptation_Duration = 4
		5:
			Adaptation_Duration = 5
			Adaptation_Mod = 15
	
	get_parent().ATK = ATK_MOD() + get_parent().Base_ATK
	get_parent().DEF = get_parent().Base_DEF + DEF_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Adaptation").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Adaptation/Num").text = str(Adaptation_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Adaptation/Potency").text = str(Adaptation_Mod)

func GrowingPain(lvl):
	GrowingPain_Mod = 8
	GrowingPain_Duration = 3
	match lvl:
		2:
			GrowingPain_Mod = 10
		3:
			GrowingPain_Duration = 4
			GrowingPain_Mod = 13
		4:
			GrowingPain_Duration = 4
			GrowingPain_Mod = 17
		5:
			GrowingPain_Duration = 5
			GrowingPain_Mod = 22
	
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().SEN = get_parent().Base_SEN + SEN_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingPain").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingPain/Num").text = str(GrowingPain_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingPain/Potency").text = str(GrowingPain_Mod)


func StoneCocoon(lvl):
	StoneCocoon_Mod = 5 + lvl * 5
	StoneCocoon_Duration = 3
	match lvl:
		3:
			StoneCocoon_Duration = 4
		4:
			StoneCocoon_Duration = 4
			StoneCocoon_Mod = 30
		5:
			StoneCocoon_Duration = 5
			StoneCocoon_Mod = 40
	
	get_parent().RES = STATUS_RES()
	get_parent().DEF = get_parent().Base_DEF + DEF_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/StoneCocoon").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/StoneCocoon/Num").text = str(StoneCocoon_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/StoneCocoon/Potency").text = str(StoneCocoon_Mod)

func BeautifulGarden(lvl):
	BeautifulGarden_Mod = 8
	BeautifulGarden_Duration = 3
	match lvl:
		2:
			BeautifulGarden_Mod = 10
		3:
			BeautifulGarden_Duration = 4
			BeautifulGarden_Mod = 13
		4:
			BeautifulGarden_Duration = 4
			BeautifulGarden_Mod = 17
		5:
			BeautifulGarden_Duration = 5
			BeautifulGarden_Mod = 22
	
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BeautifulGarden").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BeautifulGarden/Num").text = str(BeautifulGarden_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BeautifulGarden/Potency").text = str(BeautifulGarden_Mod)

func MentalSpiral(lvl):
	MentalSpiral_Mod = 10
	MentalSpiral_Duration = 1
	match lvl:
		2:
			MentalSpiral_Mod = 15
		3:
			MentalSpiral_Duration = 2
			MentalSpiral_Mod = 20
		4:
			MentalSpiral_Duration = 2
			MentalSpiral_Mod = 30
		5:
			MentalSpiral_Duration = 3
			MentalSpiral_Mod = 40
	
	get_parent().ENR = get_parent().Base_ENR + ENR_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalSpiral").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalSpiral/Num").text = str(MentalSpiral_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/MentalSpiral/Potency").text = str(MentalSpiral_Mod)

func CycleOfSadness(lvl):
	CycleOfSadness_Mod = 10
	CycleOfSadness_Duration = 1
	match lvl:
		2:
			CycleOfSadness_Mod = 15
		3:
			CycleOfSadness_Duration = 2
			CycleOfSadness_Mod = 20
		4:
			CycleOfSadness_Duration = 2
			CycleOfSadness_Mod = 30
		5:
			CycleOfSadness_Duration = 3
			CycleOfSadness_Mod = 40
	
	get_parent().ENR = get_parent().Base_ENR + ENR_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/CycleOfSadness").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/CycleOfSadness/Num").text = str(CycleOfSadness_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/CycleOfSadness/Potency").text = str(CycleOfSadness_Mod)

func TimeWarp(lvl):
	TimeWarp_Mod = 6
	TimeWarp_Duration = 3
	var timewarp_cost = 1
	match lvl:
		2:
			TimeWarp_Mod = 8
		3:
			TimeWarp_Duration = 4
			TimeWarp_Mod = 11
			timewarp_cost = 2
		4:
			TimeWarp_Duration = 4
			TimeWarp_Mod = 15
			timewarp_cost = 2
		5:
			TimeWarp_Duration = 5
			TimeWarp_Mod = 20
			timewarp_cost = 3
	
	for i in range(6):
		if (get_parent().skills_cd[i] > 0):
			get_parent().skills_cd[i] = 0
	
	get_parent().timewarp_cost = timewarp_cost
	get_parent().SEN = get_parent().Base_SEN + SEN_MOD()
	get_parent().SPD = get_parent().Base_SPD + SPD_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TimeWarp").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TimeWarp/Num").text = str(TimeWarp_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/TimeWarp/Potency").text = str(TimeWarp_Mod)

func BalancedInstability(lvl):
	BalancedInstability_Mod = 6
	BalancedInstability_Duration = 3
	var x = 1
	var y = 2
	match lvl:
		2:
			BalancedInstability_Mod = 8
			y = 3
		3:
			BalancedInstability_Duration = 4
			BalancedInstability_Mod = 11
			x = 2
			y = 4
		4:
			BalancedInstability_Duration = 4
			BalancedInstability_Mod = 15
			x = 2
			y = 5
		5:
			BalancedInstability_Duration = 5
			BalancedInstability_Mod = 20
			x = 3
			y = 5
	
	get_parent().bi_x = x
	get_parent().bi_y = y
	get_parent().SEN = get_parent().Base_SEN + SEN_MOD()
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BalancedInstability").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BalancedInstability/Num").text = str(BalancedInstability_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/BalancedInstability/Potency").text = str(BalancedInstability_Mod)

func PandorasBox(lvl):
	PandorasBox_Mod = 8
	PandorasBox_Duration = 3
	match lvl:
		2:
			PandorasBox_Mod = 10
		3:
			PandorasBox_Duration = 4
			PandorasBox_Mod = 13
		4:
			PandorasBox_Duration = 4
			PandorasBox_Mod = 17
		5:
			PandorasBox_Duration = 5
			PandorasBox_Mod = 22
	
	get_parent().RES = STATUS_RES()
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/PandorasBox").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/PandorasBox/Num").text = str(PandorasBox_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/PandorasBox/Potency").text = str(PandorasBox_Mod)

func GrowingFracture(lvl):
	GrowingFracture_Mod = 8
	GrowingFracture_Duration = 3
	match lvl:
		2:
			GrowingFracture_Mod = 10
		3:
			GrowingFracture_Duration = 4
			GrowingFracture_Mod = 13
		4:
			GrowingFracture_Duration = 4
			GrowingFracture_Mod = 17
		5:
			GrowingFracture_Duration = 5
			GrowingFracture_Mod = 22
	
	get_parent().RES = STATUS_RES()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingFracture").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingFracture/Num").text = str(GrowingFracture_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/GrowingFracture/Potency").text = str(GrowingFracture_Mod)

func DanceOfDeath(lvl):
	DanceOfDeath_Mod = 12
	DanceOfDeath_Duration = 3
	match lvl:
		2:
			DanceOfDeath_Mod = 14
		3:
			DanceOfDeath_Duration = 4
			DanceOfDeath_Mod = 17
		4:
			DanceOfDeath_Duration = 4
			DanceOfDeath_Mod = 10
		5:
			DanceOfDeath_Duration = 5
			DanceOfDeath_Mod = 25
	
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath/Num").text = str(DanceOfDeath_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath/Potency").text = str(DanceOfDeath_Mod)

func BloodMoon(lvl):
	BloodMoon_Mod = 5 + 5 * lvl
	BloodMoon_Duration = 3
	get_parent().blood_moon_def_ignore = 0.1 * lvl
	if lvl >= 3:
		BloodMoon_Duration = 4
	if lvl == 5:
		BloodMoon_Duration = 5
	
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().DEF = get_parent().Base_DEF + DEF_MOD()
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath/Num").text = str(BloodMoon_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/DanceOfDeath/Potency").text = str(BloodMoon_Mod)

func WhiteSilence(lvl):
	WhiteSilence_Mod = 6
	WhiteSilence_Duration = 3
	match lvl:
		2:
			WhiteSilence_Mod = 8
		3:
			WhiteSilence_Duration = 4
			WhiteSilence_Mod = 11
		4:
			WhiteSilence_Duration = 4
			WhiteSilence_Mod = 15
		5:
			WhiteSilence_Duration = 5
			WhiteSilence_Mod = 20
	
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WhiteSilence").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WhiteSilence/Num").text = str(WhiteSilence_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/WhiteSilence/Potency").text = str(WhiteSilence_Mod)

func Regression(lvl):
	Regression_Mod = 6
	Regression_Duration = 3
	match lvl:
		2:
			Regression_Mod = 8
		3:
			Regression_Duration = 4
			Regression_Mod = 11
		4:
			Regression_Duration = 4
			Regression_Mod = 15
		5:
			Regression_Duration = 5
			Regression_Mod = 20
	
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Regression").visible = true
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Regression/Num").text = str(WhiteSilence_Duration)
	get_parent().get_node("../../CanvasLayer/Control/CharStats/GridContainer/Regression/Potency").text = str(WhiteSilence_Mod)


func CheckItemsMultATKMod():
	if save.get("magnifyingglass") == true:
		magnifyingglass_mod = 0.5
	if save.get("pocketwatch") == true:
		pocketwatch_mod = 1
	if save.get("allforone") == true && get_node("../../..").enemies == 1:
		allforone_mod = 0.5
	else:
		allforone_mod = 0

func ItemsMultATKMod_OFF():
	pocketwatch_mod = 0
	magnifyingglass_mod = 0
	get_parent().ATK = get_parent().Base_ATK + ATK_MOD() + int((get_parent().Base_ATK + ATK_MOD()) * ATK_MULT())
