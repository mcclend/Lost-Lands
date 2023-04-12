extends ActivateArea

#override
func area_entered(area):
	if area is ActivationArea:
		if area.entity is Mech:
			root_node.mech = area.entity
			root_node.can_activate_mech = true
		

#override
func area_exited(area):
	if area is ActivationArea:
		if area.entity is Mech:
			root_node.can_activate_mech = false
