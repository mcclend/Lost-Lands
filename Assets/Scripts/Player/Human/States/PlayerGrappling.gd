extends HumanState
class_name HumanGrappling

var _arm_length : float
var _angle
var _angular_velocity := 0.0
var _angular_acceleration := 0.0
var _link_point = null
var _pull_velocity := Vector2.ZERO
var _damping := 0.95
var _new_launch_position
var _grapple
var _move := Vector2.ZERO
onready var _launch_position

func _init(_sm).(_sm)->void:
	name = "Grappling"

func enter(_msg:Dictionary = {})->void:
	_grapple = player.grapple
	_link_point = _grapple.link_point
	_launch_position = player.launch_point.position
	_arm_length = Vector2.ZERO.distance_to(_launch_position -_link_point)
	_angle = -(_link_point-_launch_position).angle() - PI*0.5# - deg2rad(-90)
	_angular_velocity = 0.0
	_angular_acceleration = 0.0
	pass

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	_pull_velocity = player.pull_velocity
	_launch_position = player.launch_point.global_position #update launch position
	#_new_launch_position = _launch_position - (_pull_velocity*delta)
	_move += _pull_velocity
	_move.y += player.gravity * delta
	_move.y = max(_move.y, player.jump_impulse)
		
	#_arm_length = Vector2.ZERO.distance_to(_new_launch_position -_link_point)
	#_move += _process_velocity(delta)
	_move = player.move_and_slide(_move, Vector2.UP	)
	_move.x *= _damping
	state_check()

func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if player.is_grounded:
		sm.transition_to("Idle")

func _process_velocity(delta)->Vector2:
	_angular_acceleration = ((-player.gravity*delta) / _arm_length) *sin(_angle)	#Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
	_angular_velocity += _angular_acceleration *60 * delta				#Increment velocity
	_angular_velocity *= _damping *60 * delta								#Arbitrary damping
	_angle += _angular_velocity *60 * delta								#Increment angle
	
	_new_launch_position = _link_point + Vector2(_arm_length*sin(_angle), _arm_length*cos(_angle))
	return _new_launch_position - _launch_position


