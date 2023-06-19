extends Control

var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save
var save_path
var correct = true
var ress = ["red_res", "orange_res", "yellow_res", "green_res", "blue_res", "purple_res"]

func _ready():
	match global.get("save"):
		1:
			save_path = "res://Saves/Save1.tres"
		2:
			save_path = "res://Saves/Save2.tres"
		3:
			save_path = "res://Saves/Save3.tres"
	
	save = load(save_path)
	if save.get("tough_rank") == 1:
		$HBoxContainer/Resistance3.select(FindRES(3))
		$HBoxContainer/RES3.visible = true
		$HBoxContainer/Resistance3.visible = true
	else:
		$HBoxContainer/Resistance3.select(-1)
		$HBoxContainer/Resistance3.visible = false
		$HBoxContainer/RES3.visible = false
	
	match save.get("difficulty"):
		"normal":
			$HBoxContainer/Resistance1.select(FindRES(1))
			$HBoxContainer/Weakness.select(FindWEK(1))
		"hard":
			$HBoxContainer/Resistance1.select(FindRES(1))
			$HBoxContainer/Weakness.select(FindWEK(1))
			$HBoxContainer/Weakness2.select(FindWEK(2))
			$HBoxContainer/WEK2.visible = true
			$HBoxContainer/Weakness2.visible = true
		"easy":
			$HBoxContainer/Resistance1.select(FindRES(1))
			$HBoxContainer/Resistance2.select(FindRES(2))
			$HBoxContainer/Weakness.select(FindWEK(1))
			$HBoxContainer/RES2.visible = true
			$HBoxContainer/Resistance2.visible = true

func FindRES(num):
	var color1 = null
	var color2 = null
	var color3 = null
	if save.get("difficulty") == "normal" || save.get("difficulty") == "hard":
		color2 = 0
	for i in range(ress.size()):
		if run.get(ress[i]) == 0.5:
			if color1 == null:
				color1 = i
			elif color2 == null:
				color2 = i
			elif color3 == null:
				color3 = i
	
	if num == 1 && color1 != null:
		return color1
	elif num == 2 && color2 != null:
		return color2
	elif num == 3 && color3 != null:
		return color3
	else:
		return 0

func FindWEK(num):
	var color1 = null
	var color2 = null
	for i in range(ress.size()):
		if run.get(ress[i]) == 2:
			if color1 == null:
				color1 = i
			else:
				color2 = i
	
	if num == 1 && color1 != null:
		return color1
	elif num == 2 && color2 != null:
		return color2
	else:
		return 0

func _on_Resistance1_item_selected(index):
	match save.get("difficulty"):
		"normal":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id():
				correct = true
			else:
				correct = false
		"hard":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id() && $HBoxContainer/Weakness2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id():
				correct = true
			else:
				correct = false
		"easy":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance2.get_selected_id() && $HBoxContainer/Resistance2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Resistance2.get_selected_id():
				correct = true
			else:
				correct = false
	
	if $"../..".skill1 != null && $"../..".skill2 != null && $"../..".skill3 != null && correct == true:
		$"../Go".disabled = false
	else:
		$"../Go".disabled = true

func _on_Resistance2_item_selected(index):
	if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance2.get_selected_id() && $HBoxContainer/Resistance2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Resistance2.get_selected_id():
		correct = true
	else:
		correct = false
	
	if $"../..".skill1 != null && $"../..".skill2 != null && $"../..".skill3 != null && correct == true:
		$"../Go".disabled = false
	else:
		$"../Go".disabled = true

func _on_Weakness_item_selected(index):
	match save.get("difficulty"):
		"normal":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id():
				correct = true
			else:
				correct = false
		"hard":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id() && $HBoxContainer/Weakness2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id():
				correct = true
			else:
				correct = false
		"easy":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance2.get_selected_id() && $HBoxContainer/Resistance2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Resistance2:
				correct = true
			else:
				correct = false
	
	if $"../..".skill1 != null && $"../..".skill2 != null && $"../..".skill3 != null && correct == true:
		$"../Go".disabled = false
	else:
		$"../Go".disabled = true

func _on_Weakness2_item_selected(index):
	if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id() && $HBoxContainer/Weakness2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id():
		correct = true
	else:
		correct = false
	
	if $"../..".skill1 != null && $"../..".skill2 != null && $"../..".skill3 != null && correct == true:
		$"../Go".disabled = false
	else:
		$"../Go".disabled = true


func _on_Resistance3_item_selected(index):
	match save.get("difficulty"):
		"normal":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id():
				correct = true
			else:
				correct = false
		"hard":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id() && $HBoxContainer/Weakness2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness2.get_selected_id():
				correct = true
			else:
				correct = false
		"easy":
			if $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance2.get_selected_id() && $HBoxContainer/Resistance2.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Weakness.get_selected_id() && $HBoxContainer/Resistance1.get_selected_id() != $HBoxContainer/Resistance3.get_selected_id() && $HBoxContainer/Resistance3.get_selected_id() != $HBoxContainer/Resistance2:
				correct = true
			else:
				correct = false
	
	if $"../..".skill1 != null && $"../..".skill2 != null && $"../..".skill3 != null && correct == true:
		$"../Go".disabled = false
	else:
		$"../Go".disabled = true
