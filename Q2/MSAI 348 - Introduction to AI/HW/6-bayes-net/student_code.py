
def ask(var, value, evidence, bn):
	# ask : var value evidence bn -> PHe/a
	# returns probability of a hypothesis given evidence P(H|e)

	# var = name of hypothesis variable
	# value = whether hypothesis is T or F
	# evidence = set of variables known to be T or F
	# bn = class BayesNet
	# P(H|e) = P(H^e)/a
		# H -> var==value,
		# E -> evidence,
		# a -> P(-H^e) = P(A^B) + P(-A^B)

	# keith said: P(B,j,m) / (P(b,j,m) + P(-b,j,m))
	# can do a / (a + b)
	# that requires 2 probabilities, and 2 evidences, and
	# 	no need of bn in recursion()

	PHe = {}
	for bool in [True, False]:
		# evidence = set of variables known to be T or F
		# var = name of hypothesis variable
		evidence[var] = bool
		# bn = class BayesNet
		# .variables from BayesNet
		PHe[bool] = recursion(vars=bn.variables,
							  evidence=evidence,
							  bn=bn)
	# value = whether hypothesis is T or F
	# need sum of all PHe
	# norm same?
	pOfandNot = sum(PHe.values())
	return PHe[value] / pOfandNot


def recursion(vars, evidence, bn):
	# recursion : var evidence bn -> total
	# returns total probability

	# "This inspection detects equality comparison with a boolean literal"
	if vars == []:
		return 1.0

	# function from BayesNet
	# node is first
	node = vars[0]
	# if node in evidence:
	# bn.get_var(node.name) not working?

	total = 0

	for bool in [True, False]:
		# in evidence
		if node.name in evidence:
			if evidence[node.name] == bool:
				prob = node.probability(hypothesis=bool,
										evidence=evidence)
				# vars from 2nd
				rec = recursion(vars=vars[1:],
								evidence=evidence,
								bn=bn)
				total = 0 + prob * rec
				return total

				# prob = node.probability(bool, evidence)
				# rec = recursion(vars, evidence, bn)
				# total = prob * rec
				# return total

		# not in evidence
		else:
			for bool in [True, False]:
				# need second 'copy'
				evidence2 = evidence.copy()
				evidence2[node.name] = bool
				if evidence2[node.name] == bool:
					prob = node.probability(hypothesis=bool,
											evidence=evidence2)
					rec = recursion(vars=vars[1:],
									evidence=evidence2,
									bn=bn)
					total = total + prob * rec
			return total
	#
	#
	#
	#
	#
	# if node in evidence:
	# 	prob = bn.get_var(node).probability(evidence[node], evidence)
	# 	rec = recursion(vars[1:], evidence, bn)
	# 	total = prob * rec
	#
	# else:
	# 	# copy = evidence.copy()
	# 	evidence2 = evidence.copy()
	# 	for bool in [True, False]:
	# 		evidence2[node] = bool
	# 		elseProb.append(bn.get_var(node).probability(bool, evidence2) *
	# 						recursion(vars[1:], evidence2, bn))
	# 		total = sum(elseProb)
	#
	# return total
