extends Button

var color
export var number = 1

var room_data = load("res://Prefabs/ScriptableObjects/Room.tres")

func _ready():
	if number == 1:
		color = room_data.get("current_room_reward1")
		if color == "":
			queue_free()
	elif number == 2:
		color = room_data.get("current_room_reward2")
		if color == "":
			queue_free()

	match color:
		"red":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRed.png")
			$Label2.text = "Red Skill"
		"green":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillGreen.png")
			$Label2.text = "Green Skill"
		"blue":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillBlue.png")
			$Label2.text = "Blue Skill"
		"orange":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillOrange.png")
			$Label2.text = "Orange Skill"
		"white":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRainbow.png")
			$Label2.text = "White Skill"
		"purple":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillPurple.png")
			$Label2.text = "Purple Skill"
		"yellow":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillYellow.png")
			$Label2.text = "Yellow Skill"

func _on_Skill_pressed():
	get_node("../../../../SkillChoosing").visible = true
	get_node("../../../../SkillChoosing").ChangeColor(color)
	queue_free()
