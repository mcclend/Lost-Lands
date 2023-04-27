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
	var sprite = player.animation_sprites.find_node("GrappleFlySideways")
	set_sprite(sprite)
	player.anim.play("GrappleFlySideways")
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
	player.ground_update_logic()
	state_check()
	_pull_velocity = player.pull_velocity
	player.velocity += _pull_velocity*delta
	player.air_physics_process(delta)
	player.velocity.x *= _damping
	
	

func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if Global.current_health <= 0:
		sm.transition_to("Die")
	if !player.is_pulling:
		if player.is_grounded:
			if abs(player.direction.x) > 0.01:		#players movement is above treshold
				sm.transition_to("Walk")
			else:
				sm.transition_to("Idle")
		else:
			sm.transition_to("Jump")
	if player.jump:
		_grapple.release()
		sm.transition_to("Jump")


