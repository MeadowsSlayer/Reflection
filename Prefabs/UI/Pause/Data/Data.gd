extends Control

func Open():
	get_node("../CenterContainer").visible = false
	$"../Label".visible = false
	self.visible = true
	$Glossary.visible = true
	$Bestiary.visible = false
	$Notes.visible = false

func _on_Back_pressed():
	get_node("../CenterContainer").visible = true
	$"../Label".visible = true
	self.visible = false

func _on_GlossaryButton_pressed():
	$Glossary.visible = true
	$Bestiary.visible = false
	$Notes.visible = false

func _on_BestiaryButton_pressed():
	$Glossary.visible = false
	$Bestiary.visible = true
	$Notes.visible = false
	$Bestiary.Open()

func _on_Notes_pressed():
	$Glossary.visible = false
	$Bestiary.visible = false
	$Notes.visible = true
