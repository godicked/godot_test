extends Area2D


export var speed = 300
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_area_entered(area):
	if area.get_node('CollisionShape2D').disabled:
		return
	area.get_node('CollisionShape2D').set_deferred('disabled', true)
	call_deferred('set_parent', area)

func set_parent(node):
	var pos = node.get_global_position()
	node.get_parent().remove_child(node)
	self.add_child(node)
	node.set_global_position(pos)
	
