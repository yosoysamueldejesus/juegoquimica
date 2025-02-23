extends Area2D

@onready var airent: Timer = $airent
@onready var ahogando: Timer = $ahogando


var oxi = 100 #Porcentaje de oxígeno 
var opps = 20 #Oxígeno Perdido Por Segundo
var zairent = false #zona sin aire (ox)


func _on_body_entered(_body) -> void:
	print ("Estás entrando a una zona sin oxígeno!")
	zairent = true
	airent.start()

func _on_body_exited(_body) -> void:
	print("Vuelves a tener oxígeno, tus pulmones te lo agradecen")
	zairent = false
	oxi = 100
	airent.stop()
	ahogando.stop()

func _on_airent_timeout():
	if zairent:
		print("Te quedaste sin oxígeno!")
		ahogando.start()

func _on_ahogando_timeout():
	if zairent:
		oxi -= opps
		print("Te queda " + str(oxi) + "% de oxígeno")
		if oxi <= 0:
			print("Moriste!")
			get_node("airent").queue_free()
			get_tree() .reload_current_scene()
		else:
			ahogando.start()
	else:
		ahogando.stop()
