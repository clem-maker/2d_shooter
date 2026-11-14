extends CharacterBody2D
@export_group("Movment")
@export var SPEED : float = 1000
@export var DEACCELERATION : float = 0.8
@export var MINIMUM_SPEED : float = 0.1

@export_group("Camera")
@export var zoom_goal : Vector2 = Vector2(1,1)
@export_subgroup("min-max_soom")
@export var BIGGEST_CAMERA_ZOOM : float = 0.5
@export var SMALEST_CAMERA_ZOOM : float = 10

@export_group("particles")
@export var particles_on : bool = true
@export var particle_size : Vector2 = Vector2(1,1)

var input_vec : Vector2
func _ready() -> void:
	%Camera.top_level = true
	if not particles_on:$leg_particles.hide()
	$leg_particles/left_leg_partikel.scale= particle_size
	$leg_particles/right_leg_partikel.scale = particle_size
func _process(_delta: float) -> void:
	#Animation
	if not input_vec == Vector2.ZERO:
		if Input.get_axis("left","right") or Input.get_axis("up","down"):
			$AnimationPlayer.play("walk")
		#elif abs(input_vec.x) <.8 or abs(input_vec.y) < .8:
		else:
			$AnimationPlayer.play("slow_down")
	else:
		$AnimationPlayer.stop(false)
	#camera
	#camer_soom
# Zoom-Ziel setzen beim Tastendruck
	if Input.is_action_just_pressed("zoom_in"):
		if zoom_goal.x <= SMALEST_CAMERA_ZOOM:
			zoom_goal *= 1.1
	if Input.is_action_just_pressed("zoom_out"):
		if zoom_goal.x >= BIGGEST_CAMERA_ZOOM:
			zoom_goal /= 1.1
	# jeden Frame smooth zum Ziel gleiten
	%Camera.zoom = lerp(%Camera.zoom, zoom_goal, 0.1)
	%Camera.global_position = lerp(%Camera.global_position, global_position,clamp(0.09 * %Camera.zoom.x,0,1))
func _physics_process(delta: float) -> void:
	#input
	if not Input.get_axis("left","right") == 0:
		input_vec.x = Input.get_axis("left","right")
	if not Input.get_axis("up","down") == 0:
		input_vec.y = Input.get_axis("up","down")
	

	
	velocity = input_vec.normalized() *  SPEED
	
	if Input.is_action_just_pressed("right"):$body.scale.x = abs($body.scale.x)
	elif Input.is_action_just_pressed("left"):$body.scale.x = -abs($body.scale.x)
	move_and_slide()
	input_vec *= DEACCELERATION ** (delta * 60.0)  # framerate-unabhängig
	if input_vec.length() <  MINIMUM_SPEED:
		input_vec = Vector2.ZERO
