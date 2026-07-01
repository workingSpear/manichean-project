extends CharacterBody3D

# player
@export var speed = 7.0
@export var jump_velocity = 4.5
@export var acceleration = 5.0
@export var air_control = 2.0

# mouse
@export var mouse_sens = 0.003

# Refrences
@export var Head : Node3D
@export var Camera : Camera3D


# Head Bob
var bob_freq = 2.0
var bob_amp = 0.08
var bob_t = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion):
		Head.rotate_y(-event.relative.x * mouse_sens)
		Camera.rotate_x(-event.relative.y * mouse_sens)
	Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-70), deg_to_rad(80))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down") * int(!GameManager.currently_talking)
	var direction := (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if(is_on_floor()):
		velocity.x = lerp(velocity.x, direction.x * speed, delta * acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * acceleration)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * air_control)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * air_control)
	bob_t += delta * velocity.length() * float(is_on_floor())
	Camera.transform.origin = _headbob(bob_t)

	move_and_slide()

func _headbob(t) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(t * bob_freq) * bob_amp
	pos.x = cos(t * bob_freq / 2) * bob_amp
	return pos
