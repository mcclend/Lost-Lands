extends Node2D
signal new_game()

var active := false

func _process(delta):
	if active:
		if Input.is_action_just_pressed("interact"):
			if $AnimatedSprite.frame < 7:
				$AnimatedSprite.frame = $AnimatedSprite.frame + 1
		elif Input.is_action_just_pressed("jump"):
			if $AnimatedSprite.frame == 7:
				active = false
				emit_signal("new_game")
