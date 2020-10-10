extends RigidBody2D



onready var VP = get_viewport_rect().size
var powerup_type = 0



func _ready():
	randomize()
	choose_payload()
	contact_monitor = true
	set_max_contacts_reported(4)
	$Sprite.region_rect = Rect2(50*powerup_type, 0, 50, 50)

func choose_payload():
	powerup_type = randi() % 2
	$Payload.payload_type = powerup_type


func _physics_process(_delta):
	if position.y > VP.y + 30:
		queue_free()


	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.get_parent().name == "Paddle Container":
			var payload = $Payload
			remove_child($Payload)
			get_node("/root/Game/Powerup Container").add_payload(payload)
			queue_free()

