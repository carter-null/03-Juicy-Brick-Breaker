extends KinematicBody2D

onready var VP = get_viewport()
onready var VP_size = get_viewport_rect().size
export var paddle_speed = 30

func _ready():
	position.y = VP_size.y - 75


func _physics_process(_delta):
	var target = VP.get_mouse_position().x
	target = clamp(target, 0, VP_size.x)
	var d = (target - position.x)
	var s = sign(d)
	if abs(d) > paddle_speed:
		position.x += s*paddle_speed
	else:
		position.x += d


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("default")


func _on_AudioStreamPlayer_finished():
	pass # Replace with function body.
