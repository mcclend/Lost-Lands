extends Node2D


func button_focus():
	$ButtonFocus.play()

func button_select():
	$ButtonSelect.play()
	
func open_door():
	$DoorOpen.play()
func battery_pickup():
	$BatteryPickup.play()

func _process(delta):
	if Global.current_scene_name == "Level01":
		$Level01.play()
		$HUB.stop()
		$Level02.stop()
		$Level03.stop()
		$Level04.stop()
		$LevelEE.stop()
		$MainMenu.stop()
	elif Global.current_scene_name == "Level02":
		$Level02.play()
		$HUB.stop()
		$Level01.stop()
		$Level03.stop()
		$Level04.stop()
		$LevelEE.stop()
		$MainMenu.stop()
	elif Global.current_scene_name == "Level03":
		$Level03.play()
		$HUB.stop()
		$Level01.stop()
		$Level02.stop()
		$Level04.stop()
		$LevelEE.stop()
		$MainMenu.stop()
	elif Global.current_scene_name == "Level04":
		$Level04.play()
		$HUB.stop()
		$Level01.stop()
		$Level02.stop()
		$Level03.stop()
		$LevelEE.stop()
		$MainMenu.stop()
	elif Global.current_scene_name == "LevelEE":
		$LevelEE.play()
		$HUB.stop()
		$Level01.stop()
		$Level02.stop()
		$Level03.stop()
		$Level04.stop()
		$MainMenu.stop()
	else:
		$MainMenu.play()
		$HUB.stop()
		$Level01.stop()
		$Level02.stop()
		$Level03.stop()
		$Level04.stop()
		$LevelEE.stop()
		
"""
if Global.current_scene_name == "Level_HUB":
$HUB.play()
$Level01.stop()
$Level02.stop()
$Level03.stop()
$Level04.stop()
$LevelEE.stop()
$MainMenu.stop()

$HUB.stop()
$Level01.stop()
$Level02.stop()
$Level03.stop()
$Level04.stop()
$LevelEE.stop()
$MainMenu.stop()
"""
