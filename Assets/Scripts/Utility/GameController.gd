extends Control
class_name GameController

onready var hud = $HUD
onready var menu = $Menu
onready var pause_menu = $Menu/CanvasLayer/Pause
onready var main_menu = $Menu/CanvasLayer/MainMenu
onready var game_over = $Menu/CanvasLayer/GameOver
onready var level = $Level

var levelInstance



# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	
func return_to_main_menu():
	unloadLevel()
	if levelInstance != null:
		level.remove_child(levelInstance)
	hud.hide()
	main_menu.show()
	pause_menu._on_resume_pressed()
	
func deathScreen():
	game_over.show()
	pause_menu.hide()
	main_menu.hide()
	hud.hide()
	
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
		
func loadScene(scene = Global.currentScene):
	loadLevel(scene)
	hud.health_bar.show()
	hud.charge_bar.show()
	menu.hide()
	if get_tree().paused:
		pause_menu._on_resume_pressed()

func _on_save_pressed():
	Global.saveData(Global.SAVE_PATH)

func _on_load_pressed():
	Global.loadData(Global.SAVE_PATH)

func _on_NewGame_pressed():
	loadScene("test")
	main_menu.hide()
	
func quit():
	get_tree().quit()
