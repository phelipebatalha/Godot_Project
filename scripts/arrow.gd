extends Area2D

@export var speed = 300
@export var damage = 50

func _ready() -> void:
	set_as_top_level(true)

func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
func arrow_deal_damage():
	return damage

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
