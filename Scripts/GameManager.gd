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
	max_waves = gen.randi_range(0, 4)
	if max_waves == 0 || (run.get("room") == 1 && run.get("floor_num") == 1):
		max_waves = 1
	if max_waves >= 3:
		max_waves = 2
	wave = 1
	$CanvasLayer/Control/TextUp/Waves.text = str("Waves: ", wave, "/", max_waves)
	$CanvasLayer/Animations.play("Start")
	enemies = gen.randi_range(1, 10)
	$CanvasLayer/Control/TextUp/Room.text = str("Room ", run.get("room"))
	$CanvasLayer/Control/TextUp/StickersNum.text = str(run.get("stickers"))
	if (enemies == 1):
		get_node("BattleOrder/Enemy2").active = false
		get_node("BattleOrder/Enemy3").active = false
	if (enemies >= 2 && enemies <= 5):
		enemies = 2
		get_node("BattleOrder/Enemy3").active = false
	if (enemies >= 6):
		if run.get("room") == 1:
			enemies = 2
			get_node("BattleOrder/Enemy3").active = false
		else:
			enemies = 3
	
	get_node("BattleOrder/Enemy1").Activate()
	get_node("BattleOrder/Enemy2").Activate()
	get_node("BattleOrder/Enemy3").Activate()
	
	max_enemies += enemies

func _input(event):
	if (event.is_action_pressed("info") && get_node("BattleOrder/Player").can_act == true):
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
		if wave == max_waves:
			$BattleOrder.visible = false
			$CanvasLayer/Control.visible = false
			$CanvasLayer/AfterFight.Start()
			cd_save.null_cd_data()
			SoundPlayer.stop_music()
			SoundPlayer.play_music("BetweenBattles")
			set_process(false)
		elif wave < max_waves:
			enemies = 1
			wave += 1
			get_node("BattleOrder").Stop()
			$CanvasLayer/Animations.play("New Wave")

func ClearWave():
	pass

func EnemyMinus():
	enemies -= 1
	if enemies == 1 && run.get("allforone") == true:
		get_node("BattleOrder/Player/StatusEffects").allforone_mod = 0.5
		get_node("BattleOrder/Player/StatusEffects").ItemsMultATKMod_OFF()
	else:
		get_node("BattleOrder/Player/StatusEffects").allforone_mod = 0
		get_node("BattleOrder/Player/StatusEffects").ItemsMultATKMod_OFF()

func NewWave():
	$CanvasLayer/Control/TextUp/Waves.text = str("Waves: ", wave, "/", max_waves)
	get_node("BattleOrder").Start()
	enemies = gen.randi_range(1, 10)
	if (enemies == 1):
		get_node("BattleOrder/Enemy1").active = true
		get_node("BattleOrder/Enemy2").active = false
		get_node("BattleOrder/Enemy3").active = false
	if (enemies >= 2 && enemies <= 5):
		enemies = 2
		get_node("BattleOrder/Enemy1").active = true
		get_node("BattleOrder/Enemy2").active = true
		get_node("BattleOrder/Enemy3").active = false
	if (enemies >= 6):
		if run.get("room") == 1:
			enemies = 2
			get_node("BattleOrder/Enemy1").active = true
			get_node("BattleOrder/Enemy2").active = true
			get_node("BattleOrder/Enemy3").active = false
		else:
			enemies = 3
			get_node("BattleOrder/Enemy1").active = true
			get_node("BattleOrder/Enemy2").active = true
			get_node("BattleOrder/Enemy3").active = true
	
	get_node("BattleOrder/Enemy1").Activate()
	get_node("BattleOrder/Enemy2").Activate()
	get_node("BattleOrder/Enemy3").Activate()
	
	max_enemies += enemies

func NewRound():
	$BattleOrder.NewRound()
