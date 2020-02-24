from node import Node
import math, random, parse
from copy import deepcopy


def entropy(catg, count):
    # This function will be called for each category within the feature; returns entropy of catg not the entropy of the feature
    # Or entropy of the complete dataset

    final_entropy = 0
    for catg_key, catg_value in catg.items():
        final_entropy += (-(catg_value / count) * math.log2(catg_value / count))
    return final_entropy


def info_gain(catg, class_entropy, count):
    # Loop through each category in the feature and sum up to total entropy of the feature, and returns the information gain

    feature_entropy = 0
    for catg_key, catg_value in catg.items():
        feature_count = sum(catg_value.values())
        feature_entropy += (feature_count / count) * entropy(catg_value, feature_count)
    return class_entropy - feature_entropy


def best_feature(examples):
    info_max = -1
    classify = {}
    class_catg = {}

    # calcualte the total entropy of the examples set under the splitted data
    count = 0
    for example in examples:
        if not example['Class'] in class_catg:
            class_catg[example['Class']] = 1
        else:
            class_catg[example['Class']] += 1
        count += 1
    class_entropy = entropy(class_catg, count)

    # use the information gain on each feature and picks the best feature
    for feature in list(examples[0])[:]:

        if feature != 'Class':

            catg = {}
            classify_feature = {}

            for example in examples:

                if not example[feature] in catg:
                    catg[example[feature]] = {}
                    classify_feature[example[feature]] = []

                # categorizing lables as keys in the dictonary to calculate entropy and information gain
                if example[list(example.keys())[-1]] not in catg[example[feature]]:
                    catg[example[feature]][example['Class']] = 1
                else:
                    catg[example[feature]][example['Class']] += 1

                classify_feature[example[feature]].append(example)

            gain = info_gain(catg, class_entropy, count)
            if gain > info_max:
                info_max = gain
                best_feature = feature
                classify = classify_feature

    return [best_feature, classify]


def ID3(examples, default):
    runtime_examples = deepcopy(examples)
    node = Node()

    # base case - if no examples then return default
    if len(runtime_examples) == 0:
        node.label = 0
        node.children = None
        return node

    # non-trivial case - if only one example or all the class variables are same then return the class variable
    elif len(runtime_examples) == 1 or len(set([example['Class'] for example in runtime_examples])) == 1:
        node.label = runtime_examples[0]['Class']
        node.children = None
        return node
    else:
        split_feature = best_feature(runtime_examples)
        node.set_lable(split_feature[0])

        for split in split_feature[1]:
            for each_split in split_feature[1][split]:
                each_split.pop(split_feature[0], None)
            node.set_children(split, ID3(list(split_feature[1][split]), default))
        return node


def evaluate(node, example):
    if node.children is None:
        return node.label

    for node_key, node_value in node.children.items():
        if node_key == example[node.label]:
            return evaluate(node_value, example)


def test(node, examples):
    if examples is None:
        return 0
    else:
        total_examples = len(examples)
        total_predicted = 0

        # loop each example in a list and increment the total predicted by 1 if predicted value = class value
        for example in examples:
            keys = list(example.keys())
            predicted_value = evaluate(node,
                                       {key: value for key, value in example.items() if key in keys and key != 'Class'})

            if predicted_value == example['Class']:
                total_predicted += 1

        return total_predicted / total_examples


def prune(node, examples):
    node_hardcopy = deepcopy(node)
    node_softcopy = node
    accuracy = test(node_softcopy, examples)
    prune_sub(node,node_softcopy,node_hardcopy,examples,accuracy)



def prune_sub(node,node_softcopy,node_hardcopy,examples,accuracy):
    if node.children is None:
        return True
    else:
       for node_key, node_value in node.children.items():
         if prune_sub(node_value,node_softcopy,node_hardcopy,examples,accuracy):
            # find the best label from the examples to replace the node
            catg = {}
            for example in examples:
                    if example['Class'] not in catg:
                        catg[example['Class']] = 1
                    else:
                        catg[example['Class']] += 1

            node_copy = deepcopy(node)
            #most repeated label from the catg dict
            node.label = max(catg.keys(), key=(lambda k: catg[k]))
            node.children = None

            #verify if the pruning helps to increase the accuracy if not revert the node changes
            pruned_accuracy = test(node_softcopy, examples)
            if pruned_accuracy > test(node_hardcopy, examples):
                node_hardcopy = node_softcopy
                accuracy = pruned_accuracy
                return
            else:
                node.label = node_copy.label
                node.children = node_copy.children
                return
























