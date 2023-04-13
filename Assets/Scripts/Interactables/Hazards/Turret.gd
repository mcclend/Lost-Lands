extends StaticBody2D

signal startTimer()

export var rotateSpeed := 90.0
onready var ray = $pointer/LazerBeam
onready var pointer = $pointer
onready var shotPosition = $pointer/Position2D
onready var shotTimer = $shotTimer
onready var animationPlayer = $AnimationPlayer
onready var searchSprite = $SearchingSprite
onready var alertSprite = $AlertSprite
onready var turretShot = preload("res://prefab/TurretShot.tscn")
var canShoot = true

func _ready():
	animationPlayer.play("TurretSearch")

func _process(delta):
	#pointer.rotation_degrees += rotateSpeed * delta
	if ray.is_colliding():
		if ray.get_collider().is_in_group("Player"):
			if canShoot:
				if animationPlayer.current_animation != "TurretAlert":
					animationPlayer.play("TurretAlert")
					alertSprite.show()
					searchSprite.hide()
		elif animationPlayer.current_animation == "TurretAlert":
			animationPlayer.play("TurretSearch")
			alertSprite.hide()
			searchSprite.show()
	
	
func shoot():
	var temp = turretShot.instance()
	add_child(temp)
	temp.global_position = shotPosition.global_position
	temp.rotation_degrees = ray.rotation_degrees
	temp._set_direction(-1)
	canShoot = false
	emit_signal("startTimer")
	



func _on_shotTimer_timeout():
	canShoot = true
