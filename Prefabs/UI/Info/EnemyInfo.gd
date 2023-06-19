extends NinePatchRect

export var num = 1
var enemy_exists = false
var enemy_path
var enemy

func _ready():
	enemy_path = str("../../../../../BattleOrder/Enemy", num)

func Open():
	if get_node(enemy_path).active == true:
		enemy_exists = true
		enemy = get_node(enemy_path).get_child(1)
		OpenEnemy()
	else:
		OpenNull()

func OpenNull():
	$None.visible = true
	$Icon.visible = false
	$Name.visible = false
	$Type2.visible = false
	$Stats.visible = false
	$StatusEffects.visible = false
	$Weaknesses.visible = false

func OpenEnemy():
	$None.visible = false
	$Icon.visible = true
	$Name.visible = true
	$Type2.visible = true
	$Stats.visible = true
	$StatusEffects.visible = true
	$Weaknesses.visible = true
	
	$Name.text = enemy.en_name
	$Icon.texture = enemy.icon
	
	#Stats
	$Stats/RESNum.text = str(enemy.RES)
	$Stats/ATKNum.text = str(enemy.ATK)
	$Stats/DEFNum.text = str(enemy.DEF)
	$Stats/ENDNum.text = str(enemy.END)
	$Stats/SENNum.text = str(enemy.SEN)
	$Stats/SPDNum.text = str(enemy.SPD)
	$Stats/CRITNum.text = str(enemy.CRIT)
	$Stats/AVONum.text = str(enemy.AVO)
	
	#Resistances
	$Weaknesses/Red_res.text = Res(enemy.red_res)
	$Weaknesses/Orange_res.text = Res(enemy.orange_res)
	$Weaknesses/Yellow_res.text = Res(enemy.yellow_res)
	$Weaknesses/Green_res.text = Res(enemy.green_res)
	$Weaknesses/Blue_res.text = Res(enemy.blue_res)
	$Weaknesses/Purple_res.text = Res(enemy.purple_res)
	
	#Status Effects
	#Fragile
	if enemy.fragile_duration != 0:
		$StatusEffects/VBoxContainer/Fragile.visible = true
		$StatusEffects/VBoxContainer/Fragile/Status2.text = str(tr("Fragile"), ": ", enemy.fragile, "%")
		$StatusEffects/VBoxContainer/Fragile/Duration2.text = str("DURATION_", enemy.fragile_duration)
	else:
		$StatusEffects/VBoxContainer/Fragile.visible = false
	
	#Spread
	if enemy.spread_duration != 0:
		$StatusEffects/VBoxContainer/Fragile.visible = true
		$StatusEffects/VBoxContainer/Fragile/Status2.text = str(tr("Spread"), ": ", enemy.spread, "%")
		$StatusEffects/VBoxContainer/Fragile/Duration2.text = str("DURATION_", enemy.spread_duration)
	else:
		$StatusEffects/VBoxContainer/Fragile.visible = false
	
	#Closure
	if enemy.closure_duration != 0:
		$StatusEffects/VBoxContainer/Closure.visible = true
		$StatusEffects/VBoxContainer/Closure/Status2.text = str(tr("Closure"), " ", enemy.closure)
		$StatusEffects/VBoxContainer/Closure/Duration2.text = str("DURATION_", enemy.closure_duration)
	else:
		$StatusEffects/VBoxContainer/Closure.visible = false
	
	#Aches
	if enemy.aches_duration != 0:
		$StatusEffects/VBoxContainer/Aches.visible = true
		$StatusEffects/VBoxContainer/Aches/Status2.text = str(tr("Aches"), ": ", enemy.aches, "%")
		$StatusEffects/VBoxContainer/Aches/Duration2.text = str("DURATION_", enemy.aches_duration)
	else:
		$StatusEffects/VBoxContainer/Aches.visible = false
	
	#Empowerment
	if enemy.empowerment_duration != 0:
		$StatusEffects/VBoxContainer/Empowerment.visible = true
		$StatusEffects/VBoxContainer/Empowerment/name.text = str(tr("Empowerment"), ": ", enemy.empowerment, "%")
		$StatusEffects/VBoxContainer/Empowerment/Duration2.text = str("DURATION_", enemy.empowerment_duration)
	else:
		$StatusEffects/VBoxContainer/Empowerment.visible = false
	
	#Blind
	if enemy.blind_duration != 0:
		$StatusEffects/VBoxContainer/Blind.visible = true
		$StatusEffects/VBoxContainer/Blind/name.text = str(tr("Blind"), ": ", enemy.blind, "%")
		$StatusEffects/VBoxContainer/Blind/Duration2.text = str("DURATION_", enemy.blind_duration)
	else:
		$StatusEffects/VBoxContainer/Blind.visible = false
	
	#Silence
	if enemy.silence_duration != 0:
		$StatusEffects/VBoxContainer/Silence.visible = true
		$StatusEffects/VBoxContainer/Silence/Duration2.text = str("DURATION_", enemy.silence_duration)
	else:
		$StatusEffects/VBoxContainer/Silence.visible = false
	
	#Sleep
	if enemy.sleep_duration != 0:
		$StatusEffects/VBoxContainer/Sleep.visible = true
		$StatusEffects/VBoxContainer/Sleep/Duration2.text = str("DURATION_", enemy.sleep_duration)
	else:
		$StatusEffects/VBoxContainer/Sleep.visible = false
	
	#Exhaustion
	if enemy.exhaustion != 0:
		$StatusEffects/VBoxContainer/Exhaustion.visible = true
		$StatusEffects/VBoxContainer/Exhaustion/name.text = str(tr("Exhaustion"), ": ", enemy.exhaustion, " EN")
	else:
		$StatusEffects/VBoxContainer/Exhaustion.visible = false
	
	#Miasma
	if enemy.miasma_duration != 0:
		$StatusEffects/VBoxContainer/Miasma.visible = true
		$StatusEffects/VBoxContainer/Miasma/name.text = str(tr("Miasma"), ": ", enemy.miasma, "%")
		$StatusEffects/VBoxContainer/Miasma/Duration2.text = str("DURATION_", enemy.miasma_duration)
	else:
		$StatusEffects/VBoxContainer/Miasma.visible = false
	
	#Block
	if enemy.block_num != 0:
		$StatusEffects/VBoxContainer/Miasma.visible = true
		$StatusEffects/VBoxContainer/Miasma/Duration2.text = str(enemy.block_num, " ", tr("Hits"))
	else:
		$StatusEffects/VBoxContainer/Miasma.visible = false
	
	#Bind
	if enemy.bind_duration != 0:
		$StatusEffects/VBoxContainer/Miasma.visible = true
		$StatusEffects/VBoxContainer/Miasma/name.text = str(tr("Bind"), ": ", enemy.bind_power, "%")
		$StatusEffects/VBoxContainer/Miasma/Duration2.text = str("DURATION_", enemy.bind_duration)
	else:
		$StatusEffects/VBoxContainer/Miasma.visible = false
	
	#Haste
	if enemy.haste_duration != 0:
		$StatusEffects/VBoxContainer/Miasma.visible = true
		$StatusEffects/VBoxContainer/Miasma/name.text = str(tr("Haste"), ": ", enemy.haste, "%")
		$StatusEffects/VBoxContainer/Miasma/Duration2.text = str("DURATION_", enemy.haste_duration)
	else:
		$StatusEffects/VBoxContainer/Miasma.visible = false
	
	#Mental Protection
	if enemy.mentalprotection_duration != 0:
		$StatusEffects/VBoxContainer/MentalProtection.visible = true
		$StatusEffects/VBoxContainer/MentalProtection/Duration2.text = str("DURATION_", enemy.mentalprotection_duration)
	else:
		$StatusEffects/VBoxContainer/MentalProtection.visible = false
	
	#Protect The Art
	if enemy.protecttheart_duration != 0:
		$StatusEffects/VBoxContainer/ProtectTheArt.visible = true
		$StatusEffects/VBoxContainer/ProtectTheArt/Duration2.text = str("DURATION_", enemy.protecttheart_duration)
	else:
		$StatusEffects/VBoxContainer/ProtectTheArt.visible = false
	
	#Burst Of Energy
	if enemy.burstofenergy_duration != 0:
		$StatusEffects/VBoxContainer/BurstOfEnergy.visible = true
		$StatusEffects/VBoxContainer/BurstOfEnergy/Duration2.text = str("DURATION_", enemy.burstofenergy_duration)
	else:
		$StatusEffects/VBoxContainer/BurstOfEnergy.visible = false
	
	#Scorching Heat
	if enemy.scorchingheat_duration != 0:
		$StatusEffects/VBoxContainer/ScorchingHeat.visible = true
		$StatusEffects/VBoxContainer/ScorchingHeat/Duration2.text = str("DURATION_", enemy.scorchingheat_duration)
	else:
		$StatusEffects/VBoxContainer/BurstOfEnergy.visible = false
	
	#Dance Of Death
	if enemy.danceofdeath == true:
		$StatusEffects/VBoxContainer/DanceOfDeath/Duration2.text = str("DURATION_", enemy.danceofdeath_duration)
		$StatusEffects/VBoxContainer/DanceOfDeath.visible = true
	else:
		$StatusEffects/VBoxContainer/DanceOfDeath.visible = false

func Res(num):
	match num:
		0:
			return "IM"
		1:
			return "-"
		2:
			return "W"
		0.5:
			return "R"
