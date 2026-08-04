extends Node2D
@export var separacion_cartas := 170
const CARD = preload("res://scenes/card.tscn")

var imagenes = [
	preload("res://assets/cards/carta1.png"),
	preload("res://assets/cards/carta2.png"),
	preload("res://assets/cards/carta3.png"),
	preload("res://assets/cards/carta4.png")
]

var mano_jugador = []
var mano_cpu = []

var mazo = [1,2,3,4]

func _ready():
	print("El juego inicio")
	crear_cartas()
	
	crear_cartas_cpu()

func crear_cartas():
	for i in range(4):
		
		var carta = CARD.instantiate()
		
		carta.valor = i + 1
		
		carta.frente = imagenes[i]
		
		$Jugador/Cartas.add_child(carta)
		carta.scale = Vector2(0.4,0.4)
		var inicio = $Jugador/PuntoInicial.position
		
		carta.position = inicio + Vector2(i * separacion_cartas ,0)
		
		mano_jugador.append(carta)
		

func crear_cartas_cpu():
	for i in range(4):
		
		var carta = CARD.instantiate()

		carta.valor = i + 1
		
		carta.frente = imagenes[i]
		
		$CPU/Cartas.add_child(carta)
		carta.scale = Vector2(0.4,0.4)
		var inicio = $CPU/PuntoInicial.position
		carta.position = inicio + Vector2(i * separacion_cartas,0)

		mano_cpu.append(carta)
		
func mover_carta_jugador(carta):

	carta.reparent($Mesa)

	carta.global_position = $Mesa/PosCartaJugador.global_position

func mover_carta_cpu(carta):

	carta.reparent($Mesa)

	carta.global_position = $Mesa/PosCartaCPU.global_position
