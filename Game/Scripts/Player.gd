extends RigidBody2D

const MIN_SHOTS_ON_FLOOR : int = 1
const WALK_ACCEL : float = 1000.0
const WALK_DEACCEL : float  = 50.0
const WALK_MAX_VELOCITY : float  = 700.0
const AIR_ACCEL : float  = 800.0
const AIR_DEACCEL : float  = 50.0
const JUMP_VELOCITY : float  = 600.0
const MAX_FLOOR_AIRBORNE_TIME : float  = 0.15
const BULLET_ACCEL  : float = 800.0
const COOLDOWN  : float = 0.5
const EYE_DISTANCE : float = 5.0

var shots_max : int = 1
var shots_remaining : int = shots_max

var aim_direction : Vector2
var opposite_aim_direction : Vector2
var airborne_time = 1e20
var in_cooldown : bool
var move_left : bool
var move_right : bool
var shoot : bool

var body_state
var step : float
var on_floor : bool
var linear_velocity_var : Vector2
var linear_velocity_previous : Vector2
var hit_ground : bool

onready var Cooldown : Timer = $Cooldown
onready var Sprite_var : Sprite = $Sprite
onready var Eye : Sprite = $Eye
var Bullet : Object = preload("res://Scenes/Bullet.tscn")

var test : bool

func _do_animations(delta) -> void:
	var scale_lerp : Vector2
	
	if shoot or not on_floor:
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
	
func get_shots_max() -> int:
	return shots_max
	
func get_shots_remaining() -> int:
	return shots_remaining

func _process(delta):
	_set_aim_direction()
	_set_cooldown()
	_do_animations(delta)
	_set_eye_position()
	
func _set_eye_position():
	Eye.global_position = self.global_position + (EYE_DISTANCE * aim_direction)

func _set_cooldown():
	in_cooldown = not Cooldown.is_stopped()
	
func _set_aim_direction():
	var aim_direction = (get_global_mouse_position() - self.global_position).normalized()
	self.aim_direction = aim_direction
	opposite_aim_direction = aim_direction * -1

func _integrate_forces(body_state):
	self.body_state = body_state
	_set_body_state()
	_get_input()
	_do_shoot()
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
	
func _do_shoot():
	if not shoot:
		return
	
	var bullet_m = Bullet.instance()
	var pos = self.position
	
	bullet_m.position = pos
	get_parent().add_child(bullet_m)

	bullet_m.linear_velocity = aim_direction * BULLET_ACCEL
#	add_collision_exception_with(bullet_m)

func _get_input():
	move_left = Input.is_action_pressed("move_left")
	move_right = Input.is_action_pressed("move_right")
	shoot = Input.is_action_pressed("shoot") and shots_remaining > 0 and not in_cooldown 
	
	if shoot:
		Cooldown.start(COOLDOWN)
		shots_remaining = shots_remaining - 1
	
func _find_floor():
	var found_floor = false
	var floor_index = -1

	for x in range(body_state.get_contact_count()):
		var contact_normal = body_state.get_contact_local_normal(x)
		if contact_normal.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x

	if found_floor:
		_replenish_min_shots()
		airborne_time = 0.0
	else:
		airborne_time += step

func _replenish_min_shots():
	if shots_remaining == 0 and linear_velocity_var.x == 0:
		shots_remaining = MIN_SHOTS_ON_FLOOR
			
func _move_floor():
	if on_floor:
		if move_left and not move_right:
			if linear_velocity_var.x > -WALK_MAX_VELOCITY:
				linear_velocity_var.x -= WALK_ACCEL * step
		elif move_right and not move_left:
			if linear_velocity_var.x < WALK_MAX_VELOCITY:
				linear_velocity_var.x += WALK_ACCEL * step
		else:
			var xv = abs(linear_velocity_var.x)
			xv -= WALK_DEACCEL * step
			if xv < 0:
				xv = 0
			linear_velocity_var.x = sign(linear_velocity_var.x) * xv
		linear_velocity_previous = linear_velocity_var
		
func _move_air():
	if shoot:
		linear_velocity_var.y = JUMP_VELOCITY * opposite_aim_direction.y
		linear_velocity_var.x = JUMP_VELOCITY * opposite_aim_direction.x
#		offset for buggy replenish system
		if abs(linear_velocity_var.x) < 100:
			linear_velocity_var.x = 100
		
	if not on_floor:
		if move_left and not move_right:
			if linear_velocity_var.x > -WALK_MAX_VELOCITY:
				linear_velocity_var.x -= AIR_ACCEL * step
		elif move_right and not move_left:
			if linear_velocity_var.x < WALK_MAX_VELOCITY:
				linear_velocity_var.x += AIR_ACCEL * step
		else:
			var linear_velocity_absolute = abs(linear_velocity_var.x)
			linear_velocity_absolute -= AIR_DEACCEL * step
			
			if linear_velocity_absolute < 0:
				linear_velocity_absolute = 0
			linear_velocity_var.x = sign(linear_velocity_var.x) * linear_velocity_absolute

func _shots_remaining_add():
	if shots_remaining == shots_max:
		return
	shots_remaining = shots_remaining + 1
	
func _shots_max_add():
	shots_max = shots_max + 1

func _on_Player_body_entered(body):
	if body.is_in_group('bullet') and shots_remaining < shots_max:
		_shots_remaining_add()
		body.queue_free()
		
	if body.is_in_group('pickup_slot'):
		_shots_max_add()
		body.queue_free()