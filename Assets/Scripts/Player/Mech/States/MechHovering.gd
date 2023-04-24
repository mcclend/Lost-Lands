extends MechState
class_name MechHovering

var local_velocity = Vector2.ZERO
var in_move_object_anim := false
const SPEED = 100


func _init(_sm).(_sm)->void:					#inheriting script needs to call .(argument) from inherited scripts
	#player.gravity = 0
	name = "MechHovering"

func enter(_msg:Dictionary = {})->void:			#Called by StateMachine when transition_to("State")
	yield(player.anim, "animation_finished")
	var sprite = player.animation_sprites.find_node("HoverSprite")
	play_audio(preload("res://Assets/Audio Assets/Mech/Hover.mp3"), true, -30)
	set_sprite(sprite)
	player.activate = false
	pass
	

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)				#Player holds all global methods that is the same for most of the states

func physics_process(delta:float)->void:
	player.ground_physics_process(delta)
	if player.move_object_1: #move object 1
		if !in_move_object_anim: #play grab object animation if it isn't already playing
			var sprite = player.animation_sprites.find_node("MoveObjectSprite")
			set_sprite(sprite)
			player.anim.play("MechHoldObject")
			in_move_object_anim = true
		#remove collision between mech and object
		player.interact_object_1.add_collision_exception_with(player)
		#large box uses position 3, otherwise use position 1
		if player.interact_object_1 is LargeMovableBlock:
			player.interact_object_1.global_position = player.interact_object_position_3.global_position
		else:
			player.interact_object_1.global_position = player.interact_object_position_1.global_position
	if player.move_object_2:
		player.interact_object_2.add_collision_exception_with(player)
		player.interact_object_2.global_position = player.interact_object_position_2.global_position
	if (in_move_object_anim && !player.move_object_1 && !player.move_object_2):
		player.anim.play("MechHoldObject", -1, -1, true)
		yield(player.anim, "animation_finished")
		player.anim.play("MechHover")
		in_move_object_anim = false
func process(delta:float)->void:
	player.visual_process(delta)				#Handle player turning + stretch and squash
	state_check()								#call check method if state need to be changed

func state_check()->void:
	if player.deactivate == true || Global.current_charge <= 0:
		if !player.deactivate: player.deactivate = true
		sm.transition_to("MechNotActive")
