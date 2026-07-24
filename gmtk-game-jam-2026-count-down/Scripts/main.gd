extends Node3D

@export_group("Initialization")
##Dictates the room the player starts in on scene start. 
##0: [ROOM1], 1: [ROOM2], 2: [ROOM3], 3: [ROOM4]
@export_range(0,3) var current_room : int = 0
##Dictates the remaining time blocks on scene start. Default is 16.
@export var current_time : int = 16

#init room vars
@onready var foyer : Node3D = %Foyer
@onready var kitchen : Node3D = %Kitchen
@onready var library : Node3D = %Library
@onready var garden : Node3D = %Garden

#Camera vars
@onready var camera : Camera3D = %PlayerCamera
@onready var target_position : Vector3 = camera.global_position
@onready var fade : ColorRect = %Fade
var trans_speed : float = 25.0
var trans_time : float = 0.25
@onready var active_room : Node3D = foyer
var target_room : Node3D
var mouse_pos : Vector2 = Vector2.ZERO

func _ready() -> void:
	#connect signals
	Globals.trans.connect(transition_to_room)
	Globals.states.connect(change_camera_state)
	
	#init start scenario
	Input.set_custom_mouse_cursor(Globals.arrow)
	mouse_pos = get_viewport().get_visible_rect().size / 2
	down_count()
	
	Globals.set_active_state(Globals.gamestate.MOVE)

#I don't think this block is needed at all, probably delete
func _process(_delta: float) -> void:
	#match active_state:
		#gamestate.MENU:
			#pass
		#gamestate.MOVE:
			#pass
		#gamestate.SPEAK:
			#pass
	pass

#handle literal movement between rooms
func transition_to_room(room : String) -> void:
	var target : Node3D
	
	#find correct node based on room name
	match room:
		"Foyer":
			target = foyer
		"Kitchen":
			target = kitchen
		"Library":
			target = library
		"Garden":
			target = garden
		_:
			target = foyer
	
	#assign node to target amd pull any necessary vars
	target_room = target
	camera.max_yaw = target.max_yaw
	
	#if is already in the target room do nothing. failsafe and ideally should never be called
	#after much testing, this is called all the time....... at least it works.....
	if target == active_room:
		#print("Error assigning target room.")
		return
	
	#move camera in the direction of the room
	#fade in black overlay over time to smooth transition
	var tween0 = create_tween()
	tween0.tween_property(camera, "global_position", target.camera_pos, trans_speed)
	
	await get_tree().create_timer(trans_time).timeout
	
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 1.0), trans_time)
	await tween.finished
	
	#move camera position to target room
	target.visible = true
	target.process_mode = Node.PROCESS_MODE_INHERIT
	tween0.stop()
	camera.global_position = target.camera_pos
	camera.start_basis = target.camera_basis
	active_room.visible = false
	active_room.process_mode = Node.PROCESS_MODE_DISABLED
	
	#fade out black overlay
	await get_tree().create_timer(trans_time).timeout
	
	var tween2 = create_tween()
	tween2.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 0.0), trans_time)
	await tween2.finished
	
	#set target room as active room
	active_room = target

#init the murder
func down_count() -> bool:
	assign_things()
	
	#pick random character to mark as culprit
	var pick : String = CharacterGlobals.characters.keys()[randi_range(0,3)]
	var murderer : Dictionary = CharacterGlobals.characters[pick]
	var rand_time : int = randi_range(0,2)
	var block : String = ""
	
	print("Murderer: ",pick, "\nLiar: ", CharacterGlobals.liar)
	
	match rand_time:
		0:
			block = "morning"
		1:
			block = "noon"
		2:
			block = "night"
		_:
			push_error("ERROR ASSIGNING MURDER TIME")
			get_tree().quit()
	
	CharacterGlobals.victim.has_met = false
	CharacterGlobals.victim.time_of_death = block
	CharacterGlobals.victim.murder_weapon = murderer["item"]
	CharacterGlobals.victim.in_room = murderer[block]
	
	CharacterGlobals.murderer = pick
	
	print(CharacterGlobals.victim)
	
	place_things()
	return true

func assign_things() -> void:
	var met : bool = false
		
	var rooms = CharacterGlobals.places.keys()
	rooms += rooms	#this allows up to 2 characters to be in 1 room. remove for 1 character per room
	rooms.shuffle()
	
	var activities : Dictionary = CharacterGlobals.activities
	var items := {}
	var hold := {}
	var retry := true
	
	#assign each activity a unique item
	while retry:
		items.clear()
		for activity in activities:
			retry = false
			var success = false
			hold.clear()
			var mix : Array = activities[activity].keys()
			mix.shuffle()
			
			for i in mix.size():
				hold[activity] = activities[activity][mix[i-1]]
				if hold[activity] not in items.values():
					items[activity] = activities[activity][mix[i-1]]
					success = true
					break
			if success:
				continue
			
			push_error("BAD")
			retry = true
			break
	
	#shuffle items/activities
	var shuffled_copy : Dictionary = {}
	var shuffled_keys : Array = items.keys()
	shuffled_keys.shuffle()
	
	for key in shuffled_keys:
		shuffled_copy[key] = items[key]
	
	items.clear()
	items.merge(shuffled_copy)
	
	print("ITEMS: ", items)
	
	#assign 1 random liar
	#lying array with 1 extra value to allow for nobody being the liar
	var lying : Array = [
		false,
		false,
		false,
		false,
		false
	]
	lying[randi_range(0,4)] = true
	
	#assign traits to characters
	var i : int = 0
	for character_name in CharacterGlobals.characters:
		var character = CharacterGlobals.characters[character_name]
		
		var act = items.keys()[i]
		var thing = items[act]
		var lie = lying[i]
		var time1 = CharacterGlobals.places.keys()[randi_range(0,3)]
		var time2 = CharacterGlobals.places.keys()[randi_range(0,3)]
		var time3 = CharacterGlobals.places.keys()[randi_range(0,3)]
		
		character.has_met = met
		character.is_lying = lie
		character.activity = act
		character.item = thing
		
		character.morning = time1
		character.noon = time2
		character.night = time3
		
		character.in_room = rooms[i]
		
		print(character_name, ": ", CharacterGlobals.characters[character_name])
		
		if character.is_lying:
			CharacterGlobals.liar = character_name
			
		i += 1
	
	#verify everyone is different
	var check : Dictionary = {}
	
	for char_name in CharacterGlobals.characters:
		var chara = CharacterGlobals.characters[char_name]
		
		var check_value = [
			chara["activity"],
			chara["morning"],
			chara["noon"],
			chara["night"]
		]
	
		if check.has(check_value):
			print(char_name, " matches ", check[check_value])
		else:
			check[check_value] = char_name
	
	#reset rooms array for reuse
	rooms = CharacterGlobals.places.keys()
	rooms.shuffle()
	
	#assign items to rooms
	i = 0
	for rm in rooms:
		CharacterGlobals.places[rm] = items[items.keys()[i]]
		
		i += 1
	
	print(CharacterGlobals.places)

func place_things() -> void:
	var characters : Array = %Characters.get_children()
	
	for nodes in characters:
		var room_name : String = "%" + CharacterGlobals.characters[nodes.name].in_room
		var room_node : Node3D = get_node(room_name)
		
		if room_node.is_placed:
			nodes.global_position = room_node.char_pos2
		else:
			nodes.global_position = room_node.char_pos1
	
	#place body in murder room
	#randomly place all other characters
	#make those characters children of their assigned rooms
	#set starting room for player (active_room)
	pass

func change_camera_state(state):
	match state:
		"Move":
			camera.process_mode = Node.PROCESS_MODE_ALWAYS
			Input.warp_mouse(mouse_pos)
		"Speak":
			camera.process_mode = Node.PROCESS_MODE_DISABLED
			mouse_pos = get_viewport().get_mouse_position()
		"Menu":
			pass
	
