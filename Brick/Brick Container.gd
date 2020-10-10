extends Node2D

onready var Brick = load("res://Brick/Brick.tscn")
var rows = 7
var columns = 7

onready var VP = get_viewport_rect().size
var B = Vector2(100,50)


var Levels = [
	[
		[0, 0, 0, 0, 0, 0, 0]
		,[5, 5, 5, 5, 5, 5, 5]
		,[4, 4, 4, 4, 4, 4, 4]
		,[3, 3, 0, 0, 0, 3, 3]
		,[2, 2, 0, 0, 0, 2, 2]
	]
	,[
		[0, 0, 0, 0, 0, 0, 0]
		,[5, 5, 5, 5, 5, 5, 5]
		,[4, 4, 0, 0, 0, 4, 4]
		,[3, 3, 0, 0, 0, 3, 3]
		,[2, 2, 2, 2, 2, 2, 2]
	]
	,[
		[0, 0, 0, 0, 0, 0, 0]
		,[5, 5, 0, 5, 0, 5, 5]
		,[4, 0, 4, 0, 4, 0, 4]
		,[3, 3, 0, 3, 0, 3, 3]
		,[2, 2, 2, 2, 2, 2, 2]
	]
]



func _ready():
	start()


func _physics_process(_delta):
	if get_child_count() == 0:
		Global.update_level(1)
		if Global.level == 2:
			get_tree().change_scene("res://HUD/GameOver.tscn")
		else:
			start()
	


func start():
	for c in get_node("/root/Game/Ball Container").get_children():
		c.queue_free()
	for c in get_children():
		c.queue_free()
		
	var level = Levels[Global.level]
	var startx = (VP.x / 2) - ((B.x) * (level[0].size()/2))
	var starty = 20
	for r in range(level.size()):
		for c in range(level[r].size()):
			var strength = level[r][c]
			if strength > 0:
				
				var x = startx + (c * B.x)
				var y = starty + (r * B.y)
				var brick = Brick.instance()
				brick.position = Vector2(x,y)
				brick.set_strength(strength)
				add_child(brick)


		
func _on_AudioStreamPlayer2D_finished():
	pass # Replace with function body.
