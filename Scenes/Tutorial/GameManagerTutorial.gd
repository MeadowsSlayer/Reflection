extends Node2D

var start = true
var finish = false
export (int) var i = 1
var enemies = 0
var max_enemies = 0
var gen = RandomNumberGenerator.new()
var run = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var cd_save = load("res://Prefabs/ScriptableObjects/CDSave.tres")
var max_waves = 0
var wave = 0
var tapes = 0

func _ready():
	if SoundPlayer.Check_Music("Battle") == false:
		SoundPlayer.stop_music()
		SoundPlayer.play_music("Battle")
	$Background/AnimationPlayer.play("Blinks")
	gen.randomize()
	wave = 1
	$CanvasLayer/Control/TextUp/Waves.text = tr("Waves: 1/1")
	$CanvasLayer/Animations.play("Start")
	enemies = 2
	get_node("BattleOrder/Enemy3").active = false
	$CanvasLayer/Control/TextUp/Room.text = "Tutorial"
	$CanvasLayer/Control/TextUp/StickersNum.text = str(0)
	
	get_node("BattleOrder/Enemy1").Activate()
	get_node("BattleOrder/Enemy2").Activate()
	get_node("BattleOrder/Enemy3").Activate()
	
	max_enemies += enemies

func _input(event):
	if (event.is_action_pressed("info")) && enemies != 0:
		if get_tree().paused == false && $CanvasLayer/Info.visible == false:
			$CanvasLayer/Info.Open()
	if (event.is_action_pressed("menu")):
		SoundPlayer.play_sound("Click")
		if (get_tree().paused == false && $CanvasLayer/GameOver.visible == false):
			get_node("CanvasLayer/Pause").Pause()
		else:
			if $CanvasLayer/Info.visible == true:
				$CanvasLayer/Info.Close()
			elif $CanvasLayer/Pause.visible == true:
				get_node("CanvasLayer/Pause").Unpause()

func _process(delta):
	if (enemies <= 0):
		$CanvasLayer/Animations.play("End")
		set_process(false)

func StartDialogue():
	$CanvasLayer.visible = false
	var new_dialog = Dialogic.start("0.Prologue - Tutorial")
	get_node("Dialog").add_child(new_dialog)

func Start():
	$CanvasLayer.visible = true
	get_node("BattleOrder").Start()
	get_node("CanvasLayer/Control/SkillSet").visible = true

func End():
	get_tree().change_scene("res://Scenes/Dialogues/Prologue/DialogueAfterTutorial.tscn")

func NewRound():
	$BattleOrder.NewRound()
