extends Control

var color_paddle = false
var color_ball = false
var color_blocks = false
var color_background = false

var particle_paddle = false
var particle_walls = false
var particle_blocks = false
var particle_ball = false

var blocks_appear = true
var blocks_fall = false
var blocks_fade = false

var screen_shake = 50
var ball_trail = false

var paddle_appear = true
var paddle_stretch = false
var paddle_face = false

var audio_music = false
var audio_effects = false

var effects_blur = false


signal changed

func _ready():
	$Menu/Blocks/Blocks_Appear.pressed = true
	$Menu/Blocks/Blocks_Fall_and_Fade.pressed = true
	$Menu/Paddle/Paddle_Appear.pressed = true
	$Menu/Paddle/Paddle_Stretch.pressed = true
	$Menu/Color/Color.pressed = true
	$Menu/Particles/Particles.pressed = true
	$Menu/Ball/Screen_Shake.value = screen_shake

func reset_values():
	emit_signal("changed")


func _on_Reset_pressed():
	get_node("/root/Game/Bricks").start_bricks()
	get_node("/root/Game/Ball_Container").start_ball()
	get_node("/root/Game/Paddle_Container/Paddle").start_paddle()
	reset_values()


func _on_Quit_pressed():
	get_tree().quit()



func _on_Color_toggled(button_pressed):
	color_paddle = button_pressed
	color_ball = button_pressed
	color_blocks = button_pressed
	color_background = button_pressed
	emit_signal("changed")



func _on_Particles_toggled(button_pressed):
	particle_paddle = button_pressed
	particle_walls = button_pressed
	particle_blocks = button_pressed
	particle_ball = button_pressed
	emit_signal("changed")


func _on_Blocks_Appear_toggled(button_pressed):
	blocks_appear = button_pressed
	emit_signal("changed")

func _on_Blocks_Fall_and_Fade_toggled(button_pressed):
	blocks_fall = button_pressed
	blocks_fade = button_pressed
	emit_signal("changed")



func _on_Screen_Shake_value_changed(value):
	screen_shake = value
	emit_signal("changed")

func _on_Ball_Trail_toggled(button_pressed):
	ball_trail = button_pressed
	emit_signal("changed")



func _on_Paddle_Appear_toggled(button_pressed):
	paddle_appear = button_pressed
	emit_signal("changed")

func _on_Paddle_Stretch_toggled(button_pressed):
	paddle_stretch = button_pressed
	emit_signal("changed")

func _on_Paddle_Face_toggled(button_pressed):
	paddle_face = button_pressed
	emit_signal("changed")





func _on_Audio_music_toggled(button_pressed):
	audio_music = button_pressed
	emit_signal("changed")


func _on_Audio_effects_toggled(button_pressed):
	audio_effects = button_pressed
	emit_signal("changed")


func _on_Effects_blur_toggled(button_pressed):
	effects_blur = button_pressed
	emit_signal("changed")
