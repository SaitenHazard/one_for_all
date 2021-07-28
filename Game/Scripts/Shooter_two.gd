extends Area2D

const EYE_DISTANCE : float = 12.0
const COOLDOWN : float = 4.0
const SPEED : float = 500.0

onready var Eye = $Eye
onready var Player = get_node("/root/MainScene/Player")
onready var Bullet : Object = preload("res://Scenes/Bullet_enemy.tscn")
onready var Utility = preload("res://Scripts/Utility.gd").new()
onready var BULLET : Object = preload("res://Scenes/Bullet_enemy.tscn")

onready var Sounds = get_node('/root/MainScene/Sounds')
onready var Enemy_count = get_node('/root/MainScene/Camera2D/CanvasLayer/Control/Enemies/Label')
onready var Camera2D = get_node('/root/MainScene/Camera2D')

var aim_direction

func _ready():
	set_process(true)
	_set_collision_layers()

func _set_collision_layers():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.ENEMY, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)

func _process(delta):
	_set_eye_position()

func _set_eye_position():
	var player_position = Player.get_global_position()
	aim_direction = player_position - self.get_global_position()
	aim_direction = aim_direction.normalized()
	Eye.global_position = self.global_position + (EYE_DISTANCE * aim_direction)

func _on_Timer_timeout():
	_do_shoot()

func _do_shoot():
	var bullet = Bullet.instance()
	bullet.position = self.get_global_position()
	get_tree().get_root().add_child(bullet)
	bullet.linear_velocity = SPEED * aim_direction

func _on_ShooterTwo_body_entered(body):
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.BULLET):
		_do_hit(body)
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.PLAYER):
		Player.do_hit(body)

func _do_hit(var body):
	Camera2D.shake()
	Enemy_count.substract_count()
	Sounds.get_node('hit').play()
	_do_hit_bullet(body)
	_do_flash()

func _do_hit_bullet(body):
	body.queue_free()
	var child = Utility.reparent(body.get_node('Particles2D'), get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 0.3)
	
func _do_flash():
	$Sprite.material.set_shader_param("flash_modifier", 1)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash_modifier", 0)
	$Particles2D.emitting = true
	var child = Utility.reparent($Particles2D, get_node("/root/MainScene"))
	Utility.delay_queue_free($Particles2D, 2)
	self.queue_free()
