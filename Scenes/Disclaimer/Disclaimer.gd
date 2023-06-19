extends Control

func _ready():
	$Foreground/AnimationPlayer.play("Start")
	$Label/AnimationPlayer.play("idle")

func _input(event):
	if event.is_action_pressed("OK"):
		$Foreground/AnimationPlayer.play("Finish")

func Change():
	get_tree().change_scene("res://Scenes/Main Menu/StartMenu.tscn")
