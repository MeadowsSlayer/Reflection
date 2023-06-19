extends Node2D

func _ready():
	SoundPlayer.stop_music()
	var new_dialog = Dialogic.start("/Meetings - Asya/0. Shop")
	get_node("Dialogue").add_child(new_dialog)

func Finish():
	get_tree().change_scene("res://Scenes/Shop/Shop.tscn")
