extends RigidBody2D

const MIN_SHOTS_ON_FLOOR : int = 1
const WALK_ACCEL : float = 1500.0
const WALK_DEACCEL : float  = 50.0
const WALK_MAX_VELOCITY : float  = 700.0
const AIR_ACCEL : float  = 800.0
const AIR_DEACCEL : float  = 50.0
const JUMP_VELOCITY : float  = 600.0
const RECOIL_VERTICAL_VELOCITY : float  = 150.0
const RECOIL_HORIZONTAL_VELOCITY : float = 300.0
const MAX_FLOOR_AIRBORNE_TIME : float  = 0.15
const BULLET_ACCEL  : float = 800.0
const COOLDOWN  : float = 0.5
const REFILLCOOLDOWN  : float = 1.0
const EYE_DISTANCE : float = 5.0
const BULLET_SPAWN_DISTANCE : float = 5.0
const RECOIL_TIME : float = 2.5

export var shots_max : int = 1

var got_hit : bool = false
var in_recoil : bool = false
var shots_remaining : int = shots_max
var aim_direction : Vector2
var opposite_aim_direction : Vector2
var airborne_time = 1e20
var in_cooldown : bool
var do_refill : bool
var move_left : bool
var move_right : bool
var shoot : bool
var just_landed = false
var just_refill_soundeffect = false
var body_state
var step : float
var on_floor : bool
var linear_velocity_var : Vector2
var linear_velocity_previous : Vector2
var hit_ground : bool
var hit_right
var bool_do_reset : bool = false
var checkpoint_name : String = "Checkpoint"
var Bullet : Object = preload("res://Scenes/Bullet.tscn")
var Utility = preload("res://Scripts/Utility.gd").new()

onready var Cooldown : Timer = $Cooldown
onready var Sprite_var : Sprite = $Sprite
onready var Eye : Sprite = $Eye
onready var TimerRecoil = $TimerRecoil
onready var TimerRefill = $TimerRefill
onready var PArticles2D = $Particles2D

onready var Sounds = get_node('/root/MainScene/Sounds')
onready var Checkpoints = get_node('/root/MainScene/Checkpoints').get_children()

func set_checkpoint(name) -> void:
	checkpoint_name = name
	for x in Checkpoints.size():
		if not Checkpoints[x].name == checkpoint_name:
			Checkpoints[x].set_checkpoint_off()

func reset_to_checkpoint() -> void:
	bool_do_reset = true

func _ready() -> void:
	_set_player_vincible()
	
func _process(delta):
	_set_aim_direction()
	_set_cooldown()
	_do_animations(delta)
	_set_eye_position()

func _do_animations(delta) -> void:
	var scale_lerp : Vector2 = Vector2(0,0)
	
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

func get_aim_direction() -> Vector2:
	return aim_direction
	
func _set_eye_position():
	Eye.global_position = self.global_position + (EYE_DISTANCE * aim_direction)

func get_is_on_floor() -> bool:
	return on_floor

func _set_cooldown():
	in_cooldown = not Cooldown.is_stopped()
	
func _set_aim_direction():
	aim_direction = (get_global_mouse_position() - self.global_position).normalized()
	opposite_aim_direction = aim_direction * -1

func _integrate_forces(body_state):
	self.body_state = body_state
	_do_reset()
	_set_body_state()
	_get_input()
	_move_air()
	_move_floor()
	_move_recoil()
	_set_velocity()
	_find_floor()
	
func _do_reset() -> void: 
	if bool_do_reset:
		var teleprot_position = get_node('/root/MainScene/Checkpoints/' + checkpoint_name).get_global_position()
		transform = body_state.get_transform()
		transform.origin = teleprot_position
		body_state.set_transform(transform)
		bool_do_reset = false
	
func _move_recoil():
	if got_hit:
		if hit_right:
			linear_velocity_var.x = -RECOIL_HORIZONTAL_VELOCITY
		else:
			linear_velocity_var.x = RECOIL_HORIZONTAL_VELOCITY
			
		linear_velocity_var.y = -RECOIL_VERTICAL_VELOCITY
		got_hit = false

func _set_body_state():
	linear_velocity_var = body_state.get_linear_velocity()
	self.step = body_state.get_step()
	
func _set_velocity():
	on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	linear_velocity_var += body_state.get_total_gravity() * step
	body_state.set_linear_velocity(linear_velocity_var)
	
var just_shot = false
	
func _do_shoot():
	if just_shot:
		return
		
	just_shot = true
	Sounds.get_node('jump').play()
	var bullet_m = Bullet.instance()
	bullet_m.global_position = self.global_position + (EYE_DISTANCE * aim_direction)
	get_tree().get_root().add_child(bullet_m)
	bullet_m.linear_velocity = aim_direction * BULLET_ACCEL
	shots_remaining = shots_remaining - 1
	
	yield(get_tree().create_timer(0.25), "timeout")
	
	just_shot = false

func _get_input():
	if in_recoil and not on_floor:
		return
		
	move_left = Input.is_action_pressed("move_left")
	move_right = Input.is_action_pressed("move_right")
	
	shoot = Input.is_action_pressed("shoot") and shots_remaining > 0 and not in_cooldown
	
	if shoot:
		just_refill_soundeffect = false
		do_refill = false
		TimerRefill.start(REFILLCOOLDOWN)
		Cooldown.start(COOLDOWN)
		_do_shoot()
	
func _find_floor():
	var found_floor = false
	var floor_index = -1

	for x in range(body_state.get_contact_count()):
		var contact_normal = body_state.get_contact_local_normal(x)
		if contact_normal.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x

	if found_floor:
		_refill_shots()
		_sound_effect_just_landed()
		airborne_time = 0.0
		
	else:
		airborne_time += step
		just_landed = false

func _sound_effect_just_landed():
	if just_landed == false:
			just_landed = true
			Sounds.get_node('land').play()

func _sound_effect_just_refill():
	if just_refill_soundeffect == false:
		_do_refill_ani()
		just_refill_soundeffect = true
		Sounds.get_node('refill').play()

func _refill_shots():
	if do_refill == true:
		shots_remaining = shots_max
		_sound_effect_just_refill()

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
#		self.set_global_position(Vector2(1,1))
		linear_velocity_var.y = JUMP_VELOCITY * opposite_aim_direction.y
		linear_velocity_var.x = AIR_ACCEL * opposite_aim_direction.x
		
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

#func shots_remaining_add():
#	if shots_remaining == shots_max:
#		shots_remaining = shots_remaining + 1
	
func shots_max_add():
	shots_max = shots_max + 1

func _on_Player_body_entered(body):
#	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.PICKUP) and shots_remaining < shots_max:
#		if body.is_in_group('shots'):
#			shots_remaining_add()
#			body.queue_free()
#		elif body.is_in_group('slots'):
#			shots_max_add()
#		body.queue_free()
		
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.ENEMY):
		do_hit(body)
		
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.BULLET_ENEMY):
		do_hit(body)

func _on_TimerRecoil_timeout():
	in_recoil = false
	yield(get_tree().create_timer(0.5), "timeout")
	_set_player_vincible()

func _set_player_invincible() -> void:
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PLAYER, false)
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.INVINCIBLE, true)
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET_ENEMY, false)
	
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, false)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PICKUP, false)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.TELEPORT, false)
	
func _set_player_vincible() -> void:
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PLAYER, true)
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET_ENEMY, true)
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.INVINCIBLE, false)
	
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PICKUP, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.TELEPORT, true)

func _do_flash():
	$Sprite.material.set_shader_param("flash_color", Color(1,1,1,1))
	$Sprite.material.set_shader_param("flash_modifier", 1)
	yield(get_tree().create_timer(0.5), "timeout")
	reset_to_checkpoint()
	$Sprite.material.set_shader_param("flash_modifier", 0)
	_set_player_vincible()

func _do_refill_ani():
	$Sprite.material.set_shader_param("flash_color", Color(0.97,0.63,0.27,1))
	$Sprite.material.set_shader_param("flash_modifier", 1)
	yield(get_tree().create_timer(0.15), "timeout")
	$Sprite.material.set_shader_param("flash_modifier", 0)

#func _on_Teleporter_player_entered_teleporter(var teleport_to):
#	self.teleport_to = teleport_to
#	Sounds.get_node('teleport').play()
#	bool_do_teleport = true

func do_hit(var body : Node2D):
	_set_player_invincible()
	_do_flash()
	Sounds.get_node('hit').play()
	hit_right = self.position.x < body.position.x
	in_recoil = true
	got_hit = true
	TimerRecoil.start(RECOIL_TIME)

func _on_TimerRefill_timeout():
	do_refill = true
