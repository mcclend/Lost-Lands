extends RayCast2D

var isCasting := false setget set_is_casting
export var humanDamage = 1.0
export var mechDamage = 0.5
export var active = false


func _physics_process(delta):
	self.visible = !active # we want the turret to turn off when "activated" by a trigger
	if !active:
		if !$Laser_sound.playing:
			$Laser_sound.play()
		var castPoint := cast_to
		force_raycast_update()
		
		if is_colliding():
			castPoint = to_local(get_collision_point())
			if get_collider() is Human:
				Global.current_health -= humanDamage
			elif get_collider() is Mech:
				Global.current_charge -= mechDamage
			castPoint.x -= 5
		$Line2D.points[1] = castPoint
		castPoint.length() * 0.5
	else:
		if $Laser_sound.playing:
			$Laser_sound.stop()

func set_is_casting(cast : bool) -> void:
	isCasting = cast
	if isCasting:
		appear()
	else:
		disappear()
	set_physics_process(isCasting)
	
func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
	$Tween.start()
	
func disappear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.1)
	$Tween.start()
	
