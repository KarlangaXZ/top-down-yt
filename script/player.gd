class_name Player extends CharacterBody2D

@onready var sprite_animation: AnimatedSprite2D = $AnimatedSprite2D

var move_speed := 100
var attact_damage := 50
var is_attack := false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true:
				attack()


func attack():
	sprite_animation.play("attack")
	is_attack = true



func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
