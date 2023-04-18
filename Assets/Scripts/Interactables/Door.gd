extends ActivationArea
class_name Door

export (String) var next_level = null
export (String) var door_number = null
var activate = false

	
func activate():
	Global.emit_signal("next_level", next_level, door_number)

