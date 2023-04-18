extends ActivateArea

#override
func area_entered(area):
	if !root_node.is_push_pull_state && !root_node.interact_object:
		if area is ActivationArea:
			if area.entity is Mech:
				root_node.mech = area.entity
				root_node.can_activate_mech = true
			elif area.entity is ToggleSwitch:
				root_node.can_toggle_switch = true
				root_node.interact_object = area.entity
		if area is Door:
			root_node.can_open_door = true
			root_node.interact_object = area.entity
		

#override
func area_exited(area):
	if area is ActivationArea:
		if area.entity is Mech:
			root_node.can_activate_mech = false
		elif area.entity is ToggleSwitch:
			root_node.can_toggle_switch = false
			root_node.interact_object = null
	if area is Door:
		if area.entity == root_node.interact_object:
			root_node.can_open_door = false
			root_node.interact_object = null


func _on_InteractArea_body_entered(body):
	if body is SmallMovableBlock:
		if !root_node.interact_object:
			root_node.interact_object = body
			root_node.can_activate_small_block = true


func _on_InteractArea_body_exited(body):
	if body == root_node.interact_object && !root_node.is_push_pull_state:
		root_node.interact_object = null
		root_node.can_activate_small_block = false
