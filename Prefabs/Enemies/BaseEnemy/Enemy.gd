extends AnimatedSprite
class_name Enemy

var en_name = ""

var Base_ATK = 7
var Base_DEF = 12
var Base_END = 9
var Base_SEN = 10
var Base_SPD = 10
var Base_RES = 10

#Main Stats
var ATK = 7
var DEF = 12
var END = 9
var SEN = 10
var SPD = 10
var RES = 10

#Secondary Stats
var AVO = 5
var CRIT = 5
var maxHP = 180
var curHP = 180
var maxEN = 8
var curEN = 0
var DMG

#Resistances
var red_res = 1
var orange_res = 1
var yellow_res = 1
var green_res = 1
var blue_res = 1
var purple_res = 1

#Universal Status Aligments
var fragile = 0
var fragile_duration = 0
var spread = 0
var spread_duration = 0
var closure_duration = 0
var closure = 0
var empowerment = 0
var empowerment_duration = 0
var aches = 0
var aches_duration = 0
var sleep_duration = 0
var sleep_waking_damage = 0
var exhaustion = 0
var silence_duration = 0
var miasma_duration = 0
var miasma = 0
var blind_duration = 0
var blind = 0
var bind = 0
var bind_duration = 0
var block_num = 0
var haste = 0
var haste_duration = 0

var growing_fracture = 0
var growing_fracture_duration = 0
var danceofdeath = false
var danceofdeath_duration = 0
var regression_duration = 0
var regression_color = null
var num_of_neg_al = 0

#Specific Status Aligments
#First Floor Enemies
var mentalprotection_duration = 0
var mentalprotection_buff = 0
var protecttheart_duration = 0
var protecttheart_buff = 0
var burstofenergy_duration = 0
var burstofenergy_buff = 0
var scorchingheat_duration = 0
var scorchingheat_buff = 0

#Other Stuff
var gen = RandomNumberGenerator.new()
onready var player = get_node("../../Player")
onready var HPbar = get_node("Control/EnemyHP")
onready var ENbar = get_node("Control/EnemyEN")
var weak = false
var idle = true
var turn = false
var tapes_reward = 0
var exhaustion_plus = 0

#Files
var icon
var save = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var damage_num = load("res://Prefabs/UI/BattleUI/Damage.tscn")
var heal_num = load("res://Prefabs/UI/BattleUI/Healing.tscn")
var miss = load("res://Prefabs/UI/BattleUI/Miss.tscn")
var enemy_intel = load("res://Prefabs/ScriptableObjects/EnemyIntelGlobal.tres")

func _ready():
	gen.randomize()
	$Control/Target/AnimationPlayer.play("Active")
	get_node("../../..").enemies += 1
	if global.get("glitches") == false:
		$Damage.queue_free()
	_object_ready()

func _object_ready():
	pass

func items_check():
	var ATK_penalty = 0
	var DEF_penalty = 0
	
	#Common Items
	if save.get("bottleofacid") == true:
		DEF_penalty += 0.05
	if save.get("toyhammer") == true:
		ATK_penalty += 0.05
	if save.get("shocker") == true:
		exhaustion_plus += 1
	
	#Uncommon Items
	if save.get("papership") == true:
		DEF_penalty += 0.15
	if save.get("waterpistol") == true:
		ATK_penalty += 0.15
	
	#Rare Items
	if save.get("vialofpoison") == true:
		maxHP -= int(maxHP * 0.15)
		HPbar.max_value = maxHP
		curHP = maxHP
	if save.get("rootofvulnerability") == true:
		DEF_penalty += 0.45
	if save.get("brokenblade") == true:
		ATK_penalty += 0.45
	if save.get("needlecrest") == true:
		Base_RES -= 20
	
	Base_ATK -= int(round(Base_ATK * ATK_penalty))
	Base_DEF -= int(round(Base_DEF * DEF_penalty))

func _process(delta):
	HPbar.value = curHP
	ENbar.value = curEN
	get_node("Control/EnemyHP/Label").text = str(curHP, "/", maxHP)
	if idle:
		get_node("AnimationPlayer").play("idle")

func ATK():
	ATK = Base_ATK + scorchingheat_buff

func DEF():
	DEF = Base_DEF + protecttheart_buff

func SPD():
	SPD = Base_SPD - closure
	if SPD < 1:
		SPD = 1
	if bind != 0:
		SPD = SPD - int(SPD/3)

func SEN():
	SEN = Base_SEN + burstofenergy_buff
	AVO = int(SEN/3) + 2 - blind
	CRIT = int(SEN/2)

func RES():
	RES = Base_RES + mentalprotection_buff - miasma

func turn():
	turn = true
	weak = false
	if exhaustion > 0:
		curEN -= exhaustion
		get_node("Control/StatusEffects/HBoxContainer/Exhaustion/Time").text = str(exhaustion)
		if curEN < 0:
			curEN = 0
		Taking_Pure_Damage(exhaustion * (5 + exhaustion_plus), "blue", false)
		exhaustion -= 1
		if exhaustion == 0:
			get_node("Control/StatusEffects/HBoxContainer/Exhaustion").visible = false
	
	if fragile_duration > 0:
		fragile_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Fragile/Time").text = str(fragile_duration)
		if growing_fracture_duration > 0:
			growing_fracture_duration -= 1
			get_node("Control/StatusEffects/HBoxContainer/GrowingFracute/Time").text = str(growing_fracture_duration)
			if growing_fracture_duration == 0:
				growing_fracture = 0
			fragile += growing_fracture
			get_node("Control/StatusEffects/HBoxContainer/Fragile/Potency").text = str(fragile)
			if fragile > 2:
				fragile = 2
		if fragile_duration == 0:
			fragile = 0
			num_of_neg_al -= 1
			get_node("Control/StatusEffects/HBoxContainer/Fragile").visible = false
	if spread_duration > 0:
		spread_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Spread/Time").text = str(spread_duration)
		if spread_duration == 0:
			spread = 0
			num_of_neg_al -= 1
			get_node("Control/StatusEffects/HBoxContainer/Spread").visible = false
	if closure_duration > 0:
		closure_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Closure/Time").text = str(closure_duration)
		if closure_duration == 0:
			num_of_neg_al -= 1
			get_node("Control/StatusEffects/HBoxContainer/Closure").visible = false
	if sleep_duration > 0:
		
		#Uncommon Items
		if save.get("alarmclock") == true:
			Taking_Pure_Damage(30, "phys", false)
		
		#Rare Items
		if save.get("trombone") == true:
			Taking_Pure_Damage(60, "phys", false)
		
		sleep_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Sleep/Time").text = str(sleep_duration)
		if sleep_duration == 0:
			if sleep_waking_damage != 0:
				Taking_Pure_Damage(sleep_waking_damage, "purple", false)
				sleep_waking_damage = 0
			get_node("Control/StatusEffects/HBoxContainer/Sleep").visible = false
	if aches_duration > 0:
		aches_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Aches/Time").text = str(aches_duration)
		if aches_duration == 0:
			aches = 0
			num_of_neg_al -= 1
			get_node("Control/StatusEffects/HBoxContainer/AttackBreak").visible = false
	if silence_duration > 0:
		silence_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Silence/Time").text = str(silence_duration)
		if silence_duration == 0:
			num_of_neg_al -= 1
			SwitchPassives(false)
			get_node("Control/StatusEffects/HBoxContainer/Silence").visible = false
	if miasma_duration > 0:
		miasma_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Miasma/Time").text = str(miasma_duration)
		if miasma_duration == 0:
			RES += miasma
			num_of_neg_al -= 1
			miasma = 0
			get_node("Control/StatusEffects/HBoxContainer/Miasma").visible = false
	if blind_duration > 0:
		blind_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Blind/Time").text = str(blind_duration)
		if blind_duration == 0:
			AVO += blind
			num_of_neg_al -= 1
			blind = 0
			get_node("Control/StatusEffects/HBoxContainer/Blind").visible = false
	if mentalprotection_duration > 0:
		mentalprotection_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/MentalProtection/Time").text = str(mentalprotection_duration)
		if mentalprotection_duration == 0:
			mentalprotection_buff
			get_node("Control/StatusEffects/HBoxContainer/MentalProtection").visible = false
	if protecttheart_duration > 0:
		protecttheart_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/ProtectTheArt/Time").text = str(protecttheart_duration)
		if protecttheart_duration == 0:
			protecttheart_buff = 0
			get_node("Control/StatusEffects/HBoxContainer/ProtectTheArt").visible = false
	if burstofenergy_duration > 0:
		get_node("Control/StatusEffects/HBoxContainer/BurstOfEnergy/Time").text = str(burstofenergy_duration)
		burstofenergy_duration -= 1
		if burstofenergy_duration == 0:
			burstofenergy_buff = 0
			get_node("Control/StatusEffects/HBoxContainer/BurstOfEnergy").visible = false
	if scorchingheat_duration > 0:
		scorchingheat_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/ScorchingHeat/Time").text = str(scorchingheat_duration)
		if scorchingheat_duration == 0:
			scorchingheat_buff
			get_node("Control/StatusEffects/HBoxContainer/ScorchingHeat").visible = false
	if danceofdeath_duration > 0:
		danceofdeath_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/DanceOfDeath/Time").text = str(danceofdeath_duration)
		if danceofdeath_duration == 0:
			danceofdeath = false
			get_node("Control/StatusEffects/HBoxContainer/DanceOfDeath").visible = false
	if regression_duration > 0:
		regression_duration -= 1
		get_node("Control/StatusEffects/HBoxContainer/Regression/Time").text = str(regression_duration)
		if regression_duration == 0:
			RegressionOff()
			get_node("Control/StatusEffects/HBoxContainer/Regression").visible = false
	
	ATK()
	DEF()
	SPD()
	SEN()
	RES()
	if curHP > 0:
		ActualTurn()

func ActualTurn():
	pass

func MentalProtectionActivated():
	mentalprotection_duration = 3
	mentalprotection_buff = 20
	$EffectsAnimator.play("Defensive")
	RES()
	get_node("Control/StatusEffects/HBoxContainer/MentalProtection").visible = true
	get_node("Control/StatusEffects/HBoxContainer/MentalProtection/Time").text = str(mentalprotection_duration)
	get_node("Control/StatusEffects/HBoxContainer/MentalProtection/Potency").text = str(20)

func ProtectTheArtActivated():
	protecttheart_duration = 3
	protecttheart_buff = 10
	$EffectsAnimator.play("Defensive")
	DEF()
	get_node("Control/StatusEffects/HBoxContainer/ProtectTheArt").visible = true
	get_node("Control/StatusEffects/HBoxContainer/ProtectTheArt/Time").text = str(protecttheart_duration)
	get_node("Control/StatusEffects/HBoxContainer/ProtectTheArt/Potency").text = str(10)

func BurstOfEnergyActivated():
	curEN = maxEN
	burstofenergy_duration = 3
	burstofenergy_buff = 20
	$EffectsAnimator.play("Buff")
	get_node("Control/StatusEffects/HBoxContainer/BurstOfEnergy").visible = true
	get_node("Control/StatusEffects/HBoxContainer/BurstOfEnergy/Time").text = str(burstofenergy_duration)
	get_node("Control/StatusEffects/HBoxContainer/BurstOfEnergy/Potency").text = str(20)

func ScorchingHeatActivated():
	scorchingheat_duration = 3
	scorchingheat_buff = 10
	Healing("max")
	ATK()
	$EffectsAnimator.play("Buff")
	get_node("Control/StatusEffects/HBoxContainer/ScorchingHeat").visible = true
	get_node("Control/StatusEffects/HBoxContainer/ScorchingHeat/Time").text = str(scorchingheat_duration)
	get_node("Control/StatusEffects/HBoxContainer/ScorchingHeat/Potency").text = str(10)

func Healing(num):
	if num == "max":
		num = maxHP - curHP
	else:
		num = int(num)
		if num + curHP > maxHP:
			num = maxHP - curHP
	curHP += num
	$AnimationPlayer.play("Healing")
	$EffectsAnimator.play("Healing")
	var heal_instance = heal_num.instance()
	heal_instance.text = str("+", num)
	heal_instance.set_position(Vector2(gen.randi_range(0, -36), gen.randi_range(0, -23)))
	heal_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(heal_instance)
	heal_instance.get_node("AnimationPlayer").play("Enemy")

func DamageSound():
	SoundPlayer.play_sound("Hurt")

func ClearPositiveEffects():
	$EffectsAnimator.play("Debuff")
	if mentalprotection_duration > 0:
		mentalprotection_duration = 0
		RES -= 20
		get_node("Control/StatusEffects/HBoxContainer/MentalProtection").visible = false
	if protecttheart_duration > 0:
		protecttheart_duration = 0
		DEF -= 10
		get_node("Control/StatusEffects/HBoxContainer/ProtectTheArt").visible = false
	if burstofenergy_duration > 0:
		burstofenergy_duration = 0
		SEN -= 20
		AVO = int(2 + SEN/3)
		CRIT = int(SEN/2)
		get_node("Control/StatusEffects/HBoxContainer/BurstOfEnergy").visible = false
	if scorchingheat_duration > 0:
		scorchingheat_duration = 0
		ATK -= 10
		get_node("Control/StatusEffects/HBoxContainer/ScorchingHeat").visible = false

func SpawnDamage(dmg, crit):
	var damage_instance = damage_num.instance()
	damage_instance.text = str(dmg)
	if crit:
		damage_instance.text = str(dmg, "!")
	damage_instance.set_position(Vector2(gen.randi_range(4, 40), gen.randi_range(-38, 41)))
	damage_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(damage_instance)
	damage_instance.get_node("AnimationPlayer").play("Enemy")

func Dodge():
	idle = false
	var miss_instance = miss.instance()
	miss_instance.set_position(Vector2(gen.randi_range(0, -36), gen.randi_range(0, -23)))
	miss_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(miss_instance)
	miss_instance.get_node("AnimationPlayer").play("Enemy")
	get_node("AnimationPlayer").play("Dodge")

func Taking_Pure_Damage(cur_DMG, type, on_attack):
	if num_of_neg_al > 1 && player.ofitg_lvl > 0 && player.status_effects.silence_duration == 0:
		cur_DMG += int(cur_DMG * (0.05 + 0.05 * player.ofitg_lvl)) * num_of_neg_al
	if (type == "red"):
		cur_DMG = int(cur_DMG * red_res)
	if (type == "orange"):
		cur_DMG = int(cur_DMG * orange_res)
	if (type == "yellow"):
		cur_DMG = int(cur_DMG * yellow_res)
	if (type == "green"):
		cur_DMG = int(cur_DMG * green_res)
	if (type == "blue"):
		cur_DMG = int(cur_DMG * blue_res)
	if (type == "purple"):
		cur_DMG = int(cur_DMG * purple_res)
	SpawnDamage(cur_DMG, false)
	if on_attack == true:
		get_node("AnimationPlayer").play("TakingDamage")
	idle = false
	curHP -= cur_DMG
	if (curHP <= 0):
		SoundPlayer.play_sound("Death")
		curHP = 0
		if turn == true:
			get_node("AnimationPlayer").play("TakingDamage")
			get_node("Timer").start(1)
		else:
			get_node("Timer").start(1)
		get_parent().get_parent().get_parent().tapes += 5

func CheckRes(type_res, cur_DMG):
	cur_DMG = int(cur_DMG * type_res)
	if type_res == 2 && weak == false:
		weak = true
		if get_node("../../Player/StatusEffects").closure_duration == 0:
			player.additional_actions += 1
	
	return cur_DMG

func Taking_Damage(attack, mod, type, crit_mod, DMG_bonus):
	var cur_DMG = int(((attack + 1.0) * 40.0 / (10.0 + DEF - int(DEF * player.blood_moon_def_ignore))) * mod) + DMG_bonus
	var crit = gen.randi_range(1, 100)
	var crit_success = false
	cur_DMG += int(cur_DMG * fragile)
	crit_mod += spread
	if num_of_neg_al > 1 && player.ofitg_lvl > 0 && player.status_effects.silence_duration == 0:
		cur_DMG += int(cur_DMG * (0.05 + 0.05 * player.ofitg_lvl)) * num_of_neg_al
	if player.dif == "easy":
		cur_DMG += int(cur_DMG * 0.6)
	match type:
		"red":
			cur_DMG = CheckRes(red_res, cur_DMG)
		"orange":
			cur_DMG = CheckRes(orange_res, cur_DMG)
		"yellow":
			cur_DMG = CheckRes(yellow_res, cur_DMG)
		"green":
			crit_mod += spread
			cur_DMG = CheckRes(green_res, cur_DMG)
		"blue":
			cur_DMG = CheckRes(blue_res, cur_DMG)
		"purple":
			cur_DMG = CheckRes(purple_res, cur_DMG)
	if (crit <= crit_mod):
		player.hit_critical = true
		cur_DMG += cur_DMG
		crit_success = true
		if player.red_critical_line == true && player.status_effects.silence_duration == 0 && type == "red":
			player.CriticalLine(cur_DMG)
	SpawnDamage(cur_DMG, crit_success)
	get_node("AnimationPlayer").play("TakingDamage")
	idle = false
	curHP -= cur_DMG
	get_node("EffectsSpecial").modulate = Color8(255, 255, 255)
	if (curHP <= 0) || (player.rosecrest == true && curHP <= maxHP * 0.15 && type == "red"):
		SoundPlayer.play_sound("Death")
		curHP = 0
		if turn == true:
			get_node("Timer").start(1.5)
		else:
			get_node("Timer").start(1)
		get_parent().get_parent().get_parent().tapes += tapes_reward

func GrowingPain(attack, mod, crit_mod, DMG_bonus):
	$EffectsSpecial.visible = true
	$EffectsSpecial.animation = "Poison Claw"
	$EffectsSpecial.modulate = Color8(255, 255, 255)
	$EffectsSpecial.frame = 1
	var cur_DMG = int(((attack + 1.0) * 40.0 / (10.0 + DEF)) * mod) + DMG_bonus
	var crit_success = false
	var crit = gen.randi_range(1, 100) + spread * 2
	cur_DMG += int(cur_DMG * fragile * green_res)
	cur_DMG = CheckRes(green_res, cur_DMG)
	if player.dif == "easy":
		cur_DMG += int(cur_DMG * 0.6)
	if (crit <= crit_mod):
		player.hit_critical = true
		cur_DMG += cur_DMG
		crit_success = true
		player.get_node("ScriptPlaceholder").crit_hit = true
	else:
		player.get_node("ScriptPlaceholder").crit_hit = false
	SpawnDamage(cur_DMG, crit_success)
	get_node("Particles2D").self_modulate = Color8(0, 255, 0)
	get_node("AnimationPlayer").play("TakingDamage")
	idle = false
	curHP -= cur_DMG
	if (curHP <= 0):
		SoundPlayer.play_sound("Death")
		curHP = 0
		get_node("Timer").start(1)
		get_parent().get_parent().get_parent().tapes += tapes_reward

func IdleSetter():
	idle = true

func Status_Effects(status, num, time):
	if gen.randi_range(1, 100) > RES:
		$EffectsAnimator.play("Debuff")
		match status:
			"growing_fracture":
				growing_fracture = num
				growing_fracture_duration = time
			"aches":
				aches += num
				aches_duration = time
				get_node("Control/StatusEffects/HBoxContainer/Aches").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Aches/Time").text = str(aches_duration)
				get_node("Control/StatusEffects/HBoxContainer/Aches/Potency").text = str(aches * 100)
			"fragile":
				if (fragile != 0):
					if (fragile < num):
						fragile = num
					fragile_duration += time/2
				else:
					fragile = num
					fragile_duration = time
				get_node("Control/StatusEffects/HBoxContainer/Fragile").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Fragile/Time").text = str(fragile_duration)
				get_node("Control/StatusEffects/HBoxContainer/Fragile/Potency").text = str(fragile * 100)
			"spread":
				if (spread != 0):
					if (spread < num):
						spread = num
					spread_duration += time/2
				else:
					spread = num
					spread_duration = time
				get_node("Control/StatusEffects/HBoxContainer/Spread").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Spread/Time").text = str(spread_duration)
				get_node("Control/StatusEffects/HBoxContainer/Spread/Potency").text = str(spread)
			"closure":
				closure_duration = time
				if closure < num:
					closure = num
				SPD()
				get_node("Control/StatusEffects/HBoxContainer/Closure").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Closure/Time").text = str(closure_duration)
				get_node("Control/StatusEffects/HBoxContainer/Closure/Potency").text = str(closure)
			"exhaustion":
				exhaustion += num
				get_node("Control/StatusEffects/HBoxContainer/Exhaustion").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Exhaustion/Time").text = str(exhaustion)
			"silence":
				SwitchPassives(true)
				if silence_duration < time:
					silence_duration = time
				get_node("Control/StatusEffects/HBoxContainer/Silence").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Silence/Time").text = str(silence_duration)
			"miasma":
				miasma_duration = time
				miasma = 10
				RES()
				get_node("Control/StatusEffects/HBoxContainer/Miasma").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Miasma/Time").text = str(miasma_duration)
				get_node("Control/StatusEffects/HBoxContainer/Miasma/Potency").text = str(miasma)
			"blind":
				if blind_duration < time:
					blind_duration = time
				if blind < num:
					blind = num
				SEN()
				get_node("Control/StatusEffects/HBoxContainer/Blind").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Blind/Time").text = str(blind_duration)
				get_node("Control/StatusEffects/HBoxContainer/Blind/Potency").text = str(blind)
			"sleep":
				sleep_duration = time
				get_node("Control/StatusEffects/HBoxContainer/Sleep").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Sleep/Time").text = str(sleep_duration)
			"bind":
				if bind_duration < time:
					bind_duration = time
				if bind < num:
					bind = num
				SPD()
				get_node("Control/StatusEffects/HBoxContainer/Bind").visible = true
				get_node("Control/StatusEffects/HBoxContainer/Bind/Time").text = str(bind_duration)
				get_node("Control/StatusEffects/HBoxContainer/Bind/Potency").text = str(bind)
	
	CountNegAligments()

func SwitchPassives(silence):
	pass

func CountNegAligments():
	num_of_neg_al = 0
	if fragile != 0:
		num_of_neg_al += 1
	if blind != 0:
		num_of_neg_al += 1
	if spread != 0:
		num_of_neg_al += 1
	if exhaustion != 0:
		num_of_neg_al += 1
	if aches != 0:
		num_of_neg_al += 1
	if miasma != 0:
		num_of_neg_al += 1
	if growing_fracture != 0:
		num_of_neg_al += 1
	if closure != 0:
		num_of_neg_al += 1
	if silence_duration != 0:
		num_of_neg_al += 1

func WakeUp():
	if player.unfair_game_lvl != 0 && player.status_effects.silence_duration == 0:
		var dmg = int(((int(player.ATK * (0.5 + 0.1 * player.unfair_game_lvl)) + 1.0) * 40.0 / (10.0 + DEF)))
		Taking_Pure_Damage(dmg, "purple", true)
	if sleep_waking_damage != 0:
		Taking_Pure_Damage(sleep_waking_damage, "purple", false)
		sleep_waking_damage = 0
	sleep_duration = 0
	get_node("Control/StatusEffects/HBoxContainer/Sleep").visible = false

func Comatose(EN, time):
	curEN -= EN
	if curEN <= 0:
		curEN = 0
		get_node("Control/StatusEffects/HBoxContainer/Sleep").visible = true
		sleep_duration = time

func DanceOfDeath(time):
	danceofdeath = true
	danceofdeath_duration = time
	get_node("Control/StatusEffects/HBoxContainer/DanceOfDeath/Time").text = str(danceofdeath_duration)
	get_node("Control/StatusEffects/HBoxContainer/DanceOfDeath").visible = true

func RegressionOff():
	if regression_color != null:
		match regression_color:
			"red":
				if red_res != 0.5:
					red_res = red_res / 2.0
				else:
					red_res = 0
			"orange":
				if orange_res != 0.5:
					orange_res = orange_res / 2.0
				else:
					orange_res = 0
			"yellow":
				if yellow_res != 0.5:
					yellow_res = yellow_res / 2.0
				else:
					yellow_res = 0
			"green":
				if green_res != 0.5:
					green_res = green_res / 2.0
				else:
					green_res = 0
			"blue":
				if blue_res != 0.5:
					blue_res = blue_res / 2.0
				else:
					blue_res = 0
			"purple":
				if purple_res != 0.5:
					purple_res = purple_res / 2.0
				else:
					purple_res = 0
	regression_color = null

func Regression(type, lvl):
	$EffectsAnimator.play("Debuff")
	regression_duration = 3
	RegressionOff()
	
	regression_color = type
	match type:
		"red":
			if red_res < 4 && red_res != 0:
				red_res = red_res * 2
			if red_res == 0:
				red_res = 0.5
		"orange":
			if orange_res < 4 && orange_res != 0:
				orange_res = orange_res * 2
			if orange_res == 0:
				orange_res = 0.5
		"yellow":
			if yellow_res < 4 && yellow_res != 0:
				yellow_res = yellow_res * 2
			if yellow_res == 0:
				yellow_res = 0.5
		"green":
			if green_res < 4 && green_res != 0:
				green_res = green_res * 2
			if green_res == 0:
				green_res = 0.5
		"blue":
			if blue_res < 4 && blue_res != 0:
				blue_res = blue_res * 2
			if blue_res == 0:
				blue_res = 0.5
		"purple":
			if purple_res < 4 && purple_res != 0:
				purple_res = purple_res * 2
			if purple_res == 0:
				purple_res = 0.5
	if lvl >= 3:
		regression_duration += 1
	if lvl == 5:
		regression_duration += 1
	
	get_node("Control/StatusEffects/HBoxContainer/Regression/Time").text = str(regression_duration)
	get_node("Control/StatusEffects/HBoxContainer/Regression").visible = true

func _on_Timer_timeout():
	var num = get_node("../../../CanvasLayer/Control/TurnOrder/CenterContainer/HBoxContainer").get_child_count() - 1
	get_node("../../../CanvasLayer/Control/TurnOrder/CenterContainer/HBoxContainer").get_child(num).visible = false
	get_node("../../..").enemies -= 1
	get_parent().Death()
