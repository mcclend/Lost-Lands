extends HumanState
class_name HumanJump

var is_jumping := false
var sprite



func _init(_sm).(_sm)->void:
	name = "Jump"

func enter(_msg:Dictionary = {})->void:
	sprite = player.animation_sprites.find_node("Jump")
	set_sprite(sprite)
	pass

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	player.air_physics_process(delta)
		

func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if Global.current_health <= 0:
		sm.transition_to("Die")
	if player.velocity.y < 0 && !is_jumping:
		_do_jump()
	elif player.velocity.y >= 0 && !player.is_falling:
		player.is_falling = true
		is_jumping = false
		player.anim.play("fall")
	if player.is_linked && player.is_pulling:
		sm.transition_to("Grappling")
	elif player.is_grounded:
		_land()	
		if abs(player.direction.x) > 0.01:
			sm.transition_to("Walk")
		else:
			sm.transition_to("Idle")
			
func _do_jump():
	player.anim.play("jump")
	play_audio(preload("res://Assets/Audio Assets/Player/Human/Assets_Audio Assets_Player_Human_CharacterJumpFix.mp3"), true)
	is_jumping = true
	player.is_falling = false
	
func _land():
	play_audio(preload("res://Assets/Audio Assets/Player/Human/Assets_Audio Assets_Player_Human_CharacterLandFix.mp3"), true, -24)


