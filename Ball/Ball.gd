extends RigidBody2D

onready var VP = get_viewport_rect().size
var speed = 400
export var min_speed = 100.0
export var max_speed = 1000.0
var collided = false
export var speedup = 1.05


var released = false

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	if not released:
		mode = RigidBody2D.MODE_KINEMATIC


func release_ball():
	released = true
	mode = RigidBody2D.MODE_RIGID
	var impulse = Vector2.RIGHT*speed
	impulse = impulse.rotated(randf()*-PI)
	apply_central_impulse(impulse)



func _physics_process(_delta):
	var paddle = get_node("/root/Game/Paddle Container/Paddle") #delete if needed
	if not released:
		position = paddle.position
		position.y -= 5
	else:
		if position.y > VP.y + 30:
			die()
		
		var bodies = get_colliding_bodies()
		for body in bodies:
			collided = true
			if body.get_parent().name == "Paddle Container":
				$AnimatedSprite.play("hit")
				body.find_node("AnimatedSprite").play("hit")
			if body.is_in_group("brick"):
				body.damage(1)
	if Input.is_action_just_pressed("release") and not released:
		release_ball()
		

func _integrate_forces(state):
	if collided:
		state.linear_velocity *= speedup
		collided = false
	if abs(state.linear_velocity.x) < min_speed:
		state.linear_velocity.x = sign(state.linear_velocity.x) * min_speed
	if abs(state.linear_velocity.x) > max_speed:
		state.linear_velocity.x = sign(state.linear_velocity.x) * max_speed
	if abs(state.linear_velocity.y) < min_speed:
		state.linear_velocity.y = sign(state.linear_velocity.y) * min_speed
	if abs(state.linear_velocity.y) > max_speed:
		state.linear_velocity.y = sign(state.linear_velocity.y) * max_speed
	if collided:
		emit_signal("ballsound", self)

func die(): 
	Global.update_lives(-1)
	queue_free()


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("default")



func _on_AudioStreamPlayer2D_finished():
	if collided == true:
		load("/Audio/ballsound.wav")
	else:
		pass

func play_sound():
	if collided:
		load("res://Audio/ballsound.wav")

func _on_AudioStreamPlayer_finished():
	if collided:
		play_sound()
		

