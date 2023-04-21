extends Area2D
class_name ActivateArea
#this script is the generic for any activate areas 
#(areas that are on an entity to activate a seperate entity)
#should be connected to area_entered signal and area_exited signal


var root_node

func get_local_scene_root(p_node : Node) -> Node:
	#gets the root node of the current object scene
	while(p_node and not p_node.filename):
		p_node = p_node.get_parent()

	return p_node as Node

func _ready():
	root_node = get_local_scene_root(self)

