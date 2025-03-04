extends Node2D

const speed= 60

var direction= 1 
@onready var ray_cast_2_left: RayCast2D = $RayCast2left
@onready var ray_castright: RayCast2D = $RayCastright



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if ray_castright.is_colliding():
			#direction= -1
	#if ray_cast_2_left.is_colliding():
		#direction= 1
