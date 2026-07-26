extends Node3D

func _ready() -> void:
	%EndControl.visible = false
	Globals.it_begins.connect(it_begins)
	pass

func it_begins(answer) -> void:
	%EndControl.visible = true
	
	#zander please do not judge this grotesque use of find child
	#i can never get fucking get child to work and navigating these via indexed get_child is too BUF BRAIN for me atm
	
	#container variables
	var accusedText = self.find_child("AccusedBox").get_child(1)
	var murdererText = self.find_child("MurderBox").get_child(1)
	var gradeText = self.find_child("GradeBox").get_child(1)
	var snarkText =self.find_child("SnarkBox").get_child(0)
	var resultText =self.find_child("Result")
	
	#string variable defaults
	var murderer = CharacterGlobals.murderer
	var result = "[rainbow]You Win![/rainbow]"
	var grade = "[rainbow]S[/rainbow]"
	var snark = "[wave]Whoa! You're a real life Columbo! Next time I lose the remote, I'll make sure to give you a call![/wave]"
	
	#calculate all the results
	if answer != murderer:
		result = "You Lose!"
		grade = "[color=crimson]F[/color]"
		snark = "[wave]Oof! Let the murderers get one over on ya, huh? Happens to the best of us. Not me, though. I'd just win![/wave]"
	
	#change all the text in the containers
	accusedText.text = answer
	murdererText.text = CharacterGlobals.murderer
	gradeText.text = grade
	snarkText.text = snark
	resultText.text = result
	
	pass
