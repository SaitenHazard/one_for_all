extends RigidBody2D

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET_ENEMY, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)

func _on_Bullet_enemy_body_entered(body):
	_do_hit_bullet(self)

func _do_hit_bullet(body):
	body.queue_free()
	var child = Utility.reparent(body.get_node('Particles2D'), get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 0.3)
