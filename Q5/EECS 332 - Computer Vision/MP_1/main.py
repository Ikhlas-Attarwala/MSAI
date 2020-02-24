import numpy as np
import matplotlib.pyplot as plt
import numbers

from PIL import Image


class Node:
	def __init__(self, val):
		self.val = val
		self.next = None

	def root(self):
		node = self
		roots = []
		while node != None:
			roots.append(node.val)
			node = node.next
		self.length = len(roots)
		return roots[-1]

	def count(self):
		self.root()
		return self.length


# node1 = Node(1)
# node2 = Node(10)
# node3 = Node(100)

# node2.next = node1
# node3.next = node2


def label_everything(img_string):
	img = Image.open(img_string)
	img_2d = np.asarray(img).astype(int)

	g = {}
	label_group = 0
	for row in range(0, len(img_2d)):
		for col in range(0, len(img_2d[row])):
			# black background
			if img_2d[row][col] == 0:
				g[(row, col)] = 'x'
			# object
			elif img_2d[row][col] == 1:
				# if left is something and top is something
				if type(g[(row, col - 1)]) == int and type(g[(row - 1, col)]) == int:
					if g[(row, col - 1)] != g[(row - 1, col)]:
						if g[(row, col - 1)] < g[(row - 1, col)]:
							g[(row, col)] = g[(row, col - 1)]
						elif g[(row - 1, col)] < g[(row, col - 1)]:
							g[(row, col)] = g[(row - 1, col)]
					else:
						g[(row, col)] = g[(row, col - 1)]
				# if left is nothing and top is something
				elif type(g[(row, col - 1)]) != int and type(g[(row - 1, col)]) == int:
					g[(row, col)] = g[(row - 1, col)]
				# if left is something and top is nothing
				elif type(g[(row, col - 1)]) == int and type(g[(row - 1, col)]) != int:
					g[(row, col)] = g[(row, col - 1)]
				# if both above and to the right are nothing
				elif g[(row, col - 1)] not in g.keys() and g[(row - 1, col)] not in g.keys() or type(
						g[(row, col - 1)]) != int and type(g[(row - 1, col)]) != int:
					label_group += 1
					g[(row, col)] = label_group

	all_groups = [*set(g.values())]
	num_groups = [num for num in all_groups if isinstance(num, (int))]

	d = {each: each for each in num_groups}

	return g, d


def nodeit(graph, dictionary):
	d = dictionary
	g = graph

	Node_dic = {}
	for each in (set(d.values())):
		Node_dic[each] = Node(each)

	for each_num in set(d.values()):
		for each in {k: v for k, v in g.items() if v == each_num}:
			# left
			if type(g[(each[0], each[1] - 1)]) == int and g[(each[0], each[1] - 1)] != g[(each[0], each[1])]:
				if g[(each[0], each[1] - 1)] < g[(each[0], each[1])]:
					Node_dic[g[(each[0], each[1])]].next = Node_dic[g[(each[0], each[1] - 1)]]
				else:
					Node_dic[g[(each[0], each[1] - 1)]].next = Node_dic[g[(each[0], each[1])]]
			# right
			elif type(g[(each[0], each[1] + 1)]) == int and g[(each[0], each[1] + 1)] != g[(each[0], each[1])]:
				if g[(each[0], each[1] + 1)] < g[(each[0], each[1])]:
					Node_dic[g[(each[0], each[1])]].next = Node_dic[g[(each[0], each[1] + 1)]]
				else:
					Node_dic[g[(each[0], each[1] + 1)]].next = Node_dic[g[(each[0], each[1])]]
			# top
			elif type(g[(each[0] - 1, each[1])]) == int and g[(each[0] - 1, each[1])] != g[(each[0], each[1])]:
				if g[(each[0] - 1, each[1])] < g[(each[0], each[1])]:
					Node_dic[g[(each[0], each[1])]].next = Node_dic[g[(each[0] - 1, each[1])]]
				else:
					Node_dic[g[(each[0] - 1, each[1])]].next = Node_dic[g[(each[0], each[1])]]
			# bottom
			elif type(g[(each[0] + 1, each[1])]) == int and g[(each[0] + 1, each[1])] != g[(each[0], each[1])]:
				if g[(each[0] + 1, each[1])] < g[(each[0], each[1])]:
					Node_dic[g[(each[0], each[1])]].next = Node_dic[g[(each[0] + 1, each[1])]]
				else:
					Node_dic[g[(each[0] + 1, each[1])]].next = Node_dic[g[(each[0], each[1])]]

	for each in {k: v for k, v in g.items() if type(v) == int}:
		g[each] = Node_dic[g[each]].root()

	return g


def graph_normal(img_string):
	img = Image.open(img_string)
	img_update = np.asarray(img).astype(int)

	g = nodeit(label_everything(img_string)[0], label_everything(img_string)[1])

	for each in g.keys():
		if type(g[each]) == int:
			img_update[each[0], each[1]] = g[each]

	plt.imshow(img_update)
	plt.show()


def size_filter(num, img_string):
	img = Image.open(img_string)
	img_update = np.asarray(img).astype(int)

	g = nodeit(label_everything(img_string)[0], label_everything(img_string)[1])

	for each in g.keys():
		if type(g[each]) == int:
			img_update[each[0], each[1]] = g[each]

	lis = [x for x in [*set(g.values())] if isinstance(x, numbers.Number)]

	d = {}
	for each in lis:
		d[each] = img_update.flatten().tolist().count(each)
	for each in d:
		if d[each] < num:
			d[each] = 0

	for each in d.items():
		if each[1] == 0:
			img_update[img_update == each[0]] = 0

	plt.imshow(img_update)
	plt.show()


if __name__ == "__main__":
	graph_normal(img_string='test.bmp')

if __name__ == "__main__":
	graph_normal(img_string='face.bmp')

if __name__ == "__main__":
	graph_normal(img_string='face_old.bmp')

if __name__ == "__main__":
	graph_normal(img_string='gun.bmp')

if __name__ == "__main__":
	size_filter(num=400, img_string='gun.bmp')
