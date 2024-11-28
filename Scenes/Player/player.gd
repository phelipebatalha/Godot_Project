extends CharacterBody2D

var speed : float = 100.0
var direcao : Vector2 = Vector2(0,0)
var player_state

var bow_equiped = false
var bow_cooldown = true
var arrow = preload("res://Scenes/arrow.tscn")

func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	var direcao = Input.get_vector("mv_esquerda","mv_direita","mv_cima","mv_baixo")
	if direcao.x == 0 && direcao.y == 0:
		player_state = "Idle"
	elif direcao.x !=0 || direcao.y !=0:
		player_state = "Walking"
	velocity = direcao.normalized() * speed 
	move_and_slide() # pega a velocity e movimenta baseado nela
	_animation(direcao)
	
	if Input.is_action_just_pressed("e"):
		if bow_equiped:
			bow_equiped = false
		else:
			bow_equiped = true
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(.4).timeout
		bow_cooldown = true

func _player() -> void:
	pass
	
func _animation(direcao) -> void:
	if player_state == "Idle":
		$AnimatedSprite2D.play("Idle")
	if player_state == "Walking":
		if direcao.y == -1:
			$AnimatedSprite2D.play("N-walk")
		elif direcao.y == 1:
			$AnimatedSprite2D.play("S-walk")
		elif direcao.x == -1:
			$AnimatedSprite2D.play("L-walk")
		elif direcao.x == 1:
			$AnimatedSprite2D.play("R-walk")
			
		elif direcao.x > .5 and direcao.y < -.5:
			$AnimatedSprite2D.play("Ne-walk")
		elif direcao.x > .5 and direcao.y > .5:
			$AnimatedSprite2D.play("Se-walk")
		elif direcao.x < -.5 and direcao.y < -.5:
			$AnimatedSprite2D.play("No-walk")
		elif direcao.x < -.5 and direcao.y > .5:
			$AnimatedSprite2D.play("So-walk")
		
func _movement_exemple() -> void:
	if Input.is_action_pressed('mv_direita') :
		direcao.x = 1
	elif Input.is_action_pressed('mv_esquerda') :
		direcao.x = -1
	else : direcao.x = 0
	if Input.is_action_pressed('mv_cima') :
		direcao.y = -1
	elif Input.is_action_pressed('mv_baixo') :
		direcao.y = 1
	else : direcao.y = 0  
	
	velocity = direcao.normalized() * speed 
	move_and_slide() # pega a velocity e movimenta baseado nela
	
	
	
