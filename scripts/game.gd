extends Node2D
@export var separacion_cartas := 170
const CARD = preload("res://scenes/card.tscn")

var carta_jugada_jugador = null

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
		carta.posicion_original = carta.position
		#la almacena en la lista de las cartas
		mano_jugador.append(carta)
		carta.carta_seleccionada.connect(jugar_carta)
		

func crear_cartas_cpu():
		#crea las 4 cartas con un bucle
	for i in range(4):
		#instancia cada carta
		var carta = CARD.instantiate()
		#Le da el valor a la carta
		carta.valor = i + 1
		#asigna la imagen
		carta.frente = imagenes[i]
		#la hace hijo de node2D carta de la CPU
		$CPU/Cartas.add_child(carta)
		#oculta la carta
		carta.ocultar()
		#ajusta escala
		carta.scale = Vector2(0.4,0.4)
		#El punto inicial para las cartas
		var inicio = $CPU/PuntoInicial.position
		#Posiciona la carta
		carta.position = inicio + Vector2(i * separacion_cartas,0)
		carta.posicion_original = carta.position
		#Agrega la carta a la lista
		mano_cpu.append(carta)


func mover_carta_jugador(carta):
	
	carta.reparent($Mesa)
	
	carta.global_position = $Mesa/PosCartaJugador.global_position

func mover_carta_cpu(carta):
	
	carta.reparent($Mesa)
	
	carta.global_position = $Mesa/PosCartaCPU.global_position

func jugar_carta(carta):
	print("se hizo un clic en ", carta.name)
	if carta_jugada_jugador != null:
		return
	
	carta_jugada_jugador = carta
	
	# Mueve la carta del jugador
	carta.reparent($Mesa)
	carta.global_position = $Mesa/PosCartaJugador.global_position
	carta.input_pickable = false
	
	# Quitamos la carta de la lista de la mano del jugador
	mano_jugador.erase(carta)
	
	# Llamamos a la lógica de la CPU
	responder_cpu()

func responder_cpu():
	# Hacemos una pausa de 1 segundo para darle fluidez al juego
	await get_tree().create_timer(1.0).timeout
	
	# La CPU elige una carta aleatoria de su lista
	var carta_cpu = mano_cpu.pick_random()
	
	# La quitamos de la mano de la CPU
	mano_cpu.erase(carta_cpu)
	
	# Movemos la carta de la CPU a su posición en la mesa
	carta_cpu.reparent($Mesa)
	carta_cpu.global_position = $Mesa/PosCartaCPU.global_position
	
	# Revelamos la carta elegida por la CPU
	carta_cpu.revelar()
	
	# (Próximamente aquí llamaremos a la función que compara los valores)
	comparar_cartas(carta_jugada_jugador, carta_cpu)

func comparar_cartas(carta_jugador, carta_cpu):
	# Damos 1.5 segundos para que el jugador vea qué carta sacó la CPU
	await get_tree().create_timer(1.5).timeout
	
	if carta_jugador.valor == carta_cpu.valor:
		print("¡Son iguales! La CPU gana el par.")
		# Las cartas salen de la partida
		carta_jugador.queue_free() 
		carta_cpu.queue_free()
		# (Próximamente: sumar punto a la CPU)
	else:
		print("Son distintas. Las cartas regresan a sus manos.")
		# (Próximamente: animar el regreso de las cartas)
		pass
		
	# Reiniciamos la variable del jugador para liberar el tablero y permitir el siguiente turno
	carta_jugada_jugador = null
