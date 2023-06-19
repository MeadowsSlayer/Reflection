extends Control

var stages = 1
var max_stages = 5
var clicks = 1
var check = false

func _ready():
	get_node("Timer").start()
	get_node("Button/AnimationPlayer").play("ClickTimeEvent")
	get_node("TextureProgress").max_value = 600
	check = false

func start_QTE(num_of_points):
	max_stages = num_of_points

func _process(delta):
	if (check == false):
		clicks -= 1
		if (clicks < 0):
			clicks = 0
		if (clicks > 600):
			clicks = 600
		get_node("TextureProgress").value = clicks
	
	Calculations()
	get_node("Num").text = str(stages)

func _unhandled_input(event):
	if (event.is_action_pressed("NA") && check == false):
		clicks += 40

func Calculations():
	if (clicks == 0):
		stages = 1
	if (clicks >= int(600/max_stages + 1) * 1 + 1):
		stages = 2
	if (clicks >= int(600/max_stages + 1) * 2 + 1):
		stages = 3
	if (clicks >= int(600/max_stages + 1) * 3 + 1):
		stages = 4
	if (clicks >= int(600/max_stages + 1) * 4 + 1):
		stages = 5
	if (clicks >= int(600/max_stages + 1) * 5 + 1):
		stages = 6
	if (clicks >= int(600/max_stages + 1) * 6 + 1):
		stages = 7
	if (clicks >= int(600/max_stages + 1) * 7 + 1):
		stages = 8
	if (clicks >= int(600/max_stages + 1) * 8 + 1):
		stages = 9
	if (clicks >= int(600/max_stages + 1) * 9 + 1):
		stages = 10

func _on_Timer_timeout():
	check = true
	Calculations()
	get_node("../../BattleOrder/Player").ult_mod = stages
	get_node("../../BattleOrder/Player").Ult_Timer()
	queue_free()
