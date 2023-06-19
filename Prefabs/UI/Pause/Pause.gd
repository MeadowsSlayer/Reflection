extends Control

func Pause():
	$Back.visible = true
	self.visible = true
	get_tree().paused = true
	$Settings.Close()
	$Data._on_Back_pressed()

func Unpause():
	$Back.visible = false
	self.visible = false
	get_tree().paused = false

func _on_Continue_pressed():
	SoundPlayer.play_sound("Click")
	Unpause()

func _on_Exit_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu/StartMenu.tscn")

func _on_Abandon_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Longe/Longe/Longe.tscn")

func _on_Data_pressed():
	$Data.Open()

func _on_Settings_pressed():
	$Settings.Open()
