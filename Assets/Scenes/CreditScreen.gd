extends Control


func _input(event):
	if (event is InputEventKey || event is InputEventMouseButton) && !event.pressed and self.visible:
		self.visible = false
		$"../MainMenu".show()
