extends Control

var current_item
var global = load("res://Prefabs/ScriptableObjects/Global.tres")
var save_path
var save_path_path
var list_of_items = ["thorns", "umbrella", "glasses", "favoriteshirt", "comfortableshoes", "helmet",
	"cup", "notebook", "sprout", "violet", "pieceofshield", "bottleofblood", "bottledlightnings", "photographicfilm"]

func _ready():
	current_item = "thorns"
	$Description/Label.text = str(current_item, "_NAME")
	$Description/VBoxContainer/Description.text = str(current_item, "_DESCRIPTION")
	$Description/VBoxContainer/Lore.text = str(current_item, "_LORE")
	match global.get("save"):
		1:
			save_path_path = "res://Saves/Save1.tres"
		2:
			save_path_path = "res://Saves/Save2.tres"
		3:
			save_path_path = "res://Saves/Save3.tres"
	save_path = load(save_path_path)
	SetCurrent()
	for i in $Items/GridContainer.get_children():
		if save_path.get(str(i.name).to_lower()) == false:
			i.get_node("Icon").modulate = Color8(0,0,0)

func Check_Item():
	if save_path.get(current_item) == true:
		$Description/Choose.disabled = false
		$Description/Label.text = str(current_item, "_NAME")
		$Description/VBoxContainer/Description.text = str(current_item, "_DESCRIPTION")
		$Description/VBoxContainer/Lore.text = str(current_item, "_LORE")
	else:
		$Description/Choose.disabled = true
		$Description/Label.text = str(current_item, "_NAME")
		$Description/VBoxContainer/Description.text = str(current_item, "_DESCRIPTION_UNLOCK")
		$Description/VBoxContainer/Lore.text = "???"
		

func SetCurrent():
	for i in $Items/GridContainer.get_children():
		i.get_node("Current").visible = false
	
	match save_path.get("current_item"):
		"thorns":
			$Items/GridContainer/Thorns/Current.visible = true
		"umbrella":
			$Items/GridContainer/Umbrella/Current.visible = true
		"glasses":
			$Items/GridContainer/Glasses/Current.visible = true
		"favoriteshirt":
			$Items/GridContainer/FavoriteShirt/Current.visible = true
		"comfortableshoes":
			$Items/GridContainer/ComfortableShoes/Current.visible = true
		"helmet":
			$Items/GridContainer/Helmet/Current.visible = true
		"cup":
			$Items/GridContainer/Cup/Current.visible = true
		"notebook":
			$Items/GridContainer/Notebook/Current.visible = true
		"sprout":
			$Items/GridContainer/Sprout/Current.visible = true
		"violet":
			$Items/GridContainer/Violet/Current.visible = true
		"pieceofshield":
			$Items/GridContainer/PieceOfShield/Current.visible = true
		"bottledlightnings":
			$Items/GridContainer/BottledLightnings/Current.visible = true
		"bottleofblood":
			$Items/GridContainer/BottleOfBlood/Current.visible = true
		"photographicfilm":
			$Items/GridContainer/PhotographicFilm/Current.visible = true
		_:
			pass

func _on_Choose_pressed():
	SoundPlayer.play_sound("Click")
	if save_path.get(current_item) == true:
		save_path.set("current_item", current_item)
		save_path.save_game(save_path_path)
		SetCurrent()

func _on_Thorns_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "thorns"
	Check_Item()

func _on_Umbrella_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "umbrella"
	Check_Item()

func _on_Glasses_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "glasses"
	Check_Item()

func _on_FavoriteShirt_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "favoriteshirt"
	Check_Item()

func _on_ComfortableShoes_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "comfortableshoes"
	Check_Item()

func _on_Helmet_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "helmet"
	Check_Item()

func _on_Cup_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "cup"
	Check_Item()

func _on_Notebook_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "notebook"
	Check_Item()

func _on_Sprout_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "sprout"
	Check_Item()

func _on_Violet_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "violet"
	Check_Item()

func _on_PieceOfShield_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "pieceofshield"
	Check_Item()

func _on_BottleOfBlood_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "bottleofblood"
	Check_Item()

func _on_BottledLightnings_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "bottledlightnings"
	Check_Item()

func _on_PhotographicFilm_pressed():
	SoundPlayer.play_sound("Click")
	current_item = "photographicfilm"
	Check_Item()
