extends CharacterBody2D
const MAX_SPEED : int = 120
const SPEED : float = 10.0
const JUMP_FORCE : float= 30.0   # Anfangsgeschwindigkeit nach oben
var direction : Vector2
const BIGGEST_CAMERA_ZOOM : float = 0.5
const SMALLEST_CAMERA_ZOOM : float = 10
var is_jumping : bool = false
const ACCELERATION : int = 50
var zoom_goal : Vector2 = Vector2(1, 1)
var facing_right : bool
func _ready() -> void:
	$Camera2D.top_level = true
func _process(_delta: float) -> void:
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
	#Camera
	if Input.is_action_pressed("right"):
		scale.x = abs(scale.x)
	elif Input.is_action_pressed("left"):
		scale.x = -abs(scale.x)
	
	# Zoom-Ziel setzen beim Tastendruck
	if Input.is_action_just_pressed("zoom_in"):
		if zoom_goal.x <= SMALLEST_CAMERA_ZOOM:
			zoom_goal *= 1.1
	if Input.is_action_just_pressed("zoom_out"):
		if zoom_goal.x >= BIGGEST_CAMERA_ZOOM:
			zoom_goal /= 1.1
	# smoothly slide to target every frame
	$Camera2D.zoom = lerp($Camera2D.zoom, zoom_goal, 0.1)
	$Camera2D.global_position = lerp($Camera2D.global_position, global_position,clamp(0.09 * $Camera2D.zoom.x,0,1))
func _physics_process(delta: float) -> void:
	if abs(direction.x) < 1.5:
		direction.x = 0
	if abs(direction.y) < 1.5:
		direction.y = 0
	# Bewegung
	if Input.is_action_pressed("down"):
		if direction.y < MAX_SPEED:
			direction.y += ACCELERATION
	if Input.is_action_pressed("up"):
		if direction.y > -MAX_SPEED:
			direction.y -= ACCELERATION
	if Input.is_action_pressed("right"):
		if direction.x < MAX_SPEED:
			direction.x += ACCELERATION
	if Input.is_action_pressed("left"):
		if direction.x > -MAX_SPEED:
			direction.x -= ACCELERATION
			
	velocity = direction * SPEED * delta  # delta needed here!
	if not test_move(global_transform,velocity):
		position+= velocity
	else:
		if not test_move(global_transform, Vector2(velocity.x, 0)):
			position += Vector2(velocity.x, 0)
		if not test_move(global_transform, Vector2(0, velocity.y)):
			position += Vector2(0,velocity.y) 
			
	#entschleunigung
	var moving_x = Input.is_action_pressed("right") or Input.is_action_pressed("left")
	var moving_y = Input.is_action_pressed("up") or Input.is_action_pressed("down")
	if not moving_x:
		direction.x *= 0.8
	if not moving_y:
		direction.y *= 0.8
