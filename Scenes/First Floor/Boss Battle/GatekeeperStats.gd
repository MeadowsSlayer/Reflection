extends Node2D

var icon
var SPD
var weakness_hit = false
var actions_per_round = 1

onready var timer = $Timer
onready var player = NodePath("../Player")
var gen = RandomNumberGenerator.new()

func _ready():
	gen.randomize()
	SPD = get_child(1).SPD
	icon = get_child(1).icon

func turn():
	weakness_hit = false
	$Gatekeeper.turn()
