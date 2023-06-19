extends Control

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")

func Start():
	self.visible = true
	if get_parent().boss_door == true:
		$CenterContainer/HBoxContainer/Room1.SetBossRoom()
		$CenterContainer/HBoxContainer/Room2.visible = false
		$CenterContainer/HBoxContainer/Room3.visible = false
	else:
		get_tree().call_group("Rooms", "Start")
