extends Control

var gen = RandomNumberGenerator.new()

func _ready():
	gen.randomize()
	$Encourage.text = str("EncourageText_", gen.randi_range(1, 5))

func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/Main Menu/StartMenu.tscn")
