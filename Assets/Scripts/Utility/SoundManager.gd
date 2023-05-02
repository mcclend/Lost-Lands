extends Node2D

onready var bg_01 = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/background1.mp3")
onready var bg_02 = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/Background2.mp3")
onready var bg_03 = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/background3.mp3")
onready var bg_04 = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/Time trial.mp3")
onready var bg_HUB = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/background4.mp3")
onready var bg_Main_Menu = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/background4.mp3")
onready var bg_EE = preload("res://Assets/Audio Assets/Music 2.0/Music vol 1/eastereggfix.mp3")
onready var bg_player = $BackgroundMusic

func button_focus():
	$ButtonFocus.play()

func button_select():
	$ButtonSelect.play()
	
func open_door():
	$DoorOpen.play()
func battery_pickup():
	$BatteryPickup.play()

func _process(delta):
	match Global.current_scene_name:
		"Level01":
			if !bg_player.playing or !bg_player.stream == bg_01:
				bg_player.stop()
				bg_player.stream = bg_01
				bg_player.play()
		"Level02":
			if !bg_player.playing or !bg_player.stream == bg_02:
				bg_player.stop()
				bg_player.stream = bg_02
				bg_player.play()
		"Level03":
			if !bg_player.playing or !bg_player.stream == bg_03:
				bg_player.stop()
				bg_player.stream = bg_03
				bg_player.play()
		"Level04":
			if !bg_player.playing or !bg_player.stream == bg_04:
				bg_player.stop()
				bg_player.stream = bg_04
				bg_player.play()
		"Level_HUB":
			if !bg_player.playing or !bg_player.stream == bg_HUB:
				bg_player.stop()
				bg_player.stream = bg_HUB
				bg_player.play()
		"LevelEE":
			if !bg_player.playing or !bg_player.stream == bg_EE:
				bg_player.stop()
				bg_player.stream = bg_EE
				bg_player.play()
		null:
			if !bg_player.playing or !bg_player.stream == bg_Main_Menu:
				bg_player.stop()
				bg_player.stream = bg_Main_Menu
				bg_player.play()
			
	
	
		
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
