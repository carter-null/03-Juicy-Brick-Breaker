extends Node2D

onready var Powerup = load("res://Powerup/Powerup.tscn")
export var powerup_prob = 0.07

func _ready():
	randomize()

func add_powerup(pos):
	if randf() < powerup_prob:
		var powerup = Powerup.instance()
		powerup.position = pos
		add_child(powerup)

func add_payload(payload):
	for c in get_children():
		if "payload_type" in c and c.payload_type == payload.payload_type:
			c.queue_free()
	add_child(payload)
	payload.get_node("Timer").start()
	payload.enable_payload()

