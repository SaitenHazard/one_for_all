extends RigidBody2D

const WALK_VELOCITY : float  = 200.0
const AIR_VELOCITY : float  = 150.0
const AIR_DEACCEL : float  = 800.0
const JUMP_VELOCITY : float  = 200.0
const MAX_FLOOR_AIRBORNE_TIME : float  = 0.15
const BULLET_ACCEL  : float = 800.0
const COOLDOWN_TIME  : float = 0.55
const BULLET_SPEED : float = 500.0

var airborne_time = 1e20
var body_state
var step : float
var on_floor : bool
var linear_velocity_var : Vector2
var linear_velocity_previous : Vector2
var hit_ground : bool
var dead : bool = false
var lives : int = 1
var jump : bool = false
var got_hit : bool = false
var hit_right : int = 0
var shoot_position : Vector2

export var walk_direction : float = 1.0

onready var Cooldown : Timer = $Cooldown
onready var DeatTimer : Timer = $DeathTimer
onready var Sprite_var : Sprite = $Sprite
onready var RayCast2DLeft : RayCast2D = $RayCast2DLeft
onready var RayCast2DRight : RayCast2D = $RayCast2DRight
onready var Sounds = get_node('/root/MainScene/Sounds')
onready var Enemy_count = get_node('/root/MainScene/Camera2D/CanvasLayer/Control/Enemies/Label')
onready var BULLET : Object = preload("res://Scenes/Bullet_enemy.tscn")
onready var Position2DShooter : Position2D = $Position2DBullet
onready var Position2DShooter2 : Position2D = $Position2DBullet2

var Utility = preload("res://Scripts/Utility.gd").new()
var test : bool

var shoot_direction : Vector2

func _set_bullet_direction():
	shoot_direction = (shoot_position - self.get_global_position()).normalized()
	shoot_direction = shoot_direction.normalized()
	shoot_direction.x = round(shoot_direction.x)
	shoot_direction.y = round(shoot_direction.y)
	
func _set_bullet_position():
	if not Sprite_var.flip_h:
		shoot_position = Position2DShooter.get_global_position()
	else:
		shoot_position = Position2DShooter2.get_global_position()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.ENEMY, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)
	
	Utility.set_collision_mask(RayCast2DLeft, Enums.COLLISION_LAYER.TILE, true)
	Utility.set_collision_mask(RayCast2DRight, Enums.COLLISION_LAYER.TILE, true)

func _process(delta):
	_do_animations(delta)
	_set_bullet_position()
	_set_bullet_direction()
	
#func _do_death():
#	if got_hit == false and lives == 0 and on_floor == true and jump == false:
#		self.queue_free()

func _do_animations(delta) -> void:
	var scale_lerp : Vector2

	if walk_direction > 0:
		Sprite_var.flip_h = true
	else:
		Sprite_var.flip_h = false
	
	if not on_floor or got_hit:
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

	if got_hit:
		if hit_right:
			linear_velocity_var.x = -WALK_VELOCITY
		else:
			linear_velocity_var.x = WALK_VELOCITY
		
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
		
		if body_state.get_contact_collider_object(x).get_collision_layer_bit(Enums.COLLISION_LAYER.TILE):
			if contact_normal.x > 0.9:
				walk_direction = 1.0
			elif contact_normal.x < -0.9:
				walk_direction = -1.0

	if not got_hit:
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
		if jump:
			linear_velocity_var.y = -JUMP_VELOCITY
			jump = false
		
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
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.BULLET):
		_do_hit(body)

func _do_hit(var body):
	Enemy_count.substract_count()
	Sounds.get_node('hit').play()
	jump = true
	got_hit = true
	Cooldown.start(COOLDOWN_TIME)
	hit_right = self.position.x < body.position.x
	_do_hit_bullet(body)
	_do_flash()
#	lives = lives - 1
#
#	if lives == 0:
#		$DeathTimer.start()
	
func _do_flash():
	$Sprite.material.set_shader_param("flash_modifier", 1)
	yield(get_tree().create_timer(0.5), "timeout")
	self.queue_free()
#	yield(get_tree().create_timer(0.1), "timeout")
#	$Sprite.material.set_shader_param("flash_modifier", 0)

func _do_hit_bullet(body):
	body.queue_free()
	var child = Utility.reparent(body.get_node('Particles2D'), get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 0.3)

func _on_Cooldown_timeout():
	got_hit = false

func _on_DeathTimer_timeout():
	self.queue_free()

func _on_Timer_timeout():
	_do_shoot()
	
func _do_shoot():
	var bullet = BULLET.instance()
	bullet.position = shoot_position
	get_tree().get_root().add_child(bullet)
	bullet.linear_velocity = BULLET_SPEED * shoot_direction
