extends RigidBody2D

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PICKUP, true)

func _on_Lifetime_timeout():
	return
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET, false)
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PICKUP, true)
	
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, false)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	
	remove_from_group('bullet')
	
	if not $Particles2D == null:
		$Particles2D.set_emitting(false)
