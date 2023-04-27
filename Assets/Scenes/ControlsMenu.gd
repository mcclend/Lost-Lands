extends Control


var active := false

func _input(event):
	if (event is InputEventKey || event is InputEventMouseButton) && !event.pressed && active:
		self.hide()
		active = false
		if get_tree().paused == false:
			$"../MainMenu".show()
		else:
			$"../Pause".show()
			$"../Pause".active = true
