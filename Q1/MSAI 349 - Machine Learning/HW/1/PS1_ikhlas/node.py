class Node:
  def __init__(self):
    self.label = None
    self.children = {}

  def set_lable(self,label):
      self.label = label

  def get_lable(self):
      return self.lable

  def set_children(self,child,value):
      self.children[child] = value
