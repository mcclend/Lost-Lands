extends Control
class_name GameController

onready var hud = $HUD
onready var menu = $Menu
onready var pause_menu = $Menu/CanvasLayer/Pause
onready var main_menu = $Menu/CanvasLayer/MainMenu
onready var game_over = $Menu/CanvasLayer/GameOver
onready var level = $Level
onready var mech_prefab = preload("res://Assets/Prefab/Mech.tscn")
onready var human_prefab = preload("res://Assets/Prefab/Human.tscn")
onready var controls_menu = $Menu/CanvasLayer/ControlsMenu
onready var final_level_timer = $Menu/CanvasLayer/TimerDisplay
onready var lose_screen = $Menu/CanvasLayer/LoseScreen
onready var victory_screen = $Menu/CanvasLayer/VictoryScreen
var levelInstance



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.hud = hud
	Global.final_level_timer = final_level_timer
	#check if there is a game to continue
	if Global.can_load:$Menu/CanvasLayer/MainMenu/VBoxContainer/Continue.disabled = false
	Global.main_scene = self
	#Global.connect("returnToMainMenu", self, "returnToMainMenu")
	Global.connect("update_health", hud.health_bar, "update_health")
	Global.connect("update_max_health", hud.health_bar, "update_max_health")
	Global.connect("update_charge", hud.charge_bar, "update_health")
	Global.connect("update_max_charge", hud.charge_bar, "update_max_health")
	Global.connect("load_save", self, "loadScene")
	Global.connect("player_died", self, "deathScreen")
	Global.connect("returnToMainMenu", self, "returnToMainMenu")
	Global.connect("next_level", self, "loadScene")
	Global.connect("final_timer_timeout", self, "final_timer_timeout")
	Global.connect("victory", self, "victory")
	hide_hud()
	$Menu/CanvasLayer/MainMenu/AnimatedSprite.play("loop")

	
func hide_hud():
	for child in hud.get_children():
		child.hide()
	#hud.health_bar.hide()
	#hud.charge_bar.hide()
	#hud.hover_timer_image.hide()	
	
func show_hud():
	for child in hud.get_children():
		child.show()
	#hud.health_bar.show()
	#hud.charge_bar.show()
	#hud.hover_timer_image.show()	
	
func return_to_main_menu():
	if levelInstance != null:
		unloadLevel()
		level.remove_child(levelInstance)
	hide_hud()
	main_menu.show()
	pause_menu.hide()
	game_over.hide()
	pause_menu._on_resume_pressed()
	pause_menu.active = false
	
func deathScreen():
	game_over.show()
	pause_menu.hide()
	main_menu.hide()
	hide_hud()
	
func unloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null
	
func loadLevel(level_name : String):
	unloadLevel()
	var levelPath := "res://Assets/Scenes/Levels/%s.tscn" % level_name
	var levelResource := load(levelPath)
	if (levelResource):
		levelInstance = levelResource.instance()
		level.add_child(levelInstance)
		Global.current_scene = levelInstance
		Global.current_scene_name = level_name
		
func loadScene(scene = Global.current_scene_name, door_number = Global.load_door):
	loadLevel(scene)
	var new_player = human_prefab.instance()
	levelInstance.call_deferred("add_child",new_player)
	new_player.global_position = levelInstance.get_node("Doors/Door_%s/SpawnPosition" % door_number).global_position
	show_hud()
	menu.hide()
	lose_screen.hide()
	pause_menu.active = true
	if Global.has_grapple: Global.can_grapple = true
	if get_tree().paused:
		pause_menu._on_resume_pressed()
	_on_save_pressed()

func _on_save_pressed():
	Global.saveData(Global.SAVE_PATH)

func _on_load_pressed():
	main_menu.hide()
	pause_menu.hide()
	game_over.hide()
	pause_menu._on_resume_pressed()
	Global.loadData(Global.SAVE_PATH)

func _on_NewGame_pressed():
	main_menu.hide()
	$"Menu/CanvasLayer/Story Screen".show()
	$"Menu/CanvasLayer/Story Screen".active = true
	
func load_new_game():
	$"Menu/CanvasLayer/Story Screen".hide()
	Global.current_health = Global.max_health
	Global.current_charge = 0
	Global.has_grapple = false
	Global.can_grapple = false
	#Global.current_charge = Global.max_charge
	loadScene("Level00")
	main_menu.hide()
	
func quit():
	get_tree().quit()



func _on_Controls_pressed():
	main_menu.hide()
	pause_menu.hide()
	pause_menu.active = false
	controls_menu.active = true
	controls_menu.show()
	
func final_timer_timeout():
	unloadLevel()
	lose_screen.show()
	pause_menu.active = false
func victory():
	unloadLevel()
	pause_menu.active = false
	victory_screen.show()
	

