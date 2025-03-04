extends CharacterBody2D

@onready var animated_sprite_ = $AnimatedSprite2D
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var label: Label = $"../Label"

const SPEED = 250.0
const JUMP_VELOCITY = -300.0
var salud = 100
var atacando:bool = false 

func _ready():
	$Area2D/CollisionShape2D.disabled= true 

func _physics_process(delta: float) -> void:
	
	
	
	if atacando:
		animated_sprite_.play("atacando")
		await(animated_sprite_.animation_finished)
		$Area2D/CollisionShape2D.disabled= true 
		atacando = false
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		if Input.is_action_just_pressed("atacando") and is_on_floor():
			atacando = true
			$Area2D/CollisionShape2D.disabled= false
			
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
				
		var direction := Input.get_axis("move_left", "move_right")
		if direction > 0:
			animated_sprite_.flip_h = false 
			$Area2D.position.x = 0
		elif direction < 0:
			animated_sprite_.flip_h = true 
			$Area2D.position.x = -25 # Desplazamiento del area hacia la izquierda
			#ANIMACIONES
		if is_on_floor():
			if direction == 0:
				animated_sprite_.play("quieto")
			else:
				animated_sprite_.play("run")
		else:
			animated_sprite_.play("jump")

	#salud -= 20
		#progress_bar.value = salud
		#if salud <= 0: 
			#label.visible = true
			
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2DEnemigo"):
		body.queue_free() #solo si colisiona con el nodo del enemigo
		
