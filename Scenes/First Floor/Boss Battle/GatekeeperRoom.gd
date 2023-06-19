extends Node2D

var start = true
var finish = false
export (int) var i = 1
var enemies = 0
var gen = RandomNumberGenerator.new()
var QTE = preload("res://Prefabs/UI/QTE/QTE.tscn")
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var cd_save = load("res://Prefabs/ScriptableObjects/CDSave.tres")

func _ready():
	$Background2/AnimationPlayer.play("Blinks")
	gen.randomize()
	$CanvasLayer/Animations.play("Start")
	$CanvasLayer/Control/TextUp/StickersNum.text = str(run.get("stickers"))

func _input(event):
	if (event.is_action_pressed("menu")):
		if (get_tree().paused == false):
			get_node("CanvasLayer/Pause").visible = true
			$CanvasLayer/Foreground/TextureRect2.visible = true
			get_tree().paused = true
		else:
			$CanvasLayer/Foreground/TextureRect2.visible = false
			get_node("CanvasLayer/Pause").visible = false
			get_tree().paused = false

func QTE():
	var QTE_instance = QTE.instance()
	add_child(QTE_instance)

func _on_Continue_pressed():
	$CanvasLayer/Foreground/TextureRect2.visible = false
	get_node("CanvasLayer/Pause").visible = false
	get_tree().paused = false

func _on_Exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/StartMenu.tscn")

func _process(delta):
	if (start == true):
		get_node("CanvasLayer/Pixelated").material.set_shader_param("amount", i)
		i+=10
		get_node("CanvasLayer/Pixelated/Black").modulate.a8 -= 10
		if (i >= 240):
			start = false
			get_node("CanvasLayer/Pixelated").visible = false
	if (enemies == 0):
		$BattleOrder.visible = false
		$CanvasLayer/Control.visible = false
		$CanvasLayer/AfterFight.visible = true
		cd_save.null_cd_data()
	
func _on_Abandon_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/GameOver.tscn")
