extends Node2D

var icon
var SPD
var turnSPD
var weakness_hit = false
var actions_per_round = 1
var max_dif = 0
var room_data = load("res://Prefabs/ScriptableObjects/Room.tres")
var active = true

onready var timer = $Timer
onready var player = NodePath("../Player")
var gen = RandomNumberGenerator.new()

func DetermineSPD():
	if active == true:
		get_child(1).weak = false
		SPD = get_child(1).SPD
		turnSPD = gen.randi_range(int(SPD/2), SPD)
	else:
		turnSPD = -10

func turn():
	weakness_hit = false
	if get_child(1).sleep_duration == 0:
		timer.start(1.5)
		get_child(1).turn()
	else:
		if get_child(1).sleep_duration > 0:
			get_child(1).sleep_duration -= 1
			if get_child(1).sleep_duration == 0:
				get_child(1).get_node("Control/StatusEffects/HBoxContainer/Sleep").visible = false
		actions_per_round = 1
		get_parent().play_turn()

func Activate():
	if active == true && get_parent().tutorial == false:
		gen.randomize()
		var scene
		if room_data.get("current_room_reward2") == "":
			max_dif = gen.randi_range(2, 4)
		else:
			max_dif = 4
		var enemy_num = gen.randi_range(1, max_dif)
		match enemy_num:
			1:
				scene = load("res://Prefabs/Enemies/FirstFloor/Guard/Guard.tscn")
			2:
				scene = load("res://Prefabs/Enemies/FirstFloor/Gunner/Gunner.tscn")
			3:
				scene = load("res://Prefabs/Enemies/FirstFloor/DancingPaintingWarm/DancingPaintingWarm.tscn")
			4:
				scene = load("res://Prefabs/Enemies/FirstFloor/DancingPaintingCold/DancingPaintingCold.tscn")
		var enemy = scene.instance()
		add_child_below_node(get_child(0), enemy)
		DetermineSPD()
		icon = get_child(1).icon
	elif active == true && get_parent().tutorial == true:
		var scene
		scene = load("res://Prefabs/Enemies/FirstFloor/Guard/Guard.tscn")
		var enemy = scene.instance()
		add_child_below_node(get_child(0), enemy)
		DetermineSPD()
		icon = get_child(1).icon

func Move():
	$AnimationPlayer.play("Move")
	get_node("../../CanvasLayer/Animations").play("Attack")
	self.modulate = Color8(255, 255, 255, 255)
	for i in range(3):
		if get_node_or_null(str("../Enemy", i)) != null && get_node_or_null(str("../Enemy", i)) != self:
			get_node(str("../Enemy", i)).NotInFight()

func NotInFight():
	self.modulate = Color8(88, 88, 88, 90)

func ResetColor():
	self.modulate = Color8(255, 255, 255, 255)

func ClashOver():
	for i in range(3):
		if get_node_or_null(str("../Enemy", i)) != null && get_node_or_null(str("../Enemy", i)) != self:
			get_node(str("../Enemy", i)).ResetColor()

func Death():
	get_node("../..").enemies -= 1
	ClashOver()
	get_parent().battlers_array.erase(self.name)
	get_parent().ChangeIcons()
	get_child(1).queue_free()
	active = false

func _on_Timer_timeout():
	get_node("../../CanvasLayer/SkillUsed").visible = false
	if weakness_hit == false || get_child(1).closure_duration != 0 || actions_per_round == 2:
		actions_per_round = 1
		get_parent().play_turn()
		if get_child(1) != get_node("AnimationPlayer"):
			get_child(1).turn = false
	else:
		actions_per_round += 1
		turn()
