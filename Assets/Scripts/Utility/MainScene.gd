extends Control

signal startHoverTimer()
signal startHoverCooldown()

onready var HUD : Control = $HUD
onready var healthBar = $HUD/HUD/CanvasLayer/HealthBar
onready var chargeBar = $HUD/HUD/CanvasLayer/HealthBar2
onready var menu : Control = $Menu
onready var main2D : Node2D = $Main2D
onready var camera : Camera2D = $Main2D/Camera2D
onready var grappleCooldownTimer = $GrappleCooldownTimer
onready var grappleCooldownTexture = $HUD/HUD/CanvasLayer/mouse/Control/cursor
onready var hoverTimer = $MechHoverTimer
onready var hoverCooldownTimer = $MechHoverCooldownTimer
onready var hoverTimerTexture = $HUD/HUD/CanvasLayer/MechHoverTimer
var levelInstance

func _ready():
	Global.mainScene = self
	Global.connect("returnToMainMenu", self, "returnToMainMenu")
	Global.connect("updateHealth", healthBar, "UpdateHealth")
	Global.connect("updateMaxHealth", healthBar, "UpdateMaxHealth")
	Global.connect("updateCharge", chargeBar, "UpdateHealth")
	Global.connect("updateMaxCharge", chargeBar, "UpdateMaxHealth")
	Global.connect("deathScreen", self, "deathScreen")
	Global.connect("startGrappleCooldown", grappleCooldownTimer, "start")
	Global.connect("startGrappleCooldown", self, "show_grapple_cooldown")
	Global.connect("loadSave", self, "loadScene")
	Global.connect("startHoverTimer", self, "_start_hover_timer")
	chargeBar.hide()
	healthBar.hide()
	grappleCooldownTexture.hide()
	hoverTimerTexture.hide()
	
func _process(delta):
	if grappleCooldownTimer.get_time_left() > 0:
		var percentageOfTime = (
			(1 - grappleCooldownTimer.get_time_left() / grappleCooldownTimer.get_wait_time()) * 100
		)
		grappleCooldownTexture.value = percentageOfTime
	if hoverTimer.get_time_left() > 0:
		var percentageOfTime = (
			(1 - hoverTimer.get_time_left() / hoverTimer.get_wait_time()) * 100
		)
		hoverTimerTexture.value = percentageOfTime
	if hoverCooldownTimer.get_time_left() > 0:
		var percentageOfTime = (
			(1 - hoverCooldownTimer.get_time_left() / hoverCooldownTimer.get_wait_time()) * 100
		)
		hoverTimerTexture.value = percentageOfTime
		
func unloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null
func loadLevel(levelName : String):
	unloadLevel()
	var levelPath := "res://Levels/%s.tscn" % levelName
	var levelResource := load(levelPath)
	if (levelResource):
		levelInstance = levelResource.instance()
		main2D.add_child(levelInstance)
	


func _on_Button_pressed():
	loadScene("StageOne")

	
func returnToMainMenu():
	unloadLevel()
	main2D.remove_child(levelInstance)
	healthBar.hide()
	chargeBar.hide()
	menu.show()
	$Menu/CanvasLayer/Pause._on_resume_pressed()
	
func deathScreen():
	loadLevel("GameOver")
	menu.hide()
	healthBar.hide()
	chargeBar.hide()
	
func show_grapple_cooldown():
	grappleCooldownTexture.show()

func _on_GrappleCooldownTimer_timeout():
	grappleCooldownTexture.hide()
	Global.hasGrapple = true
func loadScene(scene = Global.currentScene):
	loadLevel(scene)
	Global.currentScene = scene
	healthBar.show()
	chargeBar.show()
	Global.UpdateHealth(Global.maxLife[0], 0)
	Global.UpdateHealth(Global.maxLife[1], 1)
	Global.UpdateMaxHealth(Global.maxLife[0], 0)
	Global.UpdateMaxHealth(Global.maxLife[1], 1)
	menu.hide()
	if get_tree().paused:
		$Menu/CanvasLayer/Pause._on_resume_pressed()
		

func _on_save_pressed():
	Global.saveData(Global.SAVE_PATH)


func _on_load_pressed():
	Global.loadData(Global.SAVE_PATH)

func _start_hover_timer():
	if hoverTimer.is_stopped():
		hoverTimerTexture._set_under_tint("003f50")
		hoverTimerTexture._set_progress_tint("00c9ff")
		emit_signal("startHoverTimer")
		hoverTimerTexture.show()

func _on_MechHoverTimer_timeout():
	emit_signal("startHoverCooldown")
	hoverTimerTexture._set_under_tint("500031")
	hoverTimerTexture._set_progress_tint("8d0000")
	Global.isHovering = false
	Global.canHover = false


func _on_MechHoverCooldownTimer_timeout():
	hoverTimerTexture.hide()
	Global.canHover = true






