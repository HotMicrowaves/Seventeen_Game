extends Node2D

var is_dragging
var occupying
var slots = [1, 2, 3, 4, 5]
var draggable
var energy = 3
var moveable = false
var Player_HP = 50
var Max_HP = 50
var Player_Shield = 0
var Max_Shield = 0
var card_counter = 0
var opp_counter = 0
var enemy_target = null
var stage = 1
var can_end_turn = false
var can_target = false
var animating = false
var level = 5
var XP = 0
var last
var skip_tutorial = false
var Player_Damage = 1
var Shield_Modifier = 1
var Volume = 0
var over_equals = false
var turns = 1
var first_enter = true
var in_tutorial = false
