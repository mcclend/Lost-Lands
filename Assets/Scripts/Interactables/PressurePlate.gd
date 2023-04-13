extends Trigger
class_name PressurePlate

onready var anim = $AnimationPlayer

func _ready():
	pass


func _on_ActivationArea_area_entered(area):
	if area is ActivateArea:
		pass


func _on_ActivationArea_area_exited(area):
	if area is ActivateArea:
		pass


func _on_ActivationArea_body_entered(body):
	if body is SmallMovableBlock:
		anim.play("Press")
		activate_entity = body
		active = true


func _on_ActivationArea_body_exited(body):
	if body is MovableObject:
		if body == activate_entity:
			anim.play_backwards("Press")
			activate_entity = null
			active = false
		pass
