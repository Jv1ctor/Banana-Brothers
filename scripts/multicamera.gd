extends Camera2D

@export var move_speed := 0.5
@export var zoom_speed := 0.05
@export var min_zoom := 0.5
@export var max_zoom := 5.0
@export var margin := Vector2(100, 25)

var players = []
var debug_rect := Rect2()

@onready var screen_size = get_viewport_rect().size

func add_player(player):
	if not player in players:
		players.append(player)

func remove_player(player):
	if player in players:
		players.erase(player)

func _process(delta):
	if players.is_empty():
		return
	
	var pos = Vector2.ZERO
	for player in players:
		pos += player.position
	pos /= players.size()
	position = lerp(position, pos, move_speed)

	#Cria o retângulo de bounding box
	var rect = Rect2(players[0].position, Vector2.ZERO)
	for player in players:
		rect = rect.expand(player.position)
	rect = rect.grow_individual(margin.x, margin.y, margin.x, margin.y)
	debug_rect = rect  # Atualiza o retângulo para desenhar
	
	var scale_x = screen_size.x / rect.size.x
	var scale_y = screen_size.y / rect.size.y
	var zoom_range = min(scale_x, scale_y)
	zoom_range = clamp(zoom_range, min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2(zoom_range, zoom_range), zoom_speed)
	
	#queue_redraw()  # Solicita que _draw() seja chamado

func _draw():
	# Desenha o retângulo de debug em vermelho semi-transparente
	var local_rect = Rect2(
		to_local(debug_rect.position),
		debug_rect.size
	)
	draw_rect(local_rect, Color(1, 0, 0, 0.3), false, 2)
