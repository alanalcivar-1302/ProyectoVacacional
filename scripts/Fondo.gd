extends Node2D

# 1. Cargamos la plantilla de tu carta (ajusta la ruta si la guardaste en otra carpeta)
const ESCENA_CARTA = preload("res://escenas/Carta.tscn")

# 2. Hacemos una referencia al contenedor donde se van a ordenar las cartas
@onready var mono = $mono
@onready var Control2 = $Control2

func _ready():
	# 3. Llamamos a la función dos veces para generar dos cartas distintas
	generar_carta()
	
	
# Función encargada de clonar y configurar cada carta
func generar_carta():
	# A. Creamos una copia física (instancia) de tu carta.tscn
	var nueva_carta = ESCENA_CARTA.instantiate()
	var nueva_carta2 = ESCENA_CARTA.instantiate()

	
	# C. La metemos dentro del contenedor "Mano" para que aparezca en pantalla
	mono.add_child(nueva_carta)
	
	Control2.add_child(nueva_carta2)
