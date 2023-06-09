extends HumanState
class_name HumanWalk

var sprite


func _init(_sm).(_sm)->void:
	name = "Walk"

func enter(_msg:Dictionary = {})->void:
	play_audio(preload("res://Assets/Audio Assets/Player/Human/walking.mp3"), true)
	
	

func exit()->void:
	player.audio.stop()
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	player.ground_physics_process(delta)
	if player.is_push_pull_state:
		if player.interact_object.can_move(player.direction*100):
			if player.anim.current_animation != "WalkPush":
				sprite = player.animation_sprites.find_node("WalkPush")
				set_sprite(sprite)
				player.anim.play("WalkPush")
			player.interact_object.global_position = player.push_pull_position.global_position
	elif player.anim.current_animation != "walk":
		sprite = player.animation_sprites.find_node("Walk")
		set_sprite(sprite)
		player.anim.play("Walk")
func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if Global.current_health <= 0:
		sm.transition_to("Die")
	if player.is_linked && player.is_pulling:
		sm.transition_to("Grappling")
	elif player.is_grounded:
		if abs(player.direction.x) < 0.01:
			sm.transition_to("Idle")
	else:
		sm.transition_to("Jump")

