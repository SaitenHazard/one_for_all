extends RigidBody2D

const WALK_VELOCITY : float  = 200.0
const AIR_VELOCITY : float  = 150.0
const AIR_DEACCEL : float  = 800.0
const JUMP_VELOCITY : float  = 600.0
const MAX_FLOOR_AIRBORNE_TIME : float  = 0.15
const BULLET_ACCEL  : float = 800.0

var airborne_time = 1e20
var body_state
var step : float
var on_floor : bool
var linear_velocity_var : Vector2
var linear_velocity_previous : Vector2
var hit_ground : bool
var walk_direction : float = 1.0

onready var Cooldown : Timer = $Cooldown
onready var Sprite_var : Sprite = $Sprite
onready var RayCast2DLeft : RayCast2D = $RayCast2DLeft
onready var RayCast2DRight : RayCast2D = $RayCast2DRight

var test : bool

func _process(delta):
	_do_animations(delta)

func _do_animations(delta) -> void:
	var scale_lerp : Vector2
	
	if walk_direction > 0:
		Sprite_var.flip_h = true
	else:
		Sprite_var.flip_h = false
	
	if not on_floor:
		hit_ground = false

		scale_lerp.x = range_lerp(abs(linear_velocity_var.y), 0, abs(JUMP_VELOCITY), 1.25, 0.75)
		scale_lerp.y = range_lerp(abs(linear_velocity_var.y), 0, abs(JUMP_VELOCITY), 0.75, 1.75)

		Sprite_var.scale.y = clamp(scale_lerp.y, 0.5, 1.5)
		Sprite_var.scale.x = clamp(scale_lerp.x, 0.75, 1.5)

	if not hit_ground and on_floor:
		hit_ground = true
		Sprite_var.scale.x = range_lerp(abs(linear_velocity_previous.x), 0, abs(JUMP_VELOCITY), 1.2, 2.0)
		Sprite_var.scale.y = range_lerp(abs(linear_velocity_previous.y), 0, abs(JUMP_VELOCITY), 0.8, 0.3)

	Sprite_var.scale.x = lerp(Sprite_var.scale.x, 1, 1-pow(0.01, delta))
	Sprite_var.scale.y = lerp(Sprite_var.scale.y, 1, 1-pow(0.01, delta))

func _integrate_forces(body_state):
	self.body_state = body_state
	_set_body_state()
	_move_air()
	_move_floor()
	_set_velocity()
	_find_floor()

func _set_body_state():
	linear_velocity_var = body_state.get_linear_velocity()
	self.step = body_state.get_step()
	
func _set_velocity():
	on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	linear_velocity_var += body_state.get_total_gravity() * step
	body_state.set_linear_velocity(linear_velocity_var)

func _find_floor():
	var found_floor = false
	var floor_index = -1

	for x in range(body_state.get_contact_count()):
		var contact_normal = body_state.get_contact_local_normal(x)
		
		if contact_normal.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
			
		if contact_normal.x > 0.9:
			walk_direction = 1.0
		elif contact_normal.x < -0.9:
			walk_direction = -1.0

	if not RayCast2DRight.is_colliding() and RayCast2DLeft.is_colliding():
		walk_direction = -1.0
		
	if RayCast2DRight.is_colliding() and not RayCast2DLeft.is_colliding():
		walk_direction = 1.0

	if found_floor:
		airborne_time = 0.0
	else:
		airborne_time += step

func _move_floor():
	if on_floor:
		linear_velocity_var.x = WALK_VELOCITY * walk_direction
			
		linear_velocity_previous = linear_velocity_var
		
func _move_air():
	if not on_floor:
		linear_velocity_var.x = 0
		
		if walk_direction < 0:
			linear_velocity_var.x = -AIR_VELOCITY
		else:
			linear_velocity_var.x = AIR_VELOCITY

func _on_Enemy2_body_entered(body):
	if body.is_in_group('bullet'):
		var Utility = preload("res://Scripts/Utility.gd").new()
		body.queue_free()
		var child = Utility.reparent(body.get_node('Particles2D'), get_node("/root/MainScene"))
		Utility.delay_queue_free(child, 0.3)
