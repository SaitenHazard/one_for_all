extends Area2D

onready var Sprite = $Sprite

onready var Texture_on = preload("res://sprite/checkpoint_1.png")
onready var Texture_off = preload("res://sprite/checkpoint_0.png")

onready var Player = get_node('/root/MainScene/Player')
onready var Sounds = get_node('/root/MainScene/Sounds')

export var on : bool = false

func _on_Checkpoint_body_entered(body):
	if body.name == 'Player':
		_set_checkpoint_on()
		
func _set_checkpoint_on():
	if not on:
		$AnimationPlayer.play('swing')
		Sounds.get_node('checkpoint').play()
	Player.set_checkpoint(self.name)
	on = true
		
func set_checkpoint_off():
	on = false

func _process(delta):
	if on:
		Sprite.texture = Texture_on
	else:
		Sprite.texture = Texture_off
