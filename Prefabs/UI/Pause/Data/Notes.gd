extends Control

var save
var save_path
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var enemy_intel = load("res://Prefabs/ScriptableObjects/EnemyIntelGlobal.tres")
onready var salim_1 = $Box1/ScrollContainer/VBoxContainer/Salim1
onready var asya_4 = $Box1/ScrollContainer/VBoxContainer/Asya4
onready var asya_5 = $Box1/ScrollContainer/VBoxContainer/Asya5
onready var salim_2 = $Box1/ScrollContainer/VBoxContainer/Salim2
onready var salim_3 = $Box1/ScrollContainer/VBoxContainer/Salim3
onready var note_name = $Box2/Name
onready var note = $Box2/Note

func _ready():
	if (global.get("save") == 1):
		save_path = "res://Saves/Save1.tres"
	elif (global.get("save") == 2):
		save_path = "res://Saves/Save2.tres"
	elif (global.get("save") == 3):
		save_path = "res://Saves/Save3.tres"
	
	save = load(save_path)

func TurnOnButtons():
	if save.get("runs") >= 2:
		salim_1.visible = true
	if save.get("runs") >= 4:
		salim_2.visible = true
	if save.get("shop_visited") == true:
		asya_4.visible = true
		if save.get("runs") >= 6:
			asya_5.visible = true
	
	if enemy_intel.get("Gatekeeper_seen") == true:
		salim_3.visible = true

func _on_Asya1_pressed():
	note_name = "Awakening"
	note = "NOTE_AWAKENING"

func _on_Asya2_pressed():
	note_name = "Exploration"
	note = "NOTE_EXPLORATION"

func _on_Asya3_pressed():
	if save.get("floor_three_cleared") == true:
		note_name = "Complicated Feelings"
		note = "NOTES_COMPLICATED_FEELINGS"
	else:
		note_name = "[Note Unavailable]"
		note = "NOTE_UNAVAILABLE_ASYA"

func _on_Salim1_pressed():
	note_name = "Beginning"
	note = "NOTE_BEGINNING"

func _on_Asya4_pressed():
	note_name = "Shop"
	note = "NOTE_SHOP"

func _on_Asya5_pressed():
	if save.get("floor_three_cleared") == true:
		note_name = "Only Watch"
		note = "NOTES_ONLY_WATCH"
	else:
		note_name = "[Note Unavailable]"
		note = "NOTE_UNAVAILABLE_ASYA"

func _on_Salim2_pressed():
	note_name = "Strange Feeling"
	note = "NOTE_STRANGE_FEELING"

func _on_Salim3_pressed():
	note_name = "Gatekeeper"
	note = "NOTE_GATEKEEPER"
