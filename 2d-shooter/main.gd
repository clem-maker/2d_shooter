extends Node2D

@export var bullet_not_despwaning_time : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		#print(get_viewport().get_mouse_position())
		#print(get_global_mouse_position())
		lade_szene(get_global_mouse_position())
		
		
func lade_szene(mouse_position:Vector2):
	var instanz_target_symbol = load("res://target.tscn").instantiate()
	if is_instance_valid(Global.instanz_bullet):
		Global.instanz_bullet = load("res://bullet.tscn").instantiate()

	# ← sofort berechnen, vor dem await!
	Global.target_vec = mouse_position - $player/gun_shoot_point.global_position

	instanz_target_symbol.position = mouse_position - Vector2(15,10)
	add_child(instanz_target_symbol)
	
	add_child(Global.instanz_bullet)
	Global.instanz_bullet.global_position = $player/gun_shoot_point.global_position
	Global.instanz_bullet.rotation = Global.target_vec.angle()

	await get_tree().create_timer(bullet_not_despwaning_time).timeout
	if is_instance_valid(Global.instanz_bullet):
		Global.destroy_bullet(Global.instanz_bullet)
