extends Node

@export var player_char : Node
@export var enemy_char : Node
var cur_char : Character

@export var next_turn_delay : float = 1.0

var game_over : bool = false

signal character_begin_turn(character)
signal character_end_turn(character)

func _ready():
	await get_tree().create_timer(0.5).timeout
	begin_next_turn()

func begin_next_turn():
	if cur_char == player_char:
		cur_char = enemy_char
		
	elif cur_char == enemy_char:
		cur_char = player_char
		print("Enemy turn")
	else:
		cur_char = player_char
		print("Player turn")
		
		print(cur_char)
	emit_signal("character_begin_turn", cur_char)
	
	
func end_current_turn():
	emit_signal("character_end_turn", cur_char)
	await get_tree().create_timer(next_turn_delay).timeout
	
	if game_over == false:
		begin_next_turn()

func character_died(character):
	game_over = true
	
	if character.is_player == true:
		print("Game Over")
	else:
		print("You Win!")
