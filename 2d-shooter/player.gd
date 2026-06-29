extends CharacterBody2D
const MAX_SPEED : int = 120
const SPEED : float = 10.0
const JUMP_FORCE : float= 30.0   # Anfangsgeschwindigkeit nach oben
var direction : Vector2
const BIGGEST_CAMERA_ZOOM : float = 0.5
const SMALEST_CAMERA_ZOOM : float = 10
var is_jumping : bool = false
const BESCHLEUNIGUNG : int = 200
var zoom_goal : Vector2 = Vector2(1, 1)
var facing_right : bool
func _ready() -> void:
	$Camera2D.top_level = true
 
		
func _process(delta: float) -> void:
	# Sprung starten
	if Input.is_action_just_pressed("jump"):
		#var jump_hight = JUMP_FORCE
		pass
	# Bewegung
	if Input.is_action_pressed("down"):
		if direction.y < MAX_SPEED:
			direction.y += ( BESCHLEUNIGUNG * delta )
	if Input.is_action_pressed("up"):
		if direction.y > -MAX_SPEED:
			direction.y -= ( BESCHLEUNIGUNG * delta )
	if Input.is_action_pressed("right"):
		if direction.x < MAX_SPEED:
			direction.x += ( BESCHLEUNIGUNG * delta )
	if Input.is_action_pressed("left"):
		if direction.x > -MAX_SPEED:
			direction.x -= ( BESCHLEUNIGUNG * delta )
	
	

		
		
		#direction : "+" , "-"    :
		
	if abs(direction.x) < 1.5:
		direction.x = 0
		#Global.blickrichtung = true
	if abs(direction.y) < 1.5:
		direction.y = 0
		#Global.blickrichtung = false
	
	
		
	#entschleunigung
	var moving_x = Input.is_action_pressed("right") or Input.is_action_pressed("left")
	var moving_y = Input.is_action_pressed("up") or Input.is_action_pressed("down")

	if not moving_x:
		direction.x *= 0.8
	if not moving_y:
		direction.y *= 0.8
		
	#print(direction)

	#camer_soom
# Zoom-Ziel setzen beim Tastendruck
	if Input.is_action_just_pressed("soom_in"):
		if zoom_goal.x <= SMALEST_CAMERA_ZOOM:
			zoom_goal *= 1.1
	if Input.is_action_just_pressed("soom_out"):
		if zoom_goal.x >= BIGGEST_CAMERA_ZOOM:
			zoom_goal /= 1.1

	# jeden Frame smooth zum Ziel gleiten
	$Camera2D.zoom = lerp($Camera2D.zoom, zoom_goal, 0.1)
			
			
			
	#animation
	if direction != Vector2.ZERO:
		if Input.is_action_pressed("down") or Input.is_action_pressed("right") or\
		Input.is_action_pressed("left") or Input.is_action_pressed("up"):
			if not $AnimationPlayer.current_animation == "walk":
				$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("slow_down")
	else:
		$AnimationPlayer.play("RESET")
		#print("keine animation")
		pass
	$Camera2D.global_position = lerp($Camera2D.global_position, global_position,clamp(0.09 * $Camera2D.zoom.x,0,1))
func _physics_process(delta: float) -> void:
	velocity = direction * SPEED * delta  # delta hier nötig!
	if not test_move(global_transform,velocity):
		position+= velocity
	else:
		if not test_move(global_transform, Vector2(velocity.x, 0)):
			position += Vector2(velocity.x, 0)
		if not test_move(global_transform, Vector2(0, velocity.y)):
			position += Vector2(0,velocity.y)
	#var kollision = move_and_collide(velocity)
	if Input.is_action_pressed("right"):
		scale.x = abs(scale.x)
	elif Input.is_action_pressed("left"):
		#print(scale.x)
		scale.x = -abs(scale.x)
		#print(scale.x)
	
	

	##if kollision:
		#print("Wand getroffen!")
	
