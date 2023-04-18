extends KinematicBody2D
class_name MovableObject

var _can_move_right := true
var _can_move_left := true
var _can_move_up := true
var _can_move_down := true
var _is_linked := false
var _velocity := Vector2.ZERO

var pull_velocity := Vector2.ZERO
var pull := false


export var debugging := true
export var use_gravity := true
export var mass := 1.0

export (Array, NodePath) var left_rays:Array
export (Array, NodePath) var right_rays:Array
export (Array, NodePath) var top_rays:Array
export (Array, NodePath) var bottom_rays:Array

const FRICTION = 0.9
const MOVE_THRESHOLD = 1


func set_velocity(velocity):
	_velocity = velocity	
func _physics_process(_delta):
	if use_gravity:
		_velocity.y += 10
	if mass == 0: mass = 1.0
	_velocity += pull_velocity / mass
	if !_can_move_down || !_can_move_left || !_can_move_right || !_can_move_up:
		_velocity *= FRICTION
	_collision_check()
	_velocity = move_and_slide(_velocity, Vector2.UP)

func can_move(dir : Vector2)->bool:
	#Takes a direction vector and checks if this object can move in that direction
	#The purpose of this function is to tell the grappling hook whether or not it should apply velocity to this object
	var horizontal := false
	var vertical := false
	#if we cannot move in the x direction we are trying to, set horizontal to false
	if dir.x > MOVE_THRESHOLD and _can_move_right: horizontal = true
	elif dir.x < -MOVE_THRESHOLD and _can_move_left: horizontal = true
	#if we cannot move in the y direction we are trying to, set vertical to false
	if dir.y > MOVE_THRESHOLD and _can_move_down: vertical = true
	elif dir.y < -MOVE_THRESHOLD and _can_move_up: vertical = true
	#if we can move in either of the directions we are trying to move, return true
	print("Horizontal = ", horizontal)
	print("Vertical = ", vertical)
	return(horizontal || vertical)
		
	
func _collision_check():
	#Checks given Top,Bottom,Left, and Right raycasts
	#If a raycast is colliding, eliminates velocity in that direction
	_can_move_right = true
	_can_move_left = true
	_can_move_up = true
	_can_move_down = true
	for ray in left_rays:
		if get_node(ray).is_colliding():
			_can_move_left = false
			_velocity.x = max(0, _velocity.x)
			if debugging: print(self.to_string() + " Cannot move left")
	for ray in right_rays:
		if get_node(ray).is_colliding():
			_can_move_right = false
			_velocity.x = min(0, _velocity.x)
			if debugging: print(self.to_string() + " Cannot move right")
	for ray in top_rays:
		if get_node(ray).is_colliding():
			_can_move_up = false
			_velocity.y = max(0, _velocity.y)
			if debugging: print(self.to_string() + " Cannot move up")
	for ray in bottom_rays:
		if get_node(ray).is_colliding():
			_can_move_down = false
			_velocity.y = min(0, _velocity.y)
			if debugging: print(self.to_string() + " Cannot move down")
