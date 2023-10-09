extends Control

onready var rus = NodePath("rus")
onready var eng = NodePath("eng")
onready var volume_slider = NodePath("VolumeSlider")
onready var music_slider = NodePath("MusicSlider")
onready var se_slider = NodePath("SoundSlider")

var bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("SoundEffects")
var cur_lang = TranslationServer.get_locale()
var cur_vol = 0
var cur_se_vol = 0
var cur_music_vol = 0

var global_settings = {
	"lang" : "en",
	"volume" : 0.1,
	"music" : 0.1,
	"se" : 0.1
}

var global_save = load("res://Prefabs/ScriptableObjects/Global.tres")

func Open():
	self.visible = true
	get_node("../CenterContainer").visible = false
	$"../Label".visible = false
	load_global_data()

func Close():
	self.visible = false
	get_node("../CenterContainer").visible = true
	$"../Label".visible = true

func save_data():
	global_save.set("language", cur_lang)
	global_save.set("volume", global_settings.volume)
	global_save.set("music", global_settings.music)
	global_save.set("se", global_settings.se)
	global_save.save_game()

func load_global_data():
	global_settings.lang = global_save.get("language")
	TranslationServer.set_locale(global_settings.lang)
	global_settings.volume = global_save.get("volume")
	global_settings.music = global_save.get("music")
	global_settings.se = global_save.get("se")
	AudioServer.set_bus_volume_db(bus, linear2db(global_settings.volume))
	AudioServer.set_bus_volume_db(music_bus, linear2db(global_settings.music))
	AudioServer.set_bus_volume_db(sound_bus, linear2db(global_settings.se))
	get_node("VolumeSlider").value = global_settings.volume
	get_node("SoundSlider").value = global_settings.se
	get_node("MusicSlider").value = global_settings.music

func _on_Back_button_down():
	SoundPlayer.play_sound("Click")
	load_global_data()
	Close()

func _on_Confirm_button_down():
	SoundPlayer.play_sound("Click")
	global_settings.volume = get_node(volume_slider).value
	global_settings.music = get_node(music_slider).value
	global_settings.se = get_node(se_slider).value
	global_settings.lang = cur_lang
	save_data()
	Close()

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

func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(bus, linear2db(value))
	cur_vol = value

func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(sound_bus, linear2db(value))
	cur_se_vol = value
	SoundPlayer.play_sound("Click")

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear2db(value))
	cur_music_vol = value
