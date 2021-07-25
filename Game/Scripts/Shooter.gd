extends Area2D

onready var Position2DShooter : Position2D = $Position2DBullet
onready var BULLET : Object = preload("res://Scenes/Bullet_enemy.tscn")
onready var Utility = preload("res://Scripts/Utility.gd").new()

onready var Player = get_node("/root/MainScene/Player")
onready var Sounds = get_node('/root/MainScene/Sounds')

var shoot_position : Vector2
var shoot_direction

const SPEED : float = 500.0

onready var Enemy_count = get_node('/root/MainScene/Camera2D/CanvasLayer/Control/Enemies/Label')

func _ready():
	shoot_position = Position2DShooter.get_global_position()
	_set_collision_layers()
	_set_bullet_direction()
	
func _set_collision_layers():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.ENEMY, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)
	
func _set_bullet_direction():
	shoot_direction = (shoot_position - self.get_global_position()).normalized()
	shoot_direction = shoot_direction.normalized()
	shoot_direction.x = round(shoot_direction.x)
	shoot_direction.y = round(shoot_direction.y)

func _on_Timer_timeout():
	_do_shoot()
	
func _do_shoot():
	var bullet = BULLET.instance()
	bullet.position = shoot_position
	get_tree().get_root().add_child(bullet)
	bullet.linear_velocity = SPEED * shoot_direction

func _on_Shooter_body_entered(body):
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.BULLET):
		_do_hit(body)
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.PLAYER):
		Player.do_hit(body)
	
func _do_hit(var body):
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
	self.queue_free()
