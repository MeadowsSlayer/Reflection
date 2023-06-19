extends Sprite

var Base_ATK = 15
var Base_DEF = 30
var Base_RES = 10

var ATK = 15
var DEF = 30
var END = 100
var SEN = 15
var SPD = 10
var AVO = 7
onready var maxHP = END * 15
onready var curHP = maxHP
var maxEN = 15
var curEN = 0
var DMG
var RES = 10

var Oath_ATK_mod = 0
var Oath_duration = 0

var cleansing_duration = 0
var cleansing_res_buff = 0

var red_res = 0.5
var orange_res = 0.5
var yellow_res = 1
var green_res = 2
var blue_res = 1
var purple_res = 2

var weak = false
var weak_times_hit = 0
var actions = 0

var fragile_status = 0
var fragile_duration = 0
var spread_status = 0
var spread_duration = 0
var closure_duration = 0
var attackbreak_status = 0
var attackbreak_duration = 0
var sleep_duration = 0
var exhaustion_duration = 0
var exhaistion = 0
var silence_duration = 0
var miasma_duration = 0
var miasma_res_debuff = 0
var blind_duration = 0
var blind_value = 0
var status_effects = 0

var ShieldBash_CD = 0
var Silence_CD = 0
var Oath_CD = 0
var Cleansing_CD = 0
var ToProtect_CD = 0
var UnbreakableWall_CD = 0

var OnTheVergeOfDeath = false
var OTVOD_MOD = 10

var ShieldBach_DEF_Mod = 0
var ShieldBash_duration = 0

var additional_action_taken = false

var HIT = RandomNumberGenerator.new()
var gen = RandomNumberGenerator.new()
onready var player = NodePath("../../Player")
onready var HPbar = NodePath("../../../CanvasLayer/BossHP/HP")
onready var ENbar = NodePath("../../../CanvasLayer/BossHP/EN")

var icon = preload("res://icon.png")
var save = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var idle = true

var damage_num = load("res://Prefabs/UI/BattleUI/Damage.tscn")
var heal_num = load("res://Prefabs/UI/BattleUI/Healing.tscn")
var miss = load("res://Prefabs/UI/BattleUI/Miss.tscn")

func _ready():
	gen.randomize()
	get_node(HPbar).max_value = maxHP
	get_node(ENbar).max_value = maxEN
	get_node("../../..").enemies += 1
	$Actions.visible = false

func _process(delta):
	get_node(HPbar).value = curHP
	get_node(ENbar).value = curEN
	if idle:
		get_node("AnimationPlayer").play("idle")

func IdleSetter():
	idle = true

func turn():
	if silence_duration == 0 && OnTheVergeOfDeath == true && OTVOD_MOD != 10:
		OTVOD_MOD = 10
	elif silence_duration != 0 || OnTheVergeOfDeath == false:
		OTVOD_MOD = 0
	
	if ShieldBash_duration > 0:
		ShieldBash_duration-=1
		if ShieldBash_duration == 0:
			ShieldBach_DEF_Mod = 0
	
	DEF = Base_DEF + OTVOD_MOD + ShieldBach_DEF_Mod
	
	if Oath_duration != 0:
		Oath_ATK_mod = DEF * 0.5
		
	ATK = Base_ATK + OTVOD_MOD + Oath_ATK_mod
	
	additional_action_taken = false
	actions = 0
	$Actions.visible = true
	for i in range(3):
		$Actions/VBoxContainer.get_child(i).texture = load("res://Sprites/UI/Actions/ActionEnabled.png")
	weak = false
	weak_times_hit = 0
	HIT.randomize()
	if (fragile_duration > 0):
		fragile_duration -= 1
		if (fragile_duration == 0):
			fragile_status = 0
			status_effects -= 1
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Fragile").visible = false
	if (spread_duration > 0):
		spread_duration -= 1
		if (spread_duration == 0):
			spread_status = 0
			status_effects -= 1
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Spread").visible = false
	if closure_duration > 0:
		closure_duration -= 1
		if closure_duration == 0:
			status_effects -= 1
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Closure").visible = false
	if attackbreak_duration > 0:
		attackbreak_duration -= 1
		if attackbreak_duration == 0:
			attackbreak_status = 0
			status_effects -= 1
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/AttackBreak").visible = false
	if Oath_duration > 0:
		Oath_duration -= 1
		if Oath_duration == 0:
			ATK -= Oath_ATK_mod
			Oath_ATK_mod = 0
	if cleansing_duration > 0:
		cleansing_duration -= 1
		if cleansing_duration == 0:
			cleansing_res_buff = 0
	if exhaustion_duration > 0:
		curEN -= exhaistion
		if curEN < 0:
			curEN = 0
		exhaustion_duration -= 1
		if exhaustion_duration == 0:
			exhaistion = 0
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Exhaustion").visible = false
	if silence_duration > 0:
		silence_duration -= 1
		if silence_duration == 0:
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Silence").visible = false
	if miasma_duration > 0:
		miasma_duration -= 1
		if miasma_duration == 0:
			miasma_res_debuff = 0
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Miasma").visible = false
	if blind_duration > 0:
		blind_duration -= 1
		if blind_duration == 0:
			AVO += blind_value
			blind_value = 0
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Blind").visible = false
	
	
	RES = Base_RES - miasma_res_debuff + cleansing_res_buff + OTVOD_MOD
	
	if ShieldBash_CD > 0:
		ShieldBash_CD -= 1
	if ToProtect_CD > 0:
		ToProtect_CD -= 1
	if Silence_CD > 0:
		Silence_CD -= 1
	if Oath_CD > 0:
		Oath_CD -= 1
	
	if sleep_duration == 0:
		TakeAction()
	else:
		sleep_duration -= 1
		if sleep_duration < 0:
			sleep_duration = 0

func TakeAction():
	get_node("../../../CanvasLayer/SkillUsed").visible = false
	actions += 1
	if get_parent().weakness_hit == true && additional_action_taken == false:
		actions -= 1
		additional_action_taken = true
	if actions <= 3:
		$Actions/VBoxContainer.get_child(actions - 1).texture = load("res://Sprites/UI/Actions/ActionDisabled.png")
	var action = ""
	var random
	while action == "":
		random = HIT.randi_range(0, 6)
		match random:
			0:
				action = "NormalAttack"
			1:
				if ShieldBash_CD == 0:
					action = "ShieldBash"
			2:
				if ToProtect_CD == 0:
					action = "ToProtect"
			3:
				if Silence_CD == 0:
					action = "Silence"
			4:
				if Oath_CD == 0 && curHP < maxHP * 0.75:
					action = "Oath"
			5:
				if UnbreakableWall_CD == 100:
					action = "UnbreakableWall"
			6:
				if Cleansing_CD == 0 && status_effects != 0:
					action = "Cleansing"
			
	if status_effects >= 2 && Cleansing_CD == 0:
		action = "Cleansing"
	if curHP <= maxHP * 0.5 && Oath_CD == 0:
		action = "Oath"
	
	if curEN >= maxEN:
		action = "Ultimate"
	
	if silence_duration != 0 && action != "Cleansing":
		action = "NormalAttack"
	
	if actions <= 3:
		match action:
			"NormalAttack":
				NormalAttack()
			"ShieldBash":
				ShieldBash()
			"ToProtect":
				ToProtect()
			"Silence":
				Silence()
			"Oath":
				Oath()
			"Cleansing":
				Cleansing()
			"Ultimate":
				Ultimate()
	else:
		$Actions.visible = false
		get_parent().get_parent().play_turn()

func NormalAttack():
	$AnimationPlayer.play("NormalAttack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Normal Attack"
	if (HIT.randi_range(1, 100) >= get_node(player).AVO):
		DMG = int(((ATK + 1.0 - ATK * attackbreak_status) * 40.0 / (10.0 + get_node(player).DEF)))
		var dmg_type = "phys"
		if OnTheVergeOfDeath == true:
			dmg_type = "red"
		get_node(player).Taking_Damage(DMG, dmg_type, self)
		curEN += 1

func ShieldBash():
	ShieldBash_CD = 2
	ShieldBach_DEF_Mod = 20
	ShieldBash_duration = 2
	DEF = Base_DEF + OTVOD_MOD + ShieldBach_DEF_Mod
	if Oath_duration != 0:
		Oath_ATK_mod = DEF * 0.5
		
	ATK = Base_ATK + OTVOD_MOD + Oath_ATK_mod
	$AnimationPlayer.play("NormalAttack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Shield Bash"
	if (HIT.randi_range(1, 100) >= get_node(player).AVO):
		DMG = int(((DEF * 0.6 + 1) * 40.0 / (10.0 + get_node(player).DEF)))
		get_node(player).Taking_Damage(DMG, "orange", self)
		curEN += 2

func ToProtect():
	ToProtect_CD = 2
	$AnimationPlayer.play("NormalAttack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "To Protect"
	if (HIT.randi_range(1, 100) >= get_node(player).AVO):
		DMG = int(((ATK + 1.0 - ATK * attackbreak_status) * 40.0 / (10.0 + get_node(player).DEF)))
		get_node(player).Taking_Damage(DMG, "red", self)
		get_node(player).StatusEffects(0, "closure", 2)
		curEN += 2

func Silence():
	Silence_CD = 2
	$AnimationPlayer.play("Buff")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Silence"
	get_node(player).StatusEffects(0, "silence", 2)
	curEN += 3

func Oath():
	Oath_CD = 2
	Oath_ATK_mod = DEF * 0.5
	ATK += Oath_ATK_mod
	Oath_duration = 3
	$AnimationPlayer.play("Buff")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Oath"
	var HEAL = DEF * 2
	curHP += HEAL
	if curHP > maxHP:
		curHP = maxHP

func Cleansing():
	Cleansing_CD = 3
	curEN += 2
	cleansing_res_buff = 20
	RES = Base_RES - miasma_res_debuff + cleansing_res_buff + OTVOD_MOD
	cleansing_duration = 2
	$AnimationPlayer.play("Buff")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Cleansing"
	status_effects = 0
	fragile_duration = 0
	fragile_status = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Fragile").visible = false
	
	spread_duration = 0
	spread_status = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Spread").visible = false
	
	closure_duration = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Closure").visible = false
	
	attackbreak_duration = 0
	attackbreak_status = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/AttackBreak").visible = false
	
	silence_duration = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Silence").visible = false
	
	miasma_duration = 0
	RES += miasma_res_debuff
	miasma_res_debuff = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Miasma").visible = false
	
	exhaistion = 0
	exhaustion_duration = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Exhaustion").visible = false
	
	blind_duration = 0
	AVO += blind_value
	blind_value = 0
	get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Blind").visible = false

func Ultimate():
	curEN = 0
	$AnimationPlayer.play("NormalAttack")
	get_node("../../../CanvasLayer/SkillUsed").visible = true
	get_node("../../../CanvasLayer/SkillUsed/AnimationPlayer").play("Skill")
	get_node("../../../CanvasLayer/SkillUsed/CenterContainer/Label").text = "Life Absorbtion"
	if (HIT.randi_range(1, 100) >= get_node(player).AVO):
		DMG = int(((DEF * 3 + 1.0) * 40.0 / (10.0 + get_node(player).DEF)))
		get_node(player).Taking_Damage(DMG, "red", self)
		curHP += DMG * 0.5
		if curHP > maxHP:
			curHP = maxHP

func Comatose(EN, time):
	curEN -= EN
	if curEN <= 0:
		curEN = 0
		get_node("../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Sleep").visible = true
		sleep_duration = time

func Dodge():
	var miss_instance = miss.instance()
	miss_instance.set_position(Vector2(gen.randi_range(0, -36), gen.randi_range(0, -23)))
	miss_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(miss_instance)
	miss_instance.get_node("AnimationPlayer").play("Enemy")
	get_node("AnimationPlayer").play("Dodge")

func SpawnDamage(dmg, crit):
	var damage_instance = damage_num.instance()
	damage_instance.text = str(dmg)
	if crit:
		damage_instance.text = str(dmg, "!")
	damage_instance.set_position(Vector2(gen.randi_range(-48, -36), gen.randi_range(-45, -23)))
	damage_instance.set_scale(Vector2(0.5,0.5))
	self.add_child(damage_instance)
	damage_instance.get_node("AnimationPlayer").play("Enemy")

func Taking_Pure_Damage(cur_DMG, type, on_attack):
	if (type == "red"):
		cur_DMG = int(cur_DMG * red_res)
		get_node("Particles2D").self_modulate = Color8(255, 0, 0)
		if red_res == 2 && weak == false:
			weak = true
			if get_node("../../Player/StatusEffects").closure_duration == 0:
				get_node(player).additional_actions += 1
	if (type == "orange"):
		cur_DMG = int(cur_DMG * orange_res)
		get_node("Particles2D").self_modulate = Color8(255, 117, 0)
		if orange_res == 2 && weak == false:
			weak = true
			if get_node("../../Player/StatusEffects").closure_duration == 0:
				get_node(player).additional_actions += 1
	if (type == "yellow"):
		cur_DMG = int(cur_DMG * yellow_res)
		get_node("Particles2D").self_modulate = Color8(255, 255, 0)
		if yellow_res == 2 && weak == false:
			weak = true
			if get_node("../../Player/StatusEffects").closure_duration == 0:
				get_node(player).additional_actions += 1
	if (type == "green"):
		cur_DMG = int(cur_DMG * green_res)
		get_node("Particles2D").self_modulate = Color8(0, 255, 0)
		if green_res == 2 && weak == false:
			weak = true
			if get_node("../../Player/StatusEffects").closure_duration == 0:
				get_node(player).additional_actions += 1
	if (type == "blue"):
		cur_DMG = int(cur_DMG * blue_res)
		get_node("Particles2D").self_modulate = Color8(0, 0, 255)
		if blue_res == 2 && weak == false:
			weak = true
			if get_node("../../Player/StatusEffects").closure_duration == 0:
				get_node(player).additional_actions += 1
	if (type == "purple"):
		cur_DMG = int(cur_DMG * purple_res)
		get_node("Particles2D").self_modulate = Color8(167, 0, 199)
		if purple_res == 2 && weak == false:
			weak = true
			if get_node("../../Player/StatusEffects").closure_duration == 0:
				get_node(player).additional_actions += 1
	if (type == "phys"):
		get_node("Particles2D").self_modulate = Color8(255, 255, 255)
	SpawnDamage(cur_DMG, false)
	if on_attack == true:
		get_node("AnimationPlayer").play("TakingDamage")
	idle = false
	curHP -= cur_DMG
	if (curHP <= 0):
		SoundPlayer.play_sound("Death")
		curHP = 0
		get_node("Timer").start(1)
		save.set("EXP", save.get("EXP") + 10)
		save.save_run()

func Taking_Damage(attack, mod, type, crit_mod, DMG_bonus):
	var cur_DMG = int(((attack + 1.0) * 40.0 / (10.0 + DEF)) * mod) + DMG_bonus
	cur_DMG += int(cur_DMG * fragile_status)
	HIT.randomize()
	var crit = HIT.randi_range(1, 100)
	crit_mod += spread_status
	if (type == "red"):
		cur_DMG = cur_DMG * red_res
		get_node("Particles2D").self_modulate = Color8(255, 0, 0)
		if red_res == 2 && weak == false:
			weak_times_hit += 1
			if weak_times_hit == 3:
				weak = true
			get_node(player).additional_actions += 1
	if (type == "orange"):
		cur_DMG = cur_DMG * orange_res
		get_node("Particles2D").self_modulate = Color8(255, 117, 0)
		if orange_res == 2 && weak == false:
			weak_times_hit += 1
			if weak_times_hit == 3:
				weak = true
			get_node(player).additional_actions += 1
	if (type == "yellow"):
		cur_DMG = cur_DMG * yellow_res
		get_node("Particles2D").self_modulate = Color8(255, 255, 0)
		if yellow_res == 2 && weak == false:
			weak_times_hit += 1
			if weak_times_hit == 3:
				weak = true
			get_node(player).additional_actions += 1
	if (type == "green"):
		cur_DMG = cur_DMG * green_res
		get_node("Particles2D").self_modulate = Color8(0, 255, 0)
		crit_mod += spread_status
		if green_res == 2 && weak == false:
			weak_times_hit += 1
			if weak_times_hit == 3:
				weak = true
			get_node(player).additional_actions += 1
	if (type == "blue"):
		cur_DMG = cur_DMG * blue_res
		get_node("Particles2D").self_modulate = Color8(0, 0, 255)
		if blue_res == 2 && weak == false:
			weak_times_hit += 1
			if weak_times_hit == 3:
				weak = true
			get_node(player).additional_actions += 1
	if (type == "purple"):
		cur_DMG = cur_DMG * purple_res
		get_node("Particles2D").self_modulate = Color8(167, 0, 199)
		if purple_res == 2 && weak == false:
			weak_times_hit += 1
			if weak_times_hit == 3:
				weak = true
			get_node(player).additional_actions += 1
	if (type == "phys"):
		get_node("Particles2D").self_modulate = Color8(255, 255, 255)
	
	if (crit <= crit_mod):
		cur_DMG += cur_DMG
	get_node("AnimationPlayer").play("TakingDamage")
	get_node("Damage").text = String(cur_DMG)
	curHP -= cur_DMG
	if (curHP <= 0):
		curHP = 0
		get_node("Timer").start(1)
		save.save_run()
	if (curHP <= maxHP * 0.3 && OnTheVergeOfDeath == false):
		$OnTheVergeOfDeath.emitting = true
		get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Empowered").visible = true
		OnTheVergeOfDeath = true
		if silence_duration == 0:
			ATK += 10
			DEF += 10
			RES += 10
			if Oath_duration != 0:
				ATK -= Oath_ATK_mod
				Oath_ATK_mod = DEF * 0.5
				ATK += Oath_ATK_mod

func Status_Effects(status, num, time):
	if HIT.randi_range(1, 100) > RES:
		status_effects += 1
		if (status == "attack_break"):
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/AttackBreak").visible = true
			if attackbreak_status < num * 2:
				attackbreak_status += num
			else:
				attackbreak_status = num * 2
			attackbreak_duration = time
		if (status == "fragile"):
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Fragile").visible = true
			if (fragile_status != 0):
				if (fragile_status < num):
					fragile_status = num
				fragile_duration += time/2
			else:
				fragile_status = num
				fragile_duration = time
		if (status == "spread"):
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Spread").visible = true
			if (spread_status != 0):
				if (spread_status < num):
					spread_status = num
				spread_duration += time/2
			else:
				spread_status = num
				spread_duration = time
		if status == "closure":
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Closure").visible = true
			closure_duration = time
		if status == "exhaustion":
			if exhaustion_duration < time:
				exhaustion_duration = time
			if exhaistion < num:
				exhaistion = num
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Exhaustion").visible = true
		if status == "silence":
			if silence_duration < time:
				silence_duration = time
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Silence").visible = true
		if status == "miasma":
			miasma_duration = time
			miasma_res_debuff = 10
			RES -= miasma_res_debuff
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Miasma").visible = true
		if status == "blind":
			if blind_duration < time:
				blind_duration = time
			if blind_value < num:
				blind_value = num
				AVO -= blind_value
			get_node("../../../CanvasLayer/BossHP/StatusEffects/HBoxContainer/Blind").visible = true
