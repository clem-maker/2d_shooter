extends RigidBody2D
var start_position:Vector2
var now_postion:Vector2
var bullet_length:float

var direction : Vector2
var speed : float
@export var MIN_SPEED : int = 50
@export var MAX_SPEED : int = 1200

func vec_length(dir:Vector2) ->float:
	return sqrt((dir.x**2) +  (dir.y**2))
	
func _ready() -> void:
	start_position = global_position 
	
	#gravity_scale = 0 #keine gravitaet
	speed = Global.target_vec.length() *2 # ← Länge des Vektors = Distanz zur Maus
	speed = clamp(speed,MIN_SPEED,MAX_SPEED)#bullet iost nicht zu schnell oder zu langsam(clampen -> english)
	direction = Global.target_vec.normalized()  # ← Richtung separat
	bullet_length = vec_length(Global.target_vec) #wie weit die bullet fliegen sollte als vec
	#linear_velocity = direction * speed
func _physics_process(delta: float) -> void:
	
	if !abs(vec_length(start_position-now_postion)) >= bullet_length: #compere vergleichen der psoitionnen deann die laenge 
																	  #finden und die dann mit der vorhinein berechenten bullet length
		position += direction * speed * delta #moving bullet
		now_postion = global_position
	#else:
		
		print_debug("despawnen")
		
