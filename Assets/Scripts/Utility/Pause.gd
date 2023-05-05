extends Control

var active := false

func _input(event):
	if event.is_action_pressed("ui_cancel") && active:
		var pauseState = not get_tree().paused
		get_tree().paused = pauseState
		visible = pauseState
		if(pauseState):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_resume_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	visible = false


func _on_quit_pressed():
	get_tree().quit()
