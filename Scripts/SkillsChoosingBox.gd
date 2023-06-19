extends Control

var green
var orange

func _ready():
	pass

func _on_All_pressed():
	get_tree().call_group("Green", "TurnOn")
	get_tree().call_group("Orange", "TurnOn")

func _on_Orange_pressed():
	get_tree().call_group("Green", "TurnOff")
	get_tree().call_group("Orange", "TurnOn")

func _on_Green_pressed():
	get_tree().call_group("Green", "TurnOn")
	get_tree().call_group("Orange", "TurnOff")
