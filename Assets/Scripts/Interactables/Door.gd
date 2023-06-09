extends ActivationArea
class_name Door


export (String) var next_level = null
export (String) var door_number = null
export var final_level = false
export var active = true
var _open = true

	
func activate():
	if _open:
		SoundManager.open_door()
		Global.load_door = door_number
		Global.emit_signal("next_level", next_level, door_number)
	if final_level:
		Global.emit_signal("victory")

func _physics_process(delta):
	if active:
		if !_open:
			$AnimationPlayer.play("Open")
			yield($AnimationPlayer, "animation_finished")
			_open = true
	else:
		if _open:
			$AnimationPlayer.play("Open", -1, -1, true)
			yield($AnimationPlayer, "animation_finished")
			_open = false

