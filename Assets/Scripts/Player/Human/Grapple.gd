extends RayCast2D
class_name Grapple

signal hookedToObject(object)

onready var line = $Line2D
onready var activate_area = $ActivateArea

var _pull_direction := Vector2.ZERO
var _pull_velocity := Vector2.ZERO
var _collision = null
onready var _parent := get_parent()
var _move_point : int = 0;
var attached_object = null


var _is_launching = false
var _target = null
var _offset = 5
var _cast_point := cast_to
var link_point = null
var _anchor

const _PULL_STRENGTH = 2000


func launch(target)->void:
	_target = target
	_parent.is_linked = false
	_is_launching = true
	cast_to = to_local(_target)
	line.points[0] = _parent.launch_point.position
	line.points[1] = _parent.launch_point.position
func release()->void:
	if(attached_object is MovableObject):
		attached_object.pull_velocity = Vector2.ZERO
		attached_object.pull = false
	attached_object = null
	self.enabled = false
	_is_launching = false
	_parent.is_linked = false
	_collision = null
	
func _process(_delta):
	self.enabled = _is_launching || _parent.is_linked
	activate_area.monitoring = _is_launching || _parent.is_linked
	line.visible = self.enabled
	if not self.enabled: 
		return
	
func _physics_process(_delta):
	
	force_raycast_update()
	_collision_check()
	
	line.points[0] = _parent.launch_point.position
	if _parent.is_linked:
		link_point = to_local(_anchor.global_position) #update link point
		_cast_point = link_point
		line.points[1] = link_point #update line
		activate_area.position = link_point
		cast_to = _cast_point
	_pull_direction = line.points[1]-line.points[0]
	_pull_velocity = _pull_direction.normalized() * _PULL_STRENGTH
	
	if _parent.is_linked:	
		if _parent.is_pulling:
			if attached_object is MovableObject:
				attached_object.pull = true
			if (attached_object is MovableObject) and attached_object.can_move(_pull_direction):
				print("can pull object")
				attached_object.pull_velocity = -_pull_velocity
				attached_object.pull = true
			elif (attached_object is MovableObject):
				print("can't pull object")
				release()
			else:
				_parent.pull_velocity = _pull_velocity
		else:
			_parent.pull_velocity = Vector2.ZERO
			if(attached_object is MovableObject):
				attached_object.pull_velocity = Vector2.ZERO
				attached_object.pull = false
func _collision_check():
	if is_colliding():
		if _is_launching and !_parent.is_linked:
			_is_launching = false
			attached_object = get_collider()
			if attached_object.is_in_group("CanBeGrappled"):
				_anchor = Node2D.new()
				attached_object.add_child(_anchor)
				_anchor.global_position = get_collision_point()
				if (rad2deg((_anchor.global_position-_parent.global_position).angle()) > 75) and (rad2deg((_anchor.global_position-_parent.global_position).angle()) < 105):
					_parent.launch_grapple_up = true
				else:
					_parent.launch_grapple_side = true
				link_point = to_local(_anchor.global_position)
				_parent.is_linked = true	
