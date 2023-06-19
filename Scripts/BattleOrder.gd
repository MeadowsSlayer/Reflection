extends Node2D

var active_battler
var turn_order_icon = [NodePath("../CanvasLayer/Control/TurnOrder/CenterContainer/HBoxContainer/TurnNow"),
						NodePath("../CanvasLayer/Control/TurnOrder/CenterContainer/HBoxContainer/TurnNext"),
						NodePath("../CanvasLayer/Control/TurnOrder/CenterContainer/HBoxContainer/TurnNext2"),
						NodePath("../CanvasLayer/Control/TurnOrder/CenterContainer/HBoxContainer/TurnNext3")]

var save = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var new_index = 0
var new_round = false
var cur_round = 1
var battlers_array = []
export var tutorial = false

func Start():
	for i in range(4):
		get_node(turn_order_icon[i]).self_modulate = Color8(0, 0, 0)
	get_node("../CanvasLayer/Control/Round/Label").text = str(tr("Round"), " ", cur_round)
	get_node("../CanvasLayer/Control/Round/AnimationPlayer").play("Round")
	if get_node("Player").already_in == false:
		get_node("Player").Start()
	get_node("Player").DetermineSPD()
	new_round = true

func NewRound():
	battlers_array = []
	for i in range(4):
		get_child(i).DetermineSPD()
	var battlers = get_children()
	battlers.sort_custom(self, 'sort_battlers')
	for battler in battlers:
		if battler.active == true:
			battlers_array.append(battler.name)
	active_battler = get_node(battlers_array[0])
	for i in range(4):
		if i + 1 <= battlers_array.size():
			get_node(turn_order_icon[i]).visible = true
			get_node(turn_order_icon[i]).set_texture(get_node(battlers_array[i]).icon)
		else:
			get_node(turn_order_icon[i]).visible = false
		if i != 0:
			get_node(turn_order_icon[i]).self_modulate = Color8(57, 57, 57)
		else:
			get_node(turn_order_icon[i]).self_modulate = Color8(255, 255, 255)
	active_battler.turn()

func ChangeIcons():
	for i in range(4):
		if i + 1 <= battlers_array.size():
			get_node(turn_order_icon[i]).visible = true
			get_node(turn_order_icon[i]).set_texture(get_node(battlers_array[i]).icon)
		else:
			get_node(turn_order_icon[i]).visible = false
		if i != battlers_array.find(active_battler.name):
			get_node(turn_order_icon[i]).self_modulate = Color8(57, 57, 57)
		else:
			get_node(turn_order_icon[i]).self_modulate = Color8(255, 255, 255)

static func sort_battlers(a, b):
	return a.turnSPD > b.turnSPD

func play_turn():
	if new_index + 1 >= battlers_array.size() && battlers_array.find(active_battler.name) + 1 == battlers_array.size():
		for i in range(4):
			get_node(turn_order_icon[i]).self_modulate = Color8(0, 0, 0)
		new_round = true
		new_index = 0
		cur_round += 1
		get_node("../CanvasLayer/Control/Round/Label").text = str(tr("Round"), " ", cur_round)
		get_node("../CanvasLayer/Control/Round/AnimationPlayer").play("Round")
	else:
		new_index = battlers_array.find(active_battler.name) + 1
		active_battler = get_node(battlers_array[new_index])
		for i in range(4):
			if i + 1 <= battlers_array.size():
				get_node(turn_order_icon[i]).visible = true
				get_node(turn_order_icon[i]).set_texture(get_node(battlers_array[i]).icon)
			else:
				get_node(turn_order_icon[i]).visible = false
			if i != new_index:
				get_node(turn_order_icon[i]).self_modulate = Color8(57, 57, 57)
			else:
				get_node(turn_order_icon[i]).self_modulate = Color8(255, 255, 255)
		active_battler.turn()

func Stop():
	for i in range(4):
		get_node(turn_order_icon[i]).self_modulate = Color8(0, 0, 0)
