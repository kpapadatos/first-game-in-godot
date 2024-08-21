extends Unit

@onready var player = get_parent().get_parent().player 
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	animated_sprite.flip_h = player.position.x < position.x
	
	super._physics_process(_delta)
