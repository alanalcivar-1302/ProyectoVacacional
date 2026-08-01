extends Node2D

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
		
		$Jugador.add_child(carta)
		
		carta.position = Vector2(i * 170,0)
		
		mano_jugador.append(carta)
		

func crear_cartas_cpu():
	for i in range(4):
		
		var carta = CARD.instantiate()

		carta.valor = i + 1
		
		carta.frente = imagenes[i]
		
		$CPU.add_child(carta)

		carta.position = Vector2(i * 170,0)

		mano_cpu.append(carta)
