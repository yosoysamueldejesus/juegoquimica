extends CharacterBody2D

@onready var animated_sprite_ = $AnimatedSprite2D
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var label: Label = $"../Label"

const SPEED = 250.0
const JUMP_VELOCITY = -300.0
var salud = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta



	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		salud -= 20
		progress_bar.value = salud
		if salud <= 0: 
			label.visible = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite_.flip_h = false 
	elif direction < 0:
		animated_sprite_.flip_h = true 
		
		#ANIMACIONES
	if is_on_floor():
		if direction == 0:
			animated_sprite_.play("quieto")
		else:
			animated_sprite_.play("run")
	else:
		animated_sprite_.play("jump")









	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
