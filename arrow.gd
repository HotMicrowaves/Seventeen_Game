extends Node2D

@onready var animation = get_node("AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Idle")
