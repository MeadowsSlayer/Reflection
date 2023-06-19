extends Node2D

func _ready():
	SoundPlayer.stop_music()
	var new_dialog = Dialogic.start("0.Prologue - Before Fight")
	get_node("Dialog").add_child(new_dialog)

func Finish():
	get_tree().change_scene("res://Scenes/Tutorial/Tutorial.tscn")
