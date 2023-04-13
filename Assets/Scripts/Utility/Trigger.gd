extends Node
class_name Trigger

export var active = false
export (NodePath) var connected_entity_path
var connected_entity = null #the object the trigger activates
var activate_entity = null #the object that has activated the trigger




func _ready():
	add_to_group("CanBeGrappled")
	if connected_entity_path:
		connected_entity = get_node(connected_entity_path)
		
func _physics_process(delta):
	if connected_entity:
		connected_entity.active = active



