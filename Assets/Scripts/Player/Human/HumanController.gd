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
onready var invincibility_timer = $InvincibilityTimer
onready var grapple_cooldown_timer = $GrappleCooldownTimer
var landed := false
var velocity_previous: = Vector2.ZERO
var is_pulling = false
var is_linked := false
var launch_grapple_up := false
var launch_grapple_side := false
var pull_velocity := Vector2.ZERO
var can_activate_mech := false
var can_activate_small_block := false
var can_toggle_switch := false
var can_open_door := false
var is_push_pull_state := false
var interact_object = null
var mech = null
var debugging := true
var can_jump := true
var invincible := false



func _ready():	
	if Global.has_grapple: Global.can_grapple = true
	Global.player = self
	Global.mech = null	
	jump_buffer = $JumpBuffer
	floor_raycast = $Body/Raycasts/FloorRaycast

func unhandled_input(event):
	if event.is_action("move_right"):
		move_right = Input.get_action_strength("move_right")
	if event.is_action("move_left"):
		move_left = Input.get_action_strength("move_left")
	if event.is_action_pressed("jump") && can_jump:
		jump = true
	elif event.is_action_pressed("jump") && is_linked && !is_grounded:
		jump = true
		jump_impulse()
	if event.is_action_released("jump"):
		jump = false
	if event.is_action_pressed("ui_focus_next"):
		is_pulling = true
		if debugging:
			print("is_pulling")
	if event.is_action_released("ui_focus_next"):
		is_pulling = false
		if debugging:
			print("not_pulling")
	if event.is_action_pressed("w_interact"):
		if can_open_door:
			interact_object.activate()
		if can_activate_mech && Global.current_charge > 0:
			mech.activate = true
			can_activate_mech = false
			#remove human from scene
			queue_free()
	if event.is_action_pressed("interact"):
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
		elif can_activate_small_block && !is_push_pull_state:
			if debugging:
				print("GRAB BLOCK", interact_object)
			is_push_pull_state = true
			Global.can_grapple = false
			can_jump = false
		elif can_toggle_switch:
			interact_object.toggle = true

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse"):
			is_pulling = true
			if debugging:
				print("is_pulling")
		if event.is_action_released("right_mouse"):
			is_pulling = false
			if debugging:
				print("not_pulling")
		if event.is_action_released("left_mouse"):
			if !is_linked:
				if Global.has_grapple && Global.can_grapple:
					grapple.launch(get_global_mouse_position())
			else:
				grapple.release()
				Global.hud.grapple_cooldown_animation_player.play("GrappleCooldown",-1, (3/1)) #animation duration/ timer duration
				Global.can_grapple = false
				grapple_cooldown_timer.start()
	
func visual_process(delta):
	if abs(direction.x)>= 0.001:
		body.scale.x = sign(direction.x)
	velocity_previous = velocity
	
func damage(value)->void:
	if !invincible:
		invincible = true
		invincibility_timer.start()
		Global.current_health -= value
		print(Global.current_health)
		anim.play("Hurt")


func _on_InvincibilityTimer_timeout():
	invincible = false


func _on_hitbox_body_entered(body):
	print(body)
	if body is SpikeyVines:
		self.damage(10)


func _on_GrappleCooldownTimer_timeout():
	Global.can_grapple = true
