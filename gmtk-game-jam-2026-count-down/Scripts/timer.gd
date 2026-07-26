extends Node3D

@onready var icon : MeshInstance3D = %Icon
var time1 = preload("res://Assets/Test/timers/progress_full.png")
var time2 = preload("res://Assets/Test/timers/progress_CW_75.png")
var time3 = preload("res://Assets/Test/timers/progress_CW_50.png")
var time4 = preload("res://Assets/Test/timers/progress_CW_25.png")
var time5 = preload("res://Assets/Test/timers/progress_empty.png")

var time_num : int = 0


func _ready() -> void:
	Globals.states.connect(set_state)
	Globals.timer_down.connect(sub_time)
	
	%Icon.mesh.material.albedo_texture = time1
	

func sub_time() -> void:
	print("Timer")
	time_num += 1
	match time_num % 5:
		0:
			%Icon.mesh.material.albedo_texture = time1
		1:
			%Icon.mesh.material.albedo_texture = time2
		2:
			%Icon.mesh.material.albedo_texture = time3
		3:
			%Icon.mesh.material.albedo_texture = time4
		4:
			%Icon.mesh.material.albedo_texture = time5
		_:
			print("you fucked up idiot")


func set_state(state) -> void:
	match state:
		"Move":
			icon.visible = true
		"Speak":
			icon.visible = true
		"Menu":
			icon.visible = false
