extends RigidBody2D

func _on_Lifetime_timeout():
	_collide_with_player()
	_collide_with_enemy_not()
	if not $Particles2D == null:
		$Particles2D.set_emitting(false)

func _collide_with_player():
	self.set_collision_layer_bit (2, true)

func _collide_with_enemy_not():
	self.set_collision_layer_bit (1, false)
