extends Control

export var stage = 0

func _ready():
	$AnimationPlayer.play("Start")

func _input(event):
	if event.is_action_pressed("accept") && stage == 0:
		$VBoxContainer/NinePatchRect/Label.percent_visible = 1
		ChangeStage()
	if event.is_action_pressed("accept") && stage == 2:
		$Timer.start()

func ChangeStage():
	match stage:
		0:
			stage = 1
			$AnimationPlayer.play("ButtonsUp")

func _on_Leave_pressed():
	stage = 2
	$AnimationPlayer.play("End")

func _on_Timer_timeout():
	$AfterEncounter.visible = true
	$AfterEncounter.ShowRooms()
