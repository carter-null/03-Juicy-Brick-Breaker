extends AudioStreamPlayer


func _ready():
	pass

func play_music():
	if playing:
		playing = true
	elif not playing:
		playing = false
	else: 
		playing = true
		


func _on_Theme_finished():
	playing = true
