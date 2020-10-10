extends AudioStreamPlayer


func _ready():
	pass


func _on_Ball_body_entered(body):
	load("res://Audio/ballsound.wav")
