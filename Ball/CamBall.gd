# Extraido do demo oficial 3D Platformer Demo, texto da licença original a seguir

# Copyright (c) 2007-2016 Juan Linietsky, Ariel Manzur.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

extends Camera

# Member variables
var collision_exception = []
export var min_distance = 0.5
export var max_distance = 4.0
export var angle_v_adjust = 0.0
export var autoturn_ray_aperture = 25
export var autoturn_speed = 50
var max_height = 2.0
var min_height = 1.0

func _physics_process(dt):
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3(0, 1, 0)

	var delta = pos - target

	# Regular delta follow

	# Check ranges
	if (delta.length() < min_distance):
		delta = delta.normalized()*min_distance
	elif (delta.length() > max_distance):
		delta = delta.normalized()*max_distance

	# Check upper and lower height
	if (delta.y > max_height):
		delta.y = max_height
	if (delta.y < min_height):
		delta.y = min_height

	# Check autoturn
	var ds = PhysicsServer.space_get_direct_state(get_world().get_space())

	var col_left = ds.intersect_ray(target, target + Basis(up, deg2rad(autoturn_ray_aperture)).xform(delta), collision_exception)
	var col = ds.intersect_ray(target, target + delta, collision_exception)
	var col_right = ds.intersect_ray(target, target + Basis(up, deg2rad(-autoturn_ray_aperture)).xform(delta), collision_exception)

	if (!col.empty()):
		# If main ray was occluded, get camera closer, this is the worst case scenario
		delta = col.position - target
	elif (!col_left.empty() and col_right.empty()):
		# If only left ray is occluded, turn the camera around to the right
		delta = Basis(up, deg2rad(-dt*autoturn_speed)).xform(delta)
	elif (col_left.empty() and !col_right.empty()):
		# If only right ray is occluded, turn the camera around to the left
		delta = Basis(up, deg2rad(dt*autoturn_speed)).xform(delta)
	else:
		# Do nothing otherwise, left and right are occluded but center is not, so do not autoturn
		pass

	# Apply lookat
	if (delta == Vector3()):
		delta = (pos - target).normalized()*0.0001

	pos = target + delta

	look_at_from_position(pos, target, up)

	# Turn a little up or down
	var t = get_transform()
	t.basis = Basis(t.basis[0], deg2rad(angle_v_adjust))*t.basis
	set_transform(t)


func _ready():
	# Find collision exceptions for ray
	var node = self
	while(node):
		if (node is RigidBody):
			collision_exception.append(node.get_rid())
			break
		else:
			node = node.get_parent()
	set_physics_process(true)
	# This detaches the camera transform from the parent spatial node
	set_as_toplevel(true)
