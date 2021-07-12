extends Area2D

export var teleport_to : String

signal player_entered_teleporter
	
func _on_Teleporter_body_entered(body):
	if body.name == 'Player':
		emit_signal("player_entered_teleporter", teleport_to)
