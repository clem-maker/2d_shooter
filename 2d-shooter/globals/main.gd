extends Node2D

@export var bullet_not_despwaning_time : int = 5
var instanz_target_symbol : TextureRect
var instanz_bullet : Node2D
var instanz_explosion : Node2D


func load_and_instantiate() -> void:
	instanz_target_symbol = load("uid://cneobvoiesig2").instantiate()
	instanz_bullet = load("uid://dux0fglknt4sc").instantiate()
	instanz_explosion = load("uid://bjh4ennhrtdj8").instantiate()
func target_transform(mouse_position_local : Vector2)->void:
	Global.target_vec = mouse_position_local - $player/gun_shoot_point.global_position
	instanz_target_symbol.position = mouse_position_local - Vector2(15,15) # target symbol alighnen
func random_explosion_scale() -> Vector2:
	var random_scale = randf_range(.6,1.2)
	return Vector2(random_scale,random_scale)
func random_explosion_rotation()-> float:
	return randf_range(-360,360)
func random_explosion_offset()->Vector2:
	return Vector2(randf_range(-10,10),randf_range(-10,10))
func randomnis_explosion_combined() ->void:
	instanz_explosion.scale = random_explosion_scale()
	instanz_explosion.rotation = rad_to_deg(random_explosion_rotation())
	instanz_explosion.position += random_explosion_offset()
func play_explosion_animation_and_delete()-> void:
	instanz_explosion.get_node("explosion").play()
	await get_tree().create_timer(.20).timeout
	if is_instance_valid(instanz_explosion):instanz_explosion.queue_free()
func lade_szene(mouse_position:Vector2):
	#instanite every thing
	load_and_instantiate()
	#target
	target_transform(mouse_position)
	add_child(instanz_target_symbol)
	
	#bullet
	add_child(instanz_bullet)
	if is_instance_valid(instanz_bullet):
		instanz_bullet.global_position = $player/gun_shoot_point.global_position
		instanz_bullet.rotation = Global.target_vec.angle()
		
	#explosion:
	instanz_explosion.position = instanz_target_symbol.position-Vector2(-15,-15)
	await get_tree().create_timer(.5).timeout
	add_child(instanz_explosion)
	if is_instance_valid(instanz_explosion):
		randomnis_explosion_combined()
		play_explosion_animation_and_delete()
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		lade_szene(get_global_mouse_position())
