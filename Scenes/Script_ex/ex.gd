extends Node2D

var number : int = 50

#Start
func _ready() -> void:
	pass


# Update
func _process(delta: float) -> void: 
	if Input.is_action_pressed("move_right"): number+=1 
	if number < 49: print('sim')
	elif number > 50: print('nao') 
