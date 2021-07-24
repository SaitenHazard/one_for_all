extends Area2D

onready var Sprite = $Sprite

onready var Texture_on = preload("res://sprite/checkpoint_1.png")
onready var Texture_off = preload("res://sprite/checkpoint_0.png")

onready var Player = get_node('/root/MainScene/Player')

func _on_Checkpoint_body_entered(body):
	if body.name == 'Player':
		Sprite.texture = Texture_on
		Player.set_checkpoint_name(self.name)
