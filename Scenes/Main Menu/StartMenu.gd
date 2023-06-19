extends Node2D

var start = true
var finish = false
export (int) var i = 1
export (NodePath) var camera
var save_game = load("res://Prefabs/ScriptableObjects/GameSave.tres")
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var room = load("res://Prefabs/ScriptableObjects/Room.tres")
var new = false

func _ready():
	get_node("TVCanvas/Pixelated").visible = true
	start = true
	finish = false

func _on_MainMenu_settings(value):
	if value == "settings":
		get_node(camera).position = Vector2(0, 1080)
	elif value == "main menu":
		get_node(camera).position = Vector2(0, 0)
	elif value == "start game":
		get_node(camera).position = Vector2(1920, 0)
	elif value == "set slot":
		get_node(camera).position = Vector2(1920, 1080)
	elif value == "credits":
		get_node(camera).position = Vector2(-1920, 0)
	elif value == "new game":
		CreateSave()
		finish = true
		get_node("TVCanvas/Pixelated").visible = true
		i = 255
		new = true
	elif value == "load slot":
		finish = true
		get_node("TVCanvas/Pixelated").visible = true
		i = 255
		new = false
	
func _process(delta):
	if (start == true):
		get_node("TVCanvas/Pixelated").material.set_shader_param("amount", i)
		i+=10
		get_node("TVCanvas/Pixelated/Black").modulate.a8 -= 10
		if (i >= 240):
			start = false
			get_node("TVCanvas/Pixelated").visible = false
			
	if (finish == true):
		get_node("TVCanvas/Pixelated").material.set_shader_param("amount", i)
		i-=10
		get_node("TVCanvas/Pixelated/Black").modulate.a8 += 5
		if (i <= 10):
			if (new == true):
				get_tree().change_scene("res://Scenes/Dialogues/Prologue/DialogueGameStart.tscn")
				
				run.start_run(true)
				finish = false
			else:
				get_tree().change_scene("res://Scenes/Longe/Longe/Longe.tscn")
				run.start_run(false)
				finish = false

func CreateSave():
	var save_path = ""
	if (get_node("MainMenu").save_slot == 1):
		save_path = "res://Saves/Save1.tres"
	elif (get_node("MainMenu").save_slot == 2):
		save_path = "res://Saves/Save2.tres"
	elif (get_node("MainMenu").save_slot == 3):
		save_path = "res://Saves/Save3.tres"
	
	save_game.save_game(save_path)
	var slot = load(save_path)
	slot.set("difficulty", get_node("MainMenu").dif)
	match slot.get("difficulty"):
		"normal":
			slot.set("red_res", 2)
			run.set("red_res", 2)
			slot.set("blue_res", 0.5)
			run.set("blue_res", 0.5)
		"easy":
			slot.set("red_res", 2)
			run.set("red_res", 2)
			slot.set("blue_res", 0.5)
			run.set("blue_res", 0.5)
			slot.set("green_res", 0.5)
			run.set("green_res", 0.5)
		"hard":
			slot.set("red_res", 2)
			run.set("red_res", 2)
			slot.set("blue_res", 0.5)
			run.set("blue_res", 0.5)
			slot.set("green_res", 2)
			run.set("green_res", 2)
	run.save_run()
	slot.save_game(save_path)
	
	
