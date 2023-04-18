extends Actor
class_name Mech

onready var anim:AnimationPlayer = $AnimationPlayer
onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var sm: = $StateMachine
onready var animation_sprites = $Body/Animations
onready var activation_sprite = $Body/Animations/ActivationSprite
onready var hover_sprite = $Body/Animations/HoverSprite
onready var move_object_sprite = $Body/Animations/MoveObjectSprite
onready var run_timer = $Timers/RunTimer
onready var run_cooldown = $Timers/RunCooldown
onready var run_flames = $Body/RunFlames
onready var player_spawn_position = $Body/Positions/PlayerSpawnPosition
onready var interact_object_position_1 = $Body/Positions/InteractObjectPosition_1
onready var interact_object_position_2 = $Body/Positions/InteractObjectPosition_2
onready var interact_object_position_3 = $Body/Positions/InteractObjectPosition_3
onready var camera = $Camera2D


var active := false
var activate := false
var deactivate := false
var ready := false
var velocity_previous: = Vector2.ZERO
var can_run := true
var running := false
var root = null
var current_scene = null
var interact_object_1 = null
var interact_object_2 = null
var can_activate_small_block_1 := false
var can_activate_small_block_2 := false
var can_activate_large_block := false
var move_object_1 := false
var move_object_2 := false


func _ready():
	Global.mech = self
	Global.player = null
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	jump_buffer = $Timers/RunTimer
	floor_raycast = $Body/Raycasts/FloorRaycast
	
func unhandled_input(event):
	if active == false:
		return
	if event.is_action("move_right"):
		move_right = Input.get_action_strength("move_right")
	elif event.is_action("move_left"):
		move_left = Input.get_action_strength("move_left")
	elif event.is_action_pressed("run"):
		if can_run:
			run_flames.visible = true
			running = true
			speed *= 10;
			gravity = 0
			run_timer.start()
	elif event.is_action_released("run"):
		if not run_timer.is_stopped():
			run_timer.stop()
			_on_RunTimer_timeout()
	elif event.is_action_pressed("interact"):
		if can_activate_small_block_1:
			move_object_1 = true
			can_activate_small_block_1 = false
		elif can_activate_small_block_2:
			move_object_2 = true
			can_activate_small_block_2 = false
		elif can_activate_large_block:
			move_object_1 = true
			can_activate_large_block = false
		elif move_object_2: #drop object 2
			move_object_2 = false
			interact_object_2 = null
		elif move_object_1: #drop object 1
			move_object_1 = false
			interact_object_1 = null
			
	elif event.is_action_released("w_interact"):
		#deactivate
		deactivate = true
	

func visual_process(delta):
	if abs(direction.x)>= 0.001:
		body.scale.x = sign(direction.x) * abs(body.scale.x)
	velocity_previous = velocity
	

func _on_RunTimer_timeout():
	if running:
		run_flames.visible = false
		gravity = Global.GRAVITY
		speed *= 0.1;
		can_run = false
		running = false
		run_cooldown.start()

func _on_RunCooldown_timeout():
	can_run = true

