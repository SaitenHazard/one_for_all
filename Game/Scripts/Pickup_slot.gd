extends Area2D

onready var Player = get_node('/root/MainScene/Player')

var Utility = preload("res://Scripts/Utility.gd").new()
onready var Sounds = get_node('/root/MainScene/Sounds')

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PICKUP, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)

func _on_Pickup_shot_body_entered(body):
	Player.shots_max_add()
	Sounds.get_node('powerup').play()
	$Particles2D2.emitting = true
	var child = Utility.reparent($Particles2D2, get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 2)
	self.queue_free()
