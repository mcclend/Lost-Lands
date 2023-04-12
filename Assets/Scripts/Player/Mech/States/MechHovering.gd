extends MechState
class_name MechHovering


func _init(_sm).(_sm)->void:					#inheriting script needs to call .(argument) from inherited scripts
	name = "MechHovering"

func enter(_msg:Dictionary = {})->void:			#Called by StateMachine when transition_to("State")
	#player.anim.play("MechHover")					#call AnimationPlayer to play Idle animation
	pass
	

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)				#Player holds all global methods that is the same for most of the states

func physics_process(delta:float)->void:
	player.ground_physics_process(delta)

func process(delta:float)->void:
	player.visual_process(delta)				#Handle player turning + stretch and squash
	state_check()								#call check method if state need to be changed

func state_check()->void:
	if player.active == false:
		sm.transition_to("MechNotActive")
