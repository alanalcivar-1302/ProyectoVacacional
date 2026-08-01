extends Area2D

@export var valor : int = 0
@export var frente : Texture2D

var boca_abajo := true

@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = load("res://assets/cards/dorso.png")

func revelar():
	boca_abajo = false
	sprite.texture = frente

func ocultar():
	boca_abajo = true
	sprite.texture = load("res://assets/cards/dorso.png")

func _input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			
			revelar()
			
