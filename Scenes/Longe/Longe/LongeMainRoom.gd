extends Control

func _ready():
	SoundPlayer.stop_music()
	SoundPlayer.play_music("MainMenu")
	if SoundPlayer.Check_Music("MainMenu") == false:
		SoundPlayer.stop_music()
		SoundPlayer.play_music("MainMenu")
	get_node("SalimSits/AnimationPlayer").play("Idle")
	get_node("../Foreground/AnimationPlayer").play("default")

func _input(event):
	if (event.is_action_pressed("menu")):
		if (get_tree().paused == false):
			get_node("../CanvasLayer/Pause").visible = true
			get_tree().paused = true
		else:
			get_node("../CanvasLayer/Pause").visible = false
			get_tree().paused = false

func _on_TV_pressed():
	SoundPlayer.play_sound("Click")
	$"../Upgrades".visible = false
	get_node("../Upgrades").visible = true

func _on_Door_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().change_scene("res://Scenes/Longe/Waiting Room/WaitingRoom.tscn")

func _on_Chest_pressed():
	SoundPlayer.play_sound("Click")
	get_node("../Chest").visible = true

func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			SoundPlayer.play_sound("Click")
			get_node("../Upgrades").visible = false
			get_node("../Upgrades/Description").visible = false

func _on_ChestBG_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			SoundPlayer.play_sound("Click")
			get_node("../Chest").visible = false

func _on_Exit_pressed():
	SoundPlayer.play_sound("Click")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu/StartMenu.tscn")

func _on_Continue_pressed():
	SoundPlayer.play_sound("Click")
	get_node("../CanvasLayer/Pause").visible = false
	get_tree().paused = false
