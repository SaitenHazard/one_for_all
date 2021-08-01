extends Area2D

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BLOCK, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.BULLET, true)
