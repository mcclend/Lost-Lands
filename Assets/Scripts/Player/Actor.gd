extends KinematicBody2D
class_name Actor

export (float) var speed:               = 1.0 * 60.0
export (float) var acceleration:	= 300.0
export (float) var air_acceleration:	= 100.0
export (float) var max_jump_height = 48*2.2
export (float) var min_jump_height = 48*0.4
export (float) var time_to_jump_apex = 0.5

var floor_raycast
var floor_velocity
var move_right:		= 0.0
var move_left:		= 0.0
var direction:		= Vector2.ZERO
var velocity:		= Vector2.ZERO
var jump:           = false
var is_jumping:		= false
var is_grounded:	= false	
const SNAP: 		= Vector2.DOWN * 1
var snap:           = Vector2.ZERO
var gravity 	= Global.GRAVITY
var is_falling = false
var max_jump_impulse
var min_jump_impulse


var max_jump:int	= 1
var jump_count:int	= 0

onready var body: = $Body						#Parent node for Sprite and RayCast2D
onready var jump_buffer:Timer

func _ready():
	gravity = 2*max_jump_height / pow(time_to_jump_apex, 2)
	max_jump_impulse = -sqrt(2*gravity*max_jump_height)
	min_jump_impulse = -sqrt(2*gravity*min_jump_height)


func direction_logic()->void:
	direction.x = move_right - move_left


func velocity_logic(delta:float)->void:
	velocity = velocity.move_toward(Vector2(direction.x * speed, velocity.y), acceleration * delta)

func air_velocity_logic(delta:float)->void:
	velocity = velocity.move_toward(Vector2(direction.x * speed, velocity.y), air_acceleration * delta)

func gravity_logic(delta:float)->void:
	if is_grounded:
		if is_jumping:								#landed the jump
			jump = false							#force release jump button
			is_jumping = false
			snap = SNAP
		elif !is_jumping && jump:					#works also when re-pressed before ground for jump buffer (pre-landing)
			jump_impulse()
	else:
		if is_jumping:
			if !jump:								#released jump button mid-air
				is_jumping = false
				if velocity.y < min_jump_impulse:
					velocity.y = min_jump_impulse
		else:
			if jump:
				if !jump_buffer.is_stopped():
					jump_impulse()
				
	velocity.y += gravity * delta
	#velocity.y = max(velocity.y, jump_impulse)	#Limit fall speed to same as Jumping, but allow get faster to go up

func ground_gravity_logic(delta:float)->void:
	if is_grounded:
		if is_jumping:								#landed the jump
			jump = false							#force release jump button
			is_jumping = false
			snap = SNAP
		elif !is_jumping && jump:					#works also when re-pressed before ground for jump buffer (pre-landing)
			jump_impulse()
	velocity.y += gravity * delta
	#velocity.y = max(velocity.y, jump_impulse)

func air_gravity_logic(delta:float)->void:
	if is_jumping:
		if !jump:								#released jump button mid-air
			is_jumping = false
			if velocity.y < min_jump_impulse:
				velocity.y = min_jump_impulse
	elif jump && !jump_buffer.is_stopped():
		jump_impulse()
	elif jump_count < max_jump:
		jump_count += 1
		jump_impulse()
	velocity.y += gravity * delta
	velocity.y = max(velocity.y, max_jump_impulse)

func collision_logic()->void:
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true)

func ground_update_logic()->void:
	floor_raycast.force_raycast_update()
	var temp_grounded:bool = floor_raycast.is_colliding()
	if is_grounded && !temp_grounded:					#just lost ground
		snap = Vector2.ZERO
		if !jump:
			jump_buffer.start()
	elif !is_grounded && temp_grounded:					#just landed
		snap = SNAP
		jump_count = 0									#resets double jump count
		land()
	
	is_grounded = temp_grounded

func physics_process(delta:float)->void:
	direction_logic()
	velocity_logic(delta)
	gravity_logic(delta)
	collision_logic()
	ground_update_logic()

func ground_physics_process(delta:float)->void:
	direction_logic()
	velocity_logic(delta)
	gravity_logic(delta)
	collision_logic()
	ground_update_logic()

func air_physics_process(delta:float)->void:
	direction_logic()
	air_velocity_logic(delta)
	gravity_logic(delta)
	collision_logic()
	ground_update_logic()

func process(_delta:float)->void:
	if abs(direction.x)>= 0.001:
		body.scale.x = direction.x

func jump_impulse()->void:
	jump_buffer.stop()
	velocity.y = max_jump_impulse
	is_jumping = true
	is_grounded = false
	snap = Vector2.ZERO
	jumping()
	

func damage(value)->void:
	pass

func jumping()->void:
	pass

func land()->void:
	pass




















