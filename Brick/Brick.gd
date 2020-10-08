extends KinematicBody2D

onready var HUD = get_node("/root/Game/HUD")
onready var target_y = position.y

var row = 0
var col = 0

export var appear_speed = 3
export var fall_speed = 1.0

var dying = false

var colors = [
	Color8(250,0,0)		#DarkRed
	,Color8(220,0,0)		#Violet
	,Color8(190,0,0)		#DarkRed
	,Color8(160,0,0)		#Violet
	,Color8(130,0,0)		#DarkRed
	,Color8(100,0,0)		#Violet
	,Color8(70,0,0)		#DarkRed
]
onready var textures = [
	load("res://Assets/brickparticle.png")
]

func _ready():
	randomize()
	HUD.connect("changed",self,"_on_HUD_changed")
	update_color()

func _process(_delta):
	if dying and not $Particles2D.emitting and not $Tween.is_active() and not $Color_Tween.is_active():
		queue_free()


func start_brick():
	if HUD.blocks_appear:
		var target_pos = position
		var appear_duration = randf()*appear_speed + 1.0
		position.y = -100
		$Tween.interpolate_property(self, "position", position, target_pos, appear_duration, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		position = Vector2(position.x,target_y)





func update_color():
	if HUD.color_blocks:
		if row >= 0 and row < colors.size():
			$Color.color = colors[row]
	else:
		$Color.color = Color(1,1,1,1)

func emit_particle(pos):
	if HUD.particle_blocks:
		$Particles2D.texture = textures[randi() % textures.size()]
		$Particles2D.emitting = true
		$Particles2D.global_position = pos
	
	
func _on_HUD_changed():
	update_color()


func die():
	dying = true
	var target_color = $Color.color.darkened(0.75)
	target_color.a = 0
	var fall_duration = randf()*fall_speed + 1

	if HUD.blocks_fall:
		var target_pos = position
		target_pos.y = 1000
		$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$Tween.start()
	if HUD.blocks_fade:
		$Tween.interpolate_property($Color, "color", $Color.color, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
	if not HUD.blocks_fall and not HUD.blocks_fade:
		$Color.color = target_color


	collision_layer = 0
	collision_mask = 0
