extends Node

var liar : String = ""
var murderer : String = ""


var characters : Dictionary = {
	"Clay": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": ""
	},
	
	"2": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": ""
	},
	
	"3": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": ""
	},
	
	"4": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": ""
	}
}

var activities : Dictionary = {
	"Fishing": {
		1: "Fish1",
		2: "Fish2",
		3: "Fish3"
	},
	"Cooking": {
		1: "Cook1",
		2: "Cook2",
		3: "Cook3"
	},
	"Gardening": {
		1: "Garden1",
		2: "Garden2",
		3: "Garden3"
	},
	"Dressing up": {
		1: "Dress1",
		2: "Dress2",
		3: "Dress3"
	}
}

var places : Array = [
	"Foyer",
	"Garden",
	"Kitchen",
	"Library"
]
