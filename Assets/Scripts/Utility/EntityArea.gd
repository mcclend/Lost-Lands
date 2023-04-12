extends Area2D
class_name Entity

var entity

func get_local_scene_root(p_node : Node) -> Node:
	#gets the root node of the current object scene
	while(p_node and not p_node.filename):
		p_node = p_node.get_parent()

	return p_node as Node

func _ready():
	entity = get_local_scene_root(self)
