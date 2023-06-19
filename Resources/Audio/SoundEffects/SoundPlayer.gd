extends Node

func play_music(music):
	get_node(str("Music/", music)).stream_paused = false
	get_node(str("Music/", music)).play()

func play_sound(sound):
	get_node(str("AudioPlayers/", sound)).stream_paused = false
	get_node(str("AudioPlayers/", sound)).play()

func stop_music():
	$AudioPlayers/Change.play()
	for i in $Music.get_children():
		i.stop()

func Check_Music(track):
	return get_node(str("Music/", track)).playing
