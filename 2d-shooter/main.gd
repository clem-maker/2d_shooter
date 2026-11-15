extends Node2D
var instanz_bullet 
@export var bullet_not_despwaning_time : int = 5



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		lade_szene(get_global_mouse_position())
		
		
func lade_szene(mouse_position:Vector2):
	
	
	#target symbol
	var instanz_target_symbol = load("res://target.tscn").instantiate()
	instanz_bullet = load("res://bullet.tscn").instantiate()
	var instanz_explosion = load("res://explosion.tscn").instantiate()
	Global.target_vec = mouse_position - $player/gun_shoot_point.global_position
	instanz_target_symbol.position = mouse_position - Vector2(15,15) # target symbol alighnen
	add_child(instanz_target_symbol)
	
	#bullet
	add_child(instanz_bullet)
	if is_instance_valid(instanz_bullet):
		instanz_bullet.global_position = $player/gun_shoot_point.global_position
		instanz_bullet.rotation = Global.target_vec.angle()
	#explosion:
	await get_tree().create_timer(.5).timeout
	instanz_explosion.position = instanz_target_symbol.position-Vector2(-15,-15)
	add_child(instanz_explosion)
	#random displaces:
	
	#scale:
	var random_scale = randf_range(.6,1.2)
	instanz_explosion.scale = Vector2( random_scale , random_scale )
	
	#rotation:
	var random_rotation = randf_range(-360,360)
	instanz_explosion.rotation = deg_to_rad(random_rotation)

	instanz_explosion.get_node("explosion").play()
	await get_tree().create_timer(.20).timeout
	instanz_explosion.queue_free()
