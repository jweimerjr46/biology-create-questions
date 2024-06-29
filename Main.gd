extends Control

@onready var question_text = $MarginContainer/HBoxContainer/VBoxContainer2/TextEdit
@onready var option_1 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Option1
@onready var option_2 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/Option2
@onready var option_3 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/Option3
@onready var option_4 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/Option4
@onready var option_1_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Option1CheckBox
@onready var option_2_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/Option2CheckBox
@onready var option_3_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/Option3CheckBox
@onready var option_4_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/Option4CheckBox
@onready var xp_text = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer6/XPEdit
@onready var level_text = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer6/LevelEdit
@onready var code_text = $MarginContainer/HBoxContainer/VBoxContainer/CodeEdit
@onready var preview_text = $MarginContainer/HBoxContainer/VBoxContainer/PreviewEdit
# Called when the node enters the scene tree for the first time.


func _ready():
	var python_keywords = [
	"False", "None", "True", "and", "as", "assert", "async", "await", "break", "class", 
	"continue", "def", "del", "elif", "else", "except", "finally", "for", "from", "global", 
	"if", "import", "in", "is", "lambda", "nonlocal", "not", "or", "pass", "raise", "return", 
	"try", "while", "with", "yield"
]

	# adds keywords and color for keywords
	for keyword in python_keywords:
		code_text.syntax_highlighter.add_keyword_color(keyword, Color("#569cd6"))

	# formats strings
	code_text.syntax_highlighter.add_color_region('"', '"', Color("#fff980"))
	code_text.syntax_highlighter.add_color_region("'", "'", Color("#fff980"))

	# formats comments
	code_text.syntax_highlighter.add_color_region('#', '', Color("#d1d1d1"))

'''


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
'''

func _on_create_question_button_pressed():
	if option_1_checkbox.is_pressed() or option_2_checkbox.is_pressed() or option_3_checkbox.is_pressed() or option_4_checkbox.is_pressed():
		var correct_answer = ""
		if option_1_checkbox.is_pressed():
			correct_answer = option_1.text
		elif option_2_checkbox.is_pressed():
			correct_answer = option_2.text
		elif option_3_checkbox.is_pressed():
			correct_answer = option_3.text
		elif option_4_checkbox.is_pressed():
			correct_answer = option_4.text
		else:
			print("You have not selected anything")		
		var question = { "question":question_text.text,
		 "options":[option_1.text, option_2.text, option_3.text, option_4.text],
		"correct": correct_answer, "xp": xp_text.text, "level": level_text.text, "code": code_text.text}
		var json_string = JSON.stringify(question, "\t")
		print(json_string)
		var json = JSON.new()
		json.parse(json_string)
		print(json.data)
		preview_text.text = json_string
	else:
		print("You have not checked an answer")
