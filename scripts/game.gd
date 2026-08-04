extends Node2D
@export var separacion_cartas := 170
const CARD = preload("res://scenes/card.tscn")

#Lista con todas las imagenes de las cartas
var imagenes = [
	preload("res://assets/cards/carta1.png"),
	preload("res://assets/cards/carta2.png"),
	preload("res://assets/cards/carta3.png"),
	preload("res://assets/cards/carta4.png")
]

#Listas en donde estaran las cartas de jugador y cpu
var mano_jugador = []
var mano_cpu = []

#El mazo por defecto para ambos
var mazo = [1,2,3,4]

#llama a las funciones que crean las cartas
func _ready():
	
	crear_cartas()
	
	crear_cartas_cpu()

func crear_cartas():
	#con un bucle crea las 4 cartas
	for i in range(4):
		#Instancia las cartas 
		var carta = CARD.instantiate() 
		#Le da el valor a la carta
		carta.valor = i + 1
		#asigna la imagen respectiva de cada carta
		carta.frente = imagenes[i]
		#la hace hijo al nodo2D Cartas
		$Jugador/Cartas.add_child(carta)
		#Revela la carta
		carta.revelar()
		#configuracion de escala
		carta.scale = Vector2(0.4,0.4)
		#La coloca en el punto inicial.
		var inicio = $Jugador/PuntoInicial.position
		#posiciona la carta
		carta.position = inicio + Vector2(i * separacion_cartas ,0)
		#la almacena en la lista de las cartas
		mano_jugador.append(carta)
		carta.carta_seleccionada.connect(jugar_carta)
		

func crear_cartas_cpu():
	for i in range(4):
		
		var carta = CARD.instantiate()

		carta.valor = i + 1
		
		carta.frente = imagenes[i]
		$CPU/Cartas.add_child(carta)
		carta.ocultar()
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

func jugar_carta(carta):

	carta.reparent($Mesa)

	carta.global_position = $Mesa/PosCartaJugador.global_position
