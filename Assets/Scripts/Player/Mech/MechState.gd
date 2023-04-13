extends State
class_name MechState


var player: KinematicBody2D

func _init(_sm).(_sm)->void:	#inheriting script needs to call .(argument) from inherited scripts
	player = sm.owner			#to make easier referencing later  for player methods and nodes

func set_sprite(sprite):
	for i in player.animation_sprites.get_children():
		if i == sprite:i.visible = true
		else:i.visible = false
		
func play_audio(audio:AudioStream, immediate:bool = false, volume:float = -18):
	player.audio.volume_db = volume
	if player.audio.playing and !immediate:
		yield(player.audio, "finished")
	player.audio.stream = audio
	player.audio.play()
