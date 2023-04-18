extends MovableObject
class_name PullablePlatform

export (float) var max_pull_dist = 200
export (float) var return_speed = -10
var _end_position : Vector2
var move_return := false
var start_position = null

onready var tween = $MoveTween



func _ready():
	add_to_group("CanBeGrappled")
	_can_move_left = false
	_can_move_right = false
	_velocity = Vector2.ZERO
	start_position = position
	_end_position = start_position + Vector2(0, max_pull_dist)
	use_gravity = false

func _physics_process(delta):
	
	if move_return or pull:
		if mass == 0: mass = 1.0
		var move_to = lerp(global_position,start_position,delta)
		if !pull:
			_velocity -= (move_to-global_position).normalized() * return_speed	
		else:
			_velocity += pull_velocity / mass
		_velocity.x = 0
		var collision = move_and_collide(_velocity * delta)
		if collision and collision.collider is Actor:
			collision.collider.set("velocity", collision.collider.get("velocity")+_velocity)
		global_position.x = start_position.x
		$Vines/RightVine.region_rect.size.y = abs(Vector2.ZERO.distance_to(global_position - start_position)+58)
		$Vines/LeftVine.region_rect.size.y = abs(Vector2.ZERO.distance_to(global_position - start_position)+58)
		if abs(Vector2.ZERO.distance_to(global_position - start_position)) < 1.0:
			move_return = false
		else: move_return = true
		_velocity *= FRICTION
	else:
		_velocity = Vector2.ZERO
		global_position = start_position
	

			
func _init_tween(force, _end_position):
	tween.stop_all()
	var duration = abs(Vector2.ZERO.distance_to(global_position - _end_position) / float(force))
	tween.interpolate_property(self, "position", position, _end_position, duration,Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0 )
	tween.start()

#override
func can_move(dir : Vector2)->bool:
	var _pulled_dist = abs(Vector2.ZERO.distance_to(global_position - start_position))
	if(_pulled_dist > max_pull_dist):
		return false
	return true
func _collision_check():
	pass

