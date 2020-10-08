extends Node

onready var HUD = get_node("/root/Game/HUD")
onready var Camera1 = get_node("/root/Game/Camera")
onready var Camera2 = get_node("/root/Game/HUD/Camera")
onready var WE = get_node("/root/Game/WorldEnvironment")

func _process(_delta):
	if Input.is_action_just_pressed("menu"):	
		if HUD.visible:
			HUD.hide()
			Camera2.current = false
			Camera1.current = true
			WE.show()
		else:
			HUD.show()
			Camera1.current = false
			Camera2.current = true
			WE.hide()
