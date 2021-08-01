extends Area2D

onready var Player = get_node('/root/MainScene/Player')

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PICKUP, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)

func _on_Pickup_shot_body_entered(body):
	$Particles2D2.emitting = true
	return;
	var child = Utility.reparent($Particles2D2, get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 2)
	Player.shots_remaining_add()
	self.queue_free()
