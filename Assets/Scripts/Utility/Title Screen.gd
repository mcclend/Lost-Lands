extends Node2D

var active:= true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("intro")
	yield(get_node("AnimatedSprite"), "animation_finished")
	$AnimatedSprite.play("loop")
func _input(event):
	if event is InputEventKey and event.pressed and active:
		self.visible = false
		active = false
		$"../MainMenu".show()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
