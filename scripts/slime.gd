extends CharacterBody2D

@export var speed = 50
@export var health = 100

var dead = false
var player_in_area = false
var player

func _ready():
	dead = false
	$DetectionArea/CollisionShape2D.disabled = false

func _physics_process(delta):
	if !dead:
		if player_in_area:
			position += (player.position - position) / speed
			$AnimatedSprite2D.play("move")
		else: 
			$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false

func _on_hitbox_area_entered(area):
	var damage
	if area.is_in_group("projetil"):
		damage = 50
		take_damage(damage)
		area.queue_free()
		
func take_damage(damage):
	health = health - damage
	if health <= 0 and !dead:
		death()
		
func death():
	dead = true
	$DetectionArea/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("death")
	
	await get_tree().create_timer(1).timeout
	queue_free()
