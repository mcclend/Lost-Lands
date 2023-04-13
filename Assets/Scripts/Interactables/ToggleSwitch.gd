extends Trigger
class_name ToggleSwitch

onready var anim = $AnimationPlayer

var toggle = false


func _physics_process(delta):
	if toggle:
		toggle = false
		if active:
			active = false
			anim.play("Deactivate")
		else:
			active = true
			anim.play("Activate")

	

