extends Control


var questions
var qindex = 0


onready var qtext = $VBoxContainer/MCTrivia/VBoxContainer2/Qtext
onready var atexts = [$VBoxContainer/MCTrivia/VBoxContainer2/VBoxContainer/A1, 
$VBoxContainer/MCTrivia/VBoxContainer2/VBoxContainer/A2, 
$VBoxContainer/MCTrivia/VBoxContainer2/VBoxContainer/A3, 
$VBoxContainer/MCTrivia/VBoxContainer2/VBoxContainer/A4]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_trivia()
	show_trivia(qindex)
	show_note()
	

func load_trivia():
	var file = File.new()
	file.open('res://trivia.res', File.READ)
	questions = JSON.parse(file.get_as_text())
	file.close()

func show_trivia(idx):
	qtext.text = questions.result[idx]['question']
	# you could do some cool things with flat buttons and shuffle the correct answers here, up to you!
	# the thing to do might be to make an array of clickable buttons with the texts, hook up the buttons to the 
	# correct success/failure functions, then shuffle them.  I'm just setting labels
	questions.result[idx]['answers'].shuffle()
	for i in range(4):
		atexts[i].text = questions.result[idx]['answers'][i]


func _on_Next_pressed():
	qindex+= 1
	qindex %= len(atexts)
	show_trivia(qindex)


func _on_Prev_pressed():
	qindex -= 1
	if qindex < 0:
		qindex = len(atexts)-1
	show_trivia(qindex)
	
func show_note():
	var file = File.new()
	file.open('note.res', File.READ)
	$Message.text = file.get_as_text()
	file.close()
