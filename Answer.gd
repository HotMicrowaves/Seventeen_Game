extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func attack():
	get_node("AnimatedSprite2D").play("Transform")
	await get_tree().create_timer(1.4).timeout
	get_node("AnimatedSprite2D").play("Circling")
	var tween = get_tree().create_tween().set_parallel(true)
	var tween1 = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "position", Global.enemy_target, .75)
	tween.tween_property(self, "scale", Vector2(.2, .2), .75)
	player.anim.play("Attack")
	tween1.tween_property(self, "scale", Vector2(3, 3), 1).set_delay(0.75)
	tween1.tween_property(self, "modulate:a", 0, 1).set_delay(0.75)
	player.anim.play("Idle")
	Global.enemy_target = null

func discard():
	get_node("AnimatedSprite2D").play("Transform")
	await get_tree().create_timer(1.4).timeout
	get_node("AnimatedSprite2D").play("Circling")
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(1079, 575), .75)
	tween.tween_property(self, "scale", Vector2(.2, .2), .75)
	await get_tree().create_timer(.75).timeout
	get_node("AnimatedSprite2D").play("Discard")
	var tween1 = get_tree().create_tween().set_parallel(true)
	tween1.tween_property(self, "scale", Vector2(3, 3), 1)
	tween1.tween_property(self, "modulate:a", 0, 1)

func clone():
	get_node("AnimatedSprite2D").play("Idle")
	self.position = Vector2(980, 575)
	self.scale = Vector2(1, 1)
	self.modulate.a = 1
