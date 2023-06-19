extends Control
signal settings(value)

var rus = NodePath("Settings/rus")
var eng = NodePath("Settings/eng")
var volume_slider = NodePath("Settings/VolumeSlider")
var music_slider = NodePath("Settings/MusicSlider")
var se_slider = NodePath("Settings/SoundSlider")
var delete = NodePath("StartGame/CenterContainer/VBoxContainer/HBoxContainer/Delete")
var dif_text = NodePath("NewGame/DifText")

var bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("SoundEffects")
var cur_lang = TranslationServer.get_locale()
var cur_vol = 0
var cur_se_vol = 0
var cur_music_vol = 0
var save_slot = 1
var dif = "normal"
var easy_text = "Enemies are easier to defeat and game more easy to clear the more you play. Suitable for players that want to see the whole story first."
var normal_text = "Normal difficulty that allows to experience the story normally and play game at mid speed. Not too fast, not too painful."
var hard_text = "Welcome to Hell. You only have yourself to blame."

var global_settings = {
	"lang" : "en",
	"volume" : 0.1,
	"music" : 0.1,
	"se" : 0.1,
	"glitches" : true
}

var directory = Directory.new()
var save_1_taken = directory.file_exists("res://Saves/Save1.tres")
var save_2_taken = directory.file_exists("res://Saves/Save2.tres")
var save_3_taken = directory.file_exists("res://Saves/Save3.tres")
var global_save = load("res://Prefabs/ScriptableObjects/Global.tres")
var gen = RandomNumberGenerator.new()

func _ready():
	load_global_data()
	save_slots_description()
	
	AudioServer.set_bus_volume_db(bus, linear2db(global_settings.volume))
	AudioServer.set_bus_volume_db(music_bus, linear2db(global_settings.music))
	AudioServer.set_bus_volume_db(sound_bus, linear2db(global_settings.se))
	
	if SoundPlayer.Check_Music("MainMenu") == false:
		SoundPlayer.stop_music()
		SoundPlayer.play_music("MainMenu")
	if TranslationServer.get_locale() == "ru":
		get_node(rus).set("custom_colors/font_color", Color8(11, 174, 253))
	if TranslationServer.get_locale() == "en":
		get_node(eng).set("custom_colors/font_color", Color8(11, 174, 253))
	if save_1_taken == false:
		get_node(delete).disabled = true
	get_node(dif_text).set("text", normal_text)
	$MainScreen/CenterContainer/VBoxContainer/StartGame.grab_focus()

func ColorOfBG():
	gen.randomize()
	var color = gen.randi_range(0, 6)

func save_slots_description():
	var text_slot = ""
	var slot
	if save_1_taken == true:
		slot = load("res://Saves/Save1.tres")
		text_slot = str("Difficulty: ",slot.get("difficulty"),"\nRuns: ",slot.get("runs"), "\nTapes: ",slot.get("tapes_all"))
		$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1/SlotInfo.text = text_slot
	if save_2_taken == true:
		slot = load("res://Saves/Save2.tres")
		text_slot = str("Difficulty: ",slot.get("difficulty"),"\nRuns: ",slot.get("runs"), "\nTapes: ",slot.get("tapes_all"))
		$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot2/SlotInfo.text = text_slot
	if save_3_taken == true:
		slot = load("res://Saves/Save3.tres")
		text_slot = str("Difficulty: ",slot.get("difficulty"),"\nRuns: ",slot.get("runs"), "\nTapes: ",slot.get("tapes_all"))
		$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot3/SlotInfo.text = text_slot

func save_data():
	global_save.set("glitches", global_settings.glitches)
	global_save.set("language", cur_lang)
	global_save.set("volume", global_settings.volume)
	global_save.set("music", global_settings.music)
	global_save.set("se", global_settings.se)
	global_save.set("save", save_slot)
	global_save.save_game()

func load_global_data():
	global_settings.glitches = global_save.get("glitches")
	$Settings/CheckButton.pressed = global_settings.glitches
	global_settings.lang = global_save.get("language")
	TranslationServer.set_locale(global_settings.lang)
	global_settings.volume = global_save.get("volume")
	global_settings.music = global_save.get("music")
	global_settings.se = global_save.get("se")
	AudioServer.set_bus_volume_db(bus, linear2db(global_settings.volume))
	AudioServer.set_bus_volume_db(music_bus, linear2db(global_settings.music))
	AudioServer.set_bus_volume_db(sound_bus, linear2db(global_settings.se))
	get_node("Settings/VolumeSlider").value = global_settings.volume
	get_node("Settings/SoundSlider").value = global_settings.se
	get_node("Settings/MusicSlider").value = global_settings.music

func _on_Settings_button_down():
	SoundPlayer.play_sound("Click")
	$Settings/VolumeSlider.grab_focus()
	emit_signal("settings", "settings")

func _on_Back_button_down():
	SoundPlayer.play_sound("Click")
	load_global_data()
	$MainScreen/CenterContainer/VBoxContainer/StartGame.grab_focus()
	emit_signal("settings", "main menu")

func _on_Confirm_button_down():
	SoundPlayer.play_sound("Click")
	global_settings.volume = get_node(volume_slider).value
	global_settings.music = get_node(music_slider).value
	global_settings.se = get_node(se_slider).value
	global_settings.lang = cur_lang
	save_data()
	$MainScreen/CenterContainer/VBoxContainer/StartGame.grab_focus()
	emit_signal("settings", "main menu")

func _on_rus_button_down():
	SoundPlayer.play_sound("Click")
	get_node(rus).set("custom_colors/font_color", Color8(11, 174, 253))
	get_node(eng).set("custom_colors/font_color", Color8(255, 255, 255))
	TranslationServer.set_locale("ru")
	cur_lang = "ru"

func _on_eng_button_down():
	SoundPlayer.play_sound("Click")
	get_node(eng).set("custom_colors/font_color", Color8(11, 174, 253))
	get_node(rus).set("custom_colors/font_color", Color8(255, 255, 255))
	TranslationServer.set_locale("en")
	cur_lang = "en"

func _on_Exit_button_down():
	SoundPlayer.play_sound("Click")
	get_tree().quit()
	
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(bus, linear2db(value))
	cur_vol = value

func _on_StartGame_button_down():
	SoundPlayer.play_sound("Click")
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1.grab_focus()
	emit_signal("settings", "start game")

func _on_StartGameTwo_button_down():
	SoundPlayer.play_sound("Click")
	save_data()
	if save_slot == 1:
		if save_1_taken == false:
			$NewGame/HBoxContainer/Normal.grab_focus()
			emit_signal("settings", "set slot")
		else:
			emit_signal("settings", "load slot")
	elif save_slot == 2:
		if save_2_taken == false:
			$NewGame/HBoxContainer/Normal.grab_focus()
			emit_signal("settings", "set slot")
		else:
			emit_signal("settings", "load slot")
	elif save_slot == 3:
		if save_3_taken == false:
			$NewGame/HBoxContainer/Normal.grab_focus()
			emit_signal("settings", "set slot")
		else:
			emit_signal("settings", "load slot")

func _on_SaveSlot1_pressed():
	SoundPlayer.play_sound("Click")
	save_slot = 1
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1.disabled = true
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot2.disabled = false
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot3.disabled = false
	if save_1_taken == true:
		get_node(delete).disabled = false
	else:
		get_node(delete).disabled = true

func _on_SaveSlot2_pressed():
	SoundPlayer.play_sound("Click")
	save_slot = 2
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1.disabled = false
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot2.disabled = true
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot3.disabled = false
	if save_2_taken == true:
		get_node(delete).disabled = false
	else:
		get_node(delete).disabled = true

func _on_SaveSlot3_pressed():
	SoundPlayer.play_sound("Click")
	save_slot = 3
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1.disabled = false
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot2.disabled = false
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot3.disabled = true
	if save_3_taken == true:
		get_node(delete).disabled = false
	else:
		get_node(delete).disabled = true

func _on_Delete_button_down():
	SoundPlayer.play_sound("Click")
	get_node(delete).disabled = true
	if save_slot == 1:
		directory.remove("res://Saves/Save1.tres")
		save_1_taken = false
		$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1/SlotInfo.text = "(Empty)"
	elif save_slot == 2:
		directory.remove("res://Saves/Save2.tres")
		save_2_taken = false
		$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot2/SlotInfo.text = "(Empty)"
	elif save_slot == 3:
		directory.remove("res://Saves/Save3.tres")
		save_3_taken = false
		$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot3/SlotInfo.text = "(Empty)"

func _on_BackToSlots_button_down():
	$StartGame/CenterContainer/VBoxContainer/GridContainer/SaveSlot1.grab_focus()
	emit_signal("settings", "start game")
	SoundPlayer.play_sound("Click")

func _on_Easy_button_down():
	dif = "easy"
	get_node(dif_text).set("text", easy_text)
	SoundPlayer.play_sound("Click")

func _on_Normal_button_down():
	dif = "normal"
	get_node(dif_text).set("text", normal_text)
	SoundPlayer.play_sound("Click")

func _on_Hard_button_down():
	dif = "hard"
	get_node(dif_text).set("text", hard_text)
	SoundPlayer.play_sound("Click")

func _on_Start_pressed():
	save_data()
	emit_signal("settings", "new game")
	SoundPlayer.play_sound("Click")

func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(sound_bus, linear2db(value))
	cur_se_vol = value
	SoundPlayer.play_sound("Click")

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear2db(value))
	cur_music_vol = value

func _on_Credits_pressed():
	SoundPlayer.play_sound("Click")
	emit_signal("settings", "credits")

func _on_Back_pressed():
	SoundPlayer.play_sound("Click")
	$MainScreen/CenterContainer/VBoxContainer/StartGame.grab_focus()
	emit_signal("settings", "main menu")

func _on_CheckButton_toggled(button_pressed):
	global_settings.glitches = button_pressed
