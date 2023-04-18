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
<<<<<<< Updated upstream
	pass # Replace with function body.

=======
	Global.hud = hud
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
	Global.connect("next_level", self, "loadLevel")
	Global.connect("show_grapple_icon", self, "show_grapple_icon")
	Global.connect("show_mech_boost_icon", self, "show_mech_boost_icon")
	hide_hud()
	
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
	
func deathScreen():
	game_over.show()
	pause_menu.hide()
	main_menu.hide()
	hide_hud()
	
>>>>>>> Stashed changes
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

func show_grapple_icon(value:float):
	hud.grapple_icon.visible = value
func show_mech_boost_icon(value:float):
	hud.mech_boost_icon.visible = value

func _on_save_pressed():
	Global.saveData(Global.SAVE_PATH)


func _on_load_pressed():
	Global.loadData(Global.SAVE_PATH)
