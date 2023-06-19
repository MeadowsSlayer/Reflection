extends KinematicBody2D

var gen = RandomNumberGenerator.new()
var position_y = 156
var velocity = Vector2()
var move = true
var points = 1
var can_click = false

func _ready():
	gen.randomize()
	position_y = gen.randf_range(156, 936)
	move = true
	position = Vector2(974, position_y)
	get_node("../Timer").start()

func _physics_process(delta):
	if (move == true):
		velocity = position.direction_to(Vector2(974, position_y)) * 500
		if position.distance_to(Vector2(974, position_y)) > 5:
			velocity = move_and_slide(velocity)
		else:
			position_y = gen.randi_range(156, 936)

func _unhandled_input(event):
	if (event.is_action_pressed("accept") && can_click == true):
		move = false
		get_node("../../../BattleOrder/Player").ult_mod = points
		get_node("../../../BattleOrder/Player").Ult_Timer()
		get_parent().queue_free()

func _on_Perfect_body_entered(body):
	points = 4

func _on_Great_body_entered(body):
	points = 3

func _on_Mid_body_entered(body):
	points = 2

func _on_Mid_body_exited(body):
	points = 1

func _on_Great_body_exited(body):
	points = 2

func _on_Perfect_body_exited(body):
	points = 3

func _on_Timer_timeout():
	can_click = true
