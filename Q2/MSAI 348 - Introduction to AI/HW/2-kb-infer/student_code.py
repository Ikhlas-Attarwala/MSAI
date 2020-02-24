import read, copy
from util import *
from logical_classes import *

verbose = 0


class KnowledgeBase(object):
	def __init__(self, facts=[], rules=[]):
		self.facts = facts
		self.rules = rules
		self.ie = InferenceEngine()

	def __repr__(self):
		return 'KnowledgeBase({!r}, {!r})'.format(self.facts, self.rules)

	def __str__(self):
		string = "Knowledge Base: \n"
		string += "\n".join((str(fact) for fact in self.facts)) + "\n"
		string += "\n".join((str(rule) for rule in self.rules))
		return string

	def _get_fact(self, fact):
		"""INTERNAL USE ONLY
		Get the fact in the KB that is the same as the fact argument

		Args:
			fact (Fact): Fact we're searching for

		Returns:
			Fact: matching fact
		"""
		for kbfact in self.facts:
			if fact == kbfact:
				return kbfact

	def _get_rule(self, rule):
		"""INTERNAL USE ONLY
		Get the rule in the KB that is the same as the rule argument

		Args:
			rule (Rule): Rule we're searching for

		Returns:
			Rule: matching rule
		"""
		for kbrule in self.rules:
			if rule == kbrule:
				return kbrule

	def kb_add(self, fact_rule):
		"""Add a fact or rule to the KB
		Args:
			fact_rule (Fact|Rule) - the fact or rule to be added
		Returns:
			None
		"""
		printv("Adding {!r}", 1, verbose, [fact_rule])
		if isinstance(fact_rule, Fact):
			if fact_rule not in self.facts:
				self.facts.append(fact_rule)
				for rule in self.rules:
					self.ie.fc_infer(fact_rule, rule, self)
			else:
				if fact_rule.supported_by:
					ind = self.facts.index(fact_rule)
					for f in fact_rule.supported_by:
						self.facts[ind].supported_by.append(f)
				else:
					ind = self.facts.index(fact_rule)
					self.facts[ind].asserted = True
		elif isinstance(fact_rule, Rule):
			if fact_rule not in self.rules:
				self.rules.append(fact_rule)
				for fact in self.facts:
					self.ie.fc_infer(fact, fact_rule, self)
			else:
				if fact_rule.supported_by:
					ind = self.rules.index(fact_rule)
					for f in fact_rule.supported_by:
						self.rules[ind].supported_by.append(f)
				else:
					ind = self.facts.index(fact_rule)
					self.facts[ind].asserted = True

	def kb_assert(self, fact_rule):
		"""Assert a fact or rule into the KB

		Args:
			fact_rule (Fact or Rule): Fact or Rule we're asserting
		"""
		printv("Asserting {!r}", 0, verbose, [fact_rule])
		self.kb_add(fact_rule)

	def kb_ask(self, fact):
		"""Ask if a fact is in the KB

		Args:
			fact (Fact) - Statement to be asked (will be converted into a Fact)

		Returns:
			listof Bindings|False - list of Bindings if result found, False otherwise
		"""
		print("Asking {!r}".format(fact))
		if factq(fact):
			f = Fact(fact.statement)
			bindings_lst = ListOfBindings()
			# ask matched facts
			for fact in self.facts:
				binding = match(f.statement, fact.statement)
				if binding:
					bindings_lst.add_bindings(binding, [fact])

			return bindings_lst if bindings_lst.list_of_bindings else []

		else:
			print("Invalid ask:", fact.statement)
			return []

	def kb_retract(self, fact_or_rule):
		"""Retract a fact from the KB

		Args:
			fact (Fact) - Fact to be retracted

		Returns:
			None
		"""
		printv("Retracting {!r}", 0, verbose, [fact_or_rule])
		####################################################
		# Student code goes here
		# copied template from kb_add above
		# also used unittests created by ??Lukas??

		# OLD CODE: GRADE 5/10 ?? ALL TESTS HAD PASSED
		# if isinstance(fact_or_rule, Fact):  # use what they give you
		# 	index_in_a_f = self.facts.index(fact_or_rule)
		# 	if index_in_a_f not in self.facts:
		# 		rem_f = self.facts[index_in_a_f]
		# 		if rem_f.asserted == True:   # asserted is NOT SUPPORTED_BY from logical classes.
		# 			self.facts.remove(fact_or_rule)  # Cannot simply write "not rem_f.supported_by"
		#
		# 			# retract facts unsupported
		# 			if len(rem_f.supports_facts) > 0:
		# 				for all_fs in rem_f.supports_facts:
		# 					all_fs.asserted = True
		# 					self.kb_retract(all_fs)
		#
		# 	elif isinstance(fact_or_rule, Rule):
		# 		index_in_a_r = self.rules.index(fact_or_rule)
		# 		if index_in_a_r not in self.rules:
		# 			rem_r = self.rules[index_in_a_r]
		# 			if rem_r.asserted == True:
		# 				self.facts.remove(fact_or_rule)
		#
		# 				# retract rules unsupported
		# 				if len(rem_r.supports_rules) > 0:
		# 					for all_rs in rem_r.supports_rules:
		# 						all_rs.asserted = True
		# 						self.kb_retract(all_rs)


		if isinstance(fact_or_rule, Rule):
			if fact_or_rule in self.rules:
				if self._get_rule(fact_or_rule).supported_by == []:
					self.rules.remove(fact_or_rule)

		# if isinstance(fact_or_rule, Fact):
		# 	for a_fact in self.facts:
		# 		if fact_or_rule.statement == a_fact.statement:
		# 			self.facts.remove(a_fact)
		if isinstance(fact_or_rule, Fact):
			switch = 0
			for each in self.facts:
				if switch == 0 and each.statement == fact_or_rule.statement:
					fact_or_rule = each
					switch = 1
					break
			# did anything changed.......?
			if switch == 1:
				if fact_or_rule.supported_by == []:
					self.facts.remove(fact_or_rule)
			elif switch == 0:
				return None
			elif fact_or_rule.supported_by == []:
				self.facts.remove(fact_or_rule)

		for f in fact_or_rule.supports_facts:
			f.supported_by = [i for i in f.supported_by if i[0] != fact_or_rule]
			for each in f.supported_by:
				if fact_or_rule in each:
					f.supported_by.remove(each)
			if f.supported_by == []:
				if f.asserted == False:
					self.kb_retract(f)

		for r in fact_or_rule.supports_rules:
			r.supported_by = [i for i in r.supported_by if i[0] != fact_or_rule]
			for each in r.supported_by:
				if fact_or_rule in each:
					r.supported_by.remove(each)
			if r.supported_by == []:
				if r.asserted == False:
					self.kb_retract(r)


class InferenceEngine(object):
	def fc_infer(self, fact, rule, kb):
		"""Forward-chaining to infer new facts and rules

		Args:
			fact (Fact) - A fact from the KnowledgeBase
			rule (Rule) - A rule from the KnowledgeBase
			kb (KnowledgeBase) - A KnowledgeBase

		Returns:
			Nothing
		"""
		printv('Attempting to infer from {!r} and {!r} => {!r}', 1, verbose,
			   [fact.statement, rule.lhs, rule.rhs])
		####################################################
		# Student code goes here

		# # OLD CODE: GRADE 5/10 ?? ALL TESTS HAD PASSED
		# new_bindings = match(state1=fact.statement, state2=rule.lhs[0])
		# if new_bindings:  # ?
		# 	# do fact
		# 	if len(rule.lhs) == 1:  # because fist element? also how do I call state2 without re-writing "rule.lhs"?
		# 		state_rhs = instantiate(statement=rule.rhs, bindings=new_bindings)  # instantiate from util
		# 		add_fc_fact = Fact(statement=state_rhs,
		# 						   supported_by=[[fact, rule]])
		#
		# 		rule.supports_facts.append(add_fc_fact)  # add rule to fc_fact
		# 		fact.supports_facts.append(add_fc_fact)  # add fact to fc_fact
		# 		kb.kb_add(add_fc_fact)  # from sc
		# 	# repeat for rule
		# 	else:
		# 		list_lhs = []
		# 		for lhs in rule.lhs[1:len(rule.lhs)]:  # ?
		# 			list_lhs.append(instantiate(statement=lhs, bindings=new_bindings))
		# 		add_fc_rule = Rule(rule=[list_lhs, instantiate(statement=rule.rhs, bindings=new_bindings)],
		# 						   supported_by=[fact, rule])
		# 		# can't use state_rhs to replace instantiate... because it hasn't been referenced before??
		#
		# 		rule.supports_rules.append(add_fc_rule)  # add rule to fc_rule
		# 		fact.supports_rules.append(add_fc_rule)  # add fact to fc_rule
		# 		kb.kb_add(add_fc_rule)  # from sc
		new_bindings = match(state1=fact.statement,
							 state2=rule.lhs[0])
		if new_bindings:
			if len(rule.lhs) == 1:
				state_rhs = instantiate(statement=rule.rhs,
										bindings=new_bindings)  # instantiate from util
				add_fc_fact = Fact(statement=state_rhs,
								   supported_by=[[fact, rule]])
				fact.supports_facts.append(add_fc_fact)
				rule.supports_facts.append(add_fc_fact)
				kb.kb_assert(add_fc_fact)
				# kb.kb_add(add_fc_fact)
					# either one?
			else:
				state_rhs = instantiate(statement=rule.rhs,
										bindings=new_bindings)
				# for i in rule.lhs[1:]:
				# 	list_lhs = instantiate(statement=i, bindings=new_bindings)
				list_lhs = [instantiate(statement=i,
										bindings=new_bindings) for i in rule.lhs[1:]]
				add_fc_rule = Rule(rule=[list_lhs, state_rhs],
								   supported_by=[[fact, rule]])
				fact.supports_rules.append(add_fc_rule)
				rule.supports_rules.append(add_fc_rule)
				kb.kb_assert(add_fc_rule)
				# kb.kb_add(add_fc_rule)
					# either one?
