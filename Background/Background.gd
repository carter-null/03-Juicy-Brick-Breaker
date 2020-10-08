extends ColorRect

onready var HUD = get_node("/root/Game/HUD")
var c = 0
var colors = [
	Color8(280,0,0)		#red0
	,Color8(250,0,0)		#red1
	,Color8(220,0,0)		#red2
	,Color8(190,0,0)		#red3
	,Color8(160,0,0)		#red4
	,Color8(130,0,0)		#red5
	,Color8(100,0,0)		#red6
	,Color8(100,0,0)	
	,Color8(70,0,0)		#red7
	,Color8(40,0,0)		#red8
	,Color8(100,0,0)		#red6
	,Color8(130,0,0)		#red5
	,Color8(160,0,0)		#red4
	,Color8(190,0,0)		#red3
	,Color8(220,0,0)		#red2
	,Color8(250,0,0)		#red1
	,Color8(280,0,0)		#red0
]


func _ready():
	HUD.connect("changed",self,"_on_HUD_changed")
	update_color()


func update_color():
	if HUD.color_background:
		$Tween.interpolate_property(self, "color", color, colors[c], $Timer.wait_time-0.01, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		color = Color(0,0,0,1)

func _on_HUD_changed():
	update_color()


func _on_Timer_timeout():
	if HUD.color_background:
		c += 1
		c %= colors.size()
		update_color()
