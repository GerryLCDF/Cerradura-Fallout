extends Control

@onready var ganzua : Sprite2D = $ganzua
@onready var destornillador : Sprite2D = $destornillador
@onready var animator : AnimationPlayer = $animacion
@onready var vida : Label =$Label/vidas
@onready var solucion : float
@export var vidas : int=3##Aqui definimos cuantas oportunidades tendra para intentar abrir
var acertado := false

func _ready() -> void:
	randomize()
	solucion = randf_range(-3.0, +0) 
	animator.play("Inicio")
	ganzua.global_rotation = -1
	print("Solución:", solucion)
	vida.text= str(vidas)


func _process(delta: float) -> void:
	if !acertado:
		limitar()
		deteccion_correcta()

func limitar():
	if Input.is_action_pressed("left"):
		ganzua.global_rotation-=.1
		if ganzua.global_rotation <= -3:
			ganzua.global_rotation=-3
		
	if Input.is_action_pressed("right"):
		ganzua.global_rotation+=.1
		if ganzua.global_rotation >= 0:
			ganzua.global_rotation=0
	pass

func _probar_animacion() -> void:
	animator.play("probar")
	await get_tree().create_timer(.50).timeout
	animator.stop()

func deteccion_correcta():
	var margen := 0.1
	if abs(ganzua.global_rotation - solucion) <= margen:
		if Input.is_action_just_pressed("acept"):
			animator.play("correct")
			acertado = true
	else:
		if Input.is_action_just_pressed("acept"):
			_probar_animacion()
			vidas -= 1
			if vidas < 0:
				vidas = 0
			vida.text = str(vidas)
		
	
