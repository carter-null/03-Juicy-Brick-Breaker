extends RigidBody2D

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(_delta):
	var bodies = get_colliding_bodies()
	for body in bodies: 
		if body.get_parent().name == "Paddle":
			
