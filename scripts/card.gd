extends Area2D

@export var valor : int = 0
@export var frente : Texture2D

# Variable para recordar a dónde debe regresar
var posicion_original : Vector2

signal carta_seleccionada(carta)

var boca_abajo := true

@onready var sprite = $Sprite2D

#Inicia el juego
func _ready():
	pass

#revela las cartas y muestra la imagen de la carta
func revelar():
	boca_abajo = false
	sprite.texture = frente

#oculta la carta mostrando la imagen del dorso
func ocultar():
	boca_abajo = true
	sprite.texture = load("res://assets/cards/dorso.png")

#detecta los clicks

#func _input_event(viewport, event, shape_idx):
#	print(event)
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			emit_signal("carta_seleccionada", self)

func _input_event(viewport, event, shape_idx):
	print("Evento")

func _mouse_enter():
	print("Entró el mouse")
