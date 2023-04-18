extends Control
class_name GameController

onready var hud = $HUD
onready var menu = $Menu
onready var pause_menu = $Menu/CanvasLayer/Pause
onready var main_menu = $Menu/CanvasLayer/MainMenu
onready var level = $Level

var levelInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func unloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null
	
func loadLevel(levelName : String):
	unloadLevel()
	var levelPath := "res://Assets/Scenes/Levels/%s.tscn" % levelName
	var levelResource := load(levelPath)
	if (levelResource):
		levelInstance = levelResource.instance()
		level.add_child(levelInstance)
		
func loadScene(scene = Global.currentScene):
	loadLevel(scene)
	Global.currentScene = scene
	hud.health_bar.show()
	hud.charge_bar.show()
	Global.UpdateHealth(Global.maxLife[0], 0)
	Global.UpdateHealth(Global.maxLife[1], 1)
	Global.UpdateMaxHealth(Global.maxLife[0], 0)
	Global.UpdateMaxHealth(Global.maxLife[1], 1)
	menu.hide()
	if get_tree().paused:
		pause_menu._on_resume_pressed()

func _on_save_pressed():
	Global.saveData(Global.SAVE_PATH)


func _on_load_pressed():
	Global.loadData(Global.SAVE_PATH)
