extends Camera2D

export var player_x = 0
export var player_y = 0
export var e1_x = 0
export var e1_y = 0
export var e2_x = 0
export var e2_y = 0
export var e3_x = 0
export var e3_y = 0

func SetPosition(character):
	match character:
		"player":
			self.position = Vector2(player_x, player_y)
		"enemy1":
			self.position = Vector2(e1_x, e1_y)
		"enemy2":
			self.position = Vector2(e2_x, e2_y)
		"enemy3":
			self.position = Vector2(e3_x, e3_y)
