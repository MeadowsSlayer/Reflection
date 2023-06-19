extends Control

func Open():
	_Guard()

func CloseAll():
	for i in range($Box2/Intel.get_child_count()):
		$Box2/Intel.get_child(i).visible = false

func _Guard():
	$Box2/Label.text = "Camera Guard"
	$Box2/EnemyPic.texture = load("res://Sprites/UI/Enemy Intel/GuardBestiary.png")
	$Box2/Stats/ATKNum.text = "7"
	$Box2/Stats/DEFNum.text = "12"
	$Box2/Stats/ENDNum.text = "9"
	$Box2/Stats/SENNum.text = "10"
	$Box2/Stats/SPDNum.text = "10"
	$Box2/Stats/CRITNum.text = "5"
	$Box2/Stats/AVONum.text = "5"
	$Box2/Stats/RESNum.text = "10"
	$Box2/Weaknesses/Red_res.text = "R"
	$Box2/Weaknesses/Orange_res.text = "R"
	$Box2/Weaknesses/Yellow_res.text = "-"
	$Box2/Weaknesses/Green_res.text = "-"
	$Box2/Weaknesses/Blue_res.text = "W"
	$Box2/Weaknesses/Purple_res.text = "-"
	CloseAll()
	$Box2/Intel/Guard.visible = true

func _Gunner():
	$Box2/Label.text = "Gunner"
	$Box2/EnemyPic.texture = load("res://Sprites/UI/Enemy Intel/GuardBestiary.png")
	$Box2/Stats/ATKNum.text = "8"
	$Box2/Stats/DEFNum.text = "10"
	$Box2/Stats/ENDNum.text = "10"
	$Box2/Stats/SENNum.text = "15"
	$Box2/Stats/SPDNum.text = "10"
	$Box2/Stats/CRITNum.text = "7"
	$Box2/Stats/AVONum.text = "7"
	$Box2/Stats/RESNum.text = "10"
	$Box2/Weaknesses/Red_res.text = "-"
	$Box2/Weaknesses/Orange_res.text = "W"
	$Box2/Weaknesses/Yellow_res.text = "-"
	$Box2/Weaknesses/Green_res.text = "R"
	$Box2/Weaknesses/Blue_res.text = "R"
	$Box2/Weaknesses/Purple_res.text = "-"
	CloseAll()
	$Box2/Intel/Gunner.visible = true

func _DP_Warm():
	$Box2/Label.text = "Warm Dancing Painting"
	$Box2/EnemyPic.texture = load("res://Sprites/UI/Enemy Intel/GuardBestiary.png")
	$Box2/Stats/ATKNum.text = "9"
	$Box2/Stats/DEFNum.text = "12"
	$Box2/Stats/ENDNum.text = "12"
	$Box2/Stats/SENNum.text = "8"
	$Box2/Stats/SPDNum.text = "15"
	$Box2/Stats/CRITNum.text = "4"
	$Box2/Stats/AVONum.text = "5"
	$Box2/Stats/RESNum.text = "10"
	$Box2/Weaknesses/Red_res.text = "R"
	$Box2/Weaknesses/Orange_res.text = "R"
	$Box2/Weaknesses/Yellow_res.text = "-"
	$Box2/Weaknesses/Green_res.text = "-"
	$Box2/Weaknesses/Blue_res.text = "W"
	$Box2/Weaknesses/Purple_res.text = "W"
	CloseAll()
	$Box2/Intel/DP_Warm.visible = true

func _DP_Cold():
	$Box2/Label.text = "Cold Dancing Painting"
	$Box2/EnemyPic.texture = load("res://Sprites/UI/Enemy Intel/GuardBestiary.png")
	$Box2/Stats/ATKNum.text = "7"
	$Box2/Stats/DEFNum.text = "12"
	$Box2/Stats/ENDNum.text = "10"
	$Box2/Stats/SENNum.text = "8"
	$Box2/Stats/SPDNum.text = "6"
	$Box2/Stats/CRITNum.text = "4"
	$Box2/Stats/AVONum.text = "5"
	$Box2/Stats/RESNum.text = "10"
	$Box2/Weaknesses/Red_res.text = "W"
	$Box2/Weaknesses/Orange_res.text = "W"
	$Box2/Weaknesses/Yellow_res.text = "-"
	$Box2/Weaknesses/Green_res.text = "-"
	$Box2/Weaknesses/Blue_res.text = "R"
	$Box2/Weaknesses/Purple_res.text = "R"
	CloseAll()
	$Box2/Intel/DP_Cold.visible = true

