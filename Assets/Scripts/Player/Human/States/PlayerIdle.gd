extends HumanState
class_name HumanIdle

var sprite


func _init(_sm).(_sm)->void:					#inheriting script needs to call .(argument) from inherited scripts
	name = "Idle"

func enter(_msg:Dictionary = {})->void:			#Called by StateMachine when transition_to("State")
	sprite = player.animation_sprites.find_node("Idle")
	set_sprite(sprite)
	player.anim.play("Idle")					#call AnimationPlayer to play Idle animation

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)				#Player holds all global methods that is the same for most of the states

func physics_process(delta:float)->void:
	player.ground_physics_process(delta)
	if player.is_push_pull_state && player.anim.is_playing():
		player.anim.stop()
		sprite = player.animation_sprites.find_node("WalkPush")
		set_sprite(sprite)
	elif !player.is_push_pull_state && !player.anim.is_playing():
		sprite = player.animation_sprites.find_node("Idle")
		set_sprite(sprite)
		player.anim.play("Idle")
		
		pass
func process(delta:float)->void:
	player.visual_process(delta)				#Handle player turning + stretch and squash
	state_check()								#call check method if state need to be changed

func state_check()->void:
	if Global.current_health <= 0:
		sm.transition_to("Die")
	if player.is_linked && player.is_pulling:
		sm.transition_to("Grappling")
	elif player.launch_grapple_up || player.launch_grapple_side:
		sm.transition_to("LaunchGrapple")
	elif player.is_grounded:						#player has bool variable for reading if it is on ground
		if abs(player.direction.x) > 0.01:		#players movement is above treshold
			sm.transition_to("Walk")			#call StateMachine to change states
	else:
		sm.transition_to("Jump")


