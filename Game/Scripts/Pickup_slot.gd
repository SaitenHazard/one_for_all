extends Area2D

onready var Player = get_node('/root/MainScene/Player')

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PICKUP, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)

func _on_Pickup_slot_body_entered(body):
	Player.shots_max_add()
	self.queue_free()
