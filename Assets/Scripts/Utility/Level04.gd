extends Node2D

onready var toggle_switch_01 := $Switches/ToggleSwitch
onready var toggle_switch_02 := $Switches/ToggleSwitch2
onready var toggle_switch_03 := $Switches/ToggleSwitch3
onready var toggle_switch_04 := $Switches/ToggleSwitch4
onready var timer := $LevelTimer


func _process(delta):
	Global.final_level_timer.text = str(timer.time_left).pad_decimals(2)
	if (toggle_switch_01.active 
		&& toggle_switch_02.active 
		&& toggle_switch_03.active 
		&& toggle_switch_04.active):
		
		#All 4 switches have been activated
		timer.stop()
		#Global.emit_signal("victory")



func _on_LevelTimer_timeout():
	Global.emit_signal("final_timer_timeout")

