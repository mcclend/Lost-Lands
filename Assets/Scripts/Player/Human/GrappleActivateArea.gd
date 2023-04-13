extends ActivateArea


func _ready():
	pass # Replace with function body.



func _on_ActivateArea_area_entered(area):
	if area is ActivationArea:
		if area.entity is ToggleSwitch:
			area.entity.toggle = true
