extends Actor
class_name Human

onready var anim:AnimationPlayer = $AnimationPlayer
onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var sm: = $StateMachine
onready var animation_sprites = $Body/AnimationSprites
onready var launch_point = $Body/launchPoint
onready var push_pull_position = $Body/PushPullPosition
onready var grapple = $Grapple
onready var camera = $Camera2D
var landed := false
var velocity_previous: = Vector2.ZERO
var is_pulling = false
var is_linked = false
var launch_grapple_up := false
var launch_grapple_side := false
var pull_velocity := Vector2.ZERO
var can_activate_mech = false
var can_activate_small_block = false
var can_toggle_switch = false
var is_push_pull_state = false
var interact_object = null
var mech = null
var debugging = true
var can_jump = true


func _ready():	
	jump_buffer = $JumpBuffer
	floor_raycast = $Body/Raycasts/FloorRaycast
	
func unhandled_input(event):
	if event.is_action("move_right"):
		move_right = Input.get_action_strength("move_right")
	elif event.is_action("move_left"):
		move_left = Input.get_action_strength("move_left")
	elif event.is_action_pressed("jump") && can_jump:
		jump = true
	elif event.is_action_released("jump"):
		jump = false
	elif event.is_action_released("left_mouse"):
		if Global.has_grapple && Global.can_grapple:
			grapple.launch(get_global_mouse_position())
	elif event.is_action_released("right_mouse"):
		grapple.release()
	elif event.is_action_pressed("ui_focus_next"):
		is_pulling = true
		if debugging:
			print("is_pulling")
	elif event.is_action_released("ui_focus_next"):
		is_pulling = false
		if debugging:
			print("not_pulling")
	elif event.is_action_pressed("w_interact"):
		if can_activate_mech:
			mech.activate = true
			can_activate_mech = false
			#remove human from scene
			queue_free()
	elif event.is_action_pressed("interact"):
		if is_push_pull_state:
			if debugging:
				print("RELEASE BLOCK")
			is_push_pull_state = false
			can_jump = true
			interact_object.remove_collision_exception_with(self)
			interact_object.pull_velocity = Vector2.ZERO
			interact_object.pull = false
			if Global.has_grapple:
				Global.can_grapple = true
		elif can_activate_small_block:
			if debugging:
				print("GRAB BLOCK", interact_object)
			is_push_pull_state = true
			can_activate_small_block = false
			Global.can_grapple = false
			can_jump = false
		elif can_toggle_switch:
			interact_object.toggle = true
		
func visual_process(delta):
	if abs(direction.x)>= 0.001:
		body.scale.x = sign(direction.x)
	velocity_previous = velocity


