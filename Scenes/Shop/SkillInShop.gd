extends Button

var run_data = load("res://Prefabs/ScriptableObjects/CurrentRun.tres")
var colors = ["red", "green", "yellow", "blue", "orange", "purple"]
var gen = RandomNumberGenerator.new()
var skill_color
var sticker_cost = 30
export var slot = 1

func Start():
	gen.randomize()
	sticker_cost = 30 - 30 * $"../../..".price_modifier
	$StickersCost/Label.text = str(sticker_cost)
	if run_data.get("max_num_of_green") == 0:
		colors.erase("green")
	if run_data.get("max_num_of_orange") == 0:
		colors.erase("orange")
	if run_data.get("max_num_of_purple") == 0:
		colors.erase("purple")
	if run_data.get("max_num_of_blue") == 0:
		colors.erase("blue")
	if run_data.get("max_num_of_yellow") == 0:
		colors.erase("yellow")
	if run_data.get("max_num_of_red") == 0:
		colors.erase("red")
	if gen.randi_range(1, 100) < 90 || run_data.get("max_num_of_white") == 0:
		skill_color = colors[gen.randi_range(0, colors.size() - 1)]
	else:
		skill_color = "white"
	
	match skill_color:
		"red":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRed.png")
			$Label.text = "Red Skill"
		"orange":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillOrange.png")
			$Label.text = "Orange Skill"
		"yellow":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillYellow.png")
			$Label.text = "Yellow Skill"
		"green":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillGreen.png")
			$Label.text = "Green Skill"
		"blue":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillBlue.png")
			$Label.text = "Blue Skill"
		"purple":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillPurple.png")
			$Label.text = "Purple Skill"
		"white":
			$TextureRect.texture = load("res://Sprites/UI/Skills/EmptySkills/EmptySkillRainbow.png")
			$Label.text = "White Skill"
			sticker_cost = 45 - 45 * $"../../..".price_modifier
	
	$StickersCost/Label.text = str(sticker_cost)
	
func TurnOff():
	$TextureRect.texture = load("res://Sprites/UI/Skills/NoSkill.png")

func _on_self_pressed():
	get_node("../../../DialogWindow").Open(skill_color, sticker_cost, slot)
