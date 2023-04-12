extends Actor
class_name Human

onready var anim:AnimationPlayer = $AnimationPlayer
onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var sm: = $StateMachine
onready var walk_sprite = $Body/AnimationSprites/Walk
onready var idle_sprite = $Body/AnimationSprites/Idle
onready var launch_point = $Body/launchPoint
onready var grapple = $Grapple
var landed := false
var velocity_previous: = Vector2.ZERO
var is_pulling = false
var is_linked = false
var pull_velocity := Vector2.ZERO
var can_activate_mech = false
var mech = null

func _ready():
	jump_buffer = $JumpBuffer
	floor_raycast = $Body/Raycasts/FloorRaycast
func unhandled_input(event):
	if event.is_action("move_right"):
		move_right = Input.get_action_strength("move_right")
	elif event.is_action("move_left"):
		move_left = Input.get_action_strength("move_left")
	elif event.is_action_pressed("jump"):
		jump = true
	elif event.is_action_released("jump"):
		jump = false
	elif event.is_action_released("left_mouse"):
		grapple.launch(get_global_mouse_position())
	elif event.is_action_released("right_mouse"):
		grapple.release()
	elif event.is_action_pressed("ui_focus_next"):
		is_pulling = true
		print("is_pulling")
	elif event.is_action_released("ui_focus_next"):
		is_pulling = false
		print("not_pulling")
	elif event.is_action_pressed("interact"):
		if can_activate_mech:
			mech.active = true
			#remove human from scene
			queue_free()
		
func visual_process(delta):
	if abs(direction.x)>= 0.001:
		body.scale.x = sign(direction.x)
	velocity_previous = velocity

	

	
