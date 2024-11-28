extends CharacterBody2D

var speed : float = 100.0
var direcao : Vector2 = Vector2(0,0)
var player_state

var bow_equiped = false
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")

func _physics_process(delta: float) -> void:
	velocity = direcao.normalized() * speed 
	move_and_slide() # pega a velocity e movimenta baseado nela
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	gerenciar_animacao()
	
func gerenciar_animacao() -> void:
	if player_state == "Idle":
		$AnimatedSprite2D.play("Idle")
	elif player_state == "Walking":
		if direcao.x == 1 and direcao.y == -1:
			$AnimatedSprite2D.play("Ne-walk")
		elif direcao.x == 1 and direcao.y == 1:
			$AnimatedSprite2D.play("Se-walk")
		elif direcao.x == -1 and direcao.y == -1:
			$AnimatedSprite2D.play("No-walk")
		elif direcao.x == -1 and direcao.y == 1:
			$AnimatedSprite2D.play("So-walk")
		elif direcao.y == -1:
			$AnimatedSprite2D.play("N-walk")
		elif direcao.y == 1:
			$AnimatedSprite2D.play("S-walk")
		elif direcao.x == -1:
			$AnimatedSprite2D.play("L-walk")
		elif direcao.x == 1:
			$AnimatedSprite2D.play("R-walk")
		
func _input(event: InputEvent) -> void:
	input_movimentacao(event)
	input_arco(event)
			
func input_movimentacao(event: InputEvent) -> void:
	if event.is_action('mv_direita') or event.is_action('mv_esquerda'):
		direcao.x = Input.get_axis('mv_esquerda', 'mv_direita')
	
	if event.is_action('mv_cima') or event.is_action('mv_baixo'):
		direcao.y = Input.get_axis('mv_cima', 'mv_baixo')
		
	if direcao.x == 0 && direcao.y == 0:
		player_state = "Idle"
	else:
		player_state = "Walking"

func input_arco(event: InputEvent) -> void:
	if event.is_action_pressed("e"):
		bow_equiped = not bow_equiped
	
	if Input.is_action_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		
		var root = get_tree().root
		root.add_child(arrow_instance)
		
		$BowTimer.start()

func _on_bow_timer_timeout() -> void:
	bow_cooldown = true
