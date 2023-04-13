extends ActivateArea




func _on_ActivateArea_area_entered(area):
	pass # Replace with function body.


func _on_ActivateArea_area_exited(area):
	pass # Replace with function body.


func _on_ActivateArea_body_entered(body):
	if body is SmallMovableBlock:
		if !root_node.interact_object_1 && body != root_node.interact_object_2:
			root_node.interact_object_1 = body
			root_node.can_activate_small_block_1 = true
		elif !root_node.interact_object_2 && body != root_node.interact_object_1:
			root_node.interact_object_2 = body
			root_node.can_activate_small_block_2 = true
	if body is LargeMovableBlock:
		if !root_node.interact_object_1 && !root_node.interact_object_2:
			root_node.interact_object_1 = body
			root_node.can_activate_large_block = true


func _on_ActivateArea_body_exited(body):
	if body is SmallMovableBlock:
		if body == root_node.interact_object_1 && !root_node.move_object_1:
			root_node.interact_object_1 = null
			root_node.can_activate_small_block_1 = false
		elif body == root_node.interact_object_2 && !root_node.move_object_2:
			root_node.interact_object_2 = null
			root_node.can_activate_small_block_2 = false
		if body is LargeMovableBlock:
			if !root_node.move_object_1:
				root_node.interact_object_1 = null
				root_node.can_activate_large_block = false
			
