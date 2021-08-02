extends Area2D

var Utility = preload("res://Scripts/Utility.gd").new()
onready var Sounds = get_node('/root/MainScene/Sounds')

onready var Player = get_node('/root/MainScene/Player')

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BLOCK, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)

func _on_Area2D_body_entered(body):
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.PLAYER):
		Player.do_hit(self)
		
	if body.get_collision_layer_bit(Enums.COLLISION_LAYER.BULLET):
		_do_hit_bullet(body)
		Sounds.get_node('hit2').play()
		$Sprite.material.set_shader_param("flash_modifier", 1)
		yield(get_tree().create_timer(0.5), "timeout")
		$Sprite.material.set_shader_param("flash_modifier", 0)
		

func _do_hit_bullet(body):
	body.queue_free()
	var child = Utility.reparent(body.get_node('Particles2D'), get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 0.3)
