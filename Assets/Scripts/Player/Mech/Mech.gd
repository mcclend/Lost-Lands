extends Actor
class_name Mech

onready var anim:AnimationPlayer = $AnimationPlayer
onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var sm: = $StateMachine
onready var activation_sprite = $Body/ActivationSprite
onready var hover_sprite = $Body/HoverSprite
onready var run_timer = $Timers/RunTimer
onready var run_cooldown = $Timers/RunCooldown
onready var run_flames = $Body/RunFlames
onready var player_spawn_position = $Body/PlayerSpawnPosition

var active := false
var ready := false
var velocity_previous: = Vector2.ZERO
var can_run := true
var running := false
var root = null
var current_scene = null


func _ready():
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	jump_buffer = $Timers/RunTimer
	floor_raycast = $Body/Raycasts/FloorRaycast
func unhandled_input(event):
	if !active:
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
			
	elif event.is_action_released("ui_accept"):
		#deactivate
		active = false
	

func visual_process(delta):
	if abs(direction.x)>= 0.001:
		body.scale.x = sign(direction.x) * abs(body.scale.x)
	velocity_previous = velocity
	
func activate():
	pass


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

