import math
import re


class Bayes_Classifier:

	def __init__(self):
		self.allW = set()
		self.posD = {}
		self.negD = {}
		self.posR = 0
		self.negR = 0
		self.posP = 0
		self.negP = 0
		self.pos_part = 0
		self.neg_part = 0
		self.pos_whole = 0
		self.neg_whole = 0
		self.total = 0

	def clean(self, lines):
		# implement nltk techniques from 337 NLP's cleaning
		# for reviews
		# same methodology as tweets
		stopwords = ['about', 'above', 'after', 'against', 'again', 'all', 'am', 'and', 'any', 'an', 'are', 'as', 'at',
					 'a', 'because', 'been', 'before', 'being', 'below', 'between', 'be', 'both', 'but', 'by', 'can',
					 'did', 'does', 'doing', 'don', 'down', 'do', 'during', 'each', 'few', 'for', 'from', 'further',
					 'had', 'has', 'have', 'having', 'here', 'herself', 'hers', 'her', 'he', 'himself', 'him', 'his',
					 'how', 'if', 'into', 'in', 'is', 'itself', 'its', 'it', 'i', 'just', 'me', 'more', 'most',
					 'myself', 'my', 'nor', 'not', 'now', 'no', 'off', 'of', 'once', 'only', 'on', 'or', 'other',
					 'ourselves', 'ours', 'our', 'out', 'over', 'own', 'same', 'she', 'should', 'some', 'so', 'such',
					 's', 'than', 'that', 'theirs', 'their', 'themselves', 'them', 'then', 'there', 'these', 'they',
					 'the', 'this', 'those', 'through', 'too', 'to', 't', 'under', 'until', 'up', 'very', 'was', 'were',
					 'we', 'what', 'when', 'where', 'which', 'while', 'whom', 'who', 'why', 'will', 'with', 'yourself',
					 'yourselves', 'yours', 'your', 'you']
		stopwords2 = ["a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are",
					  "aren't", "as", "at", "be", "because", "been", "before", "being", "below", "between", "both",
					  "but", "by", "can", "can't", "cannot", "could", "couldn't", "did", "didn't", "do", "does",
					  "doesn't", "doing", "don", "don't", "down", "during", "each", "few", "for", "from", "further",
					  "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll", "he's",
					  "her", "here", "here's", "hers", "herself", "him", "himself", "his", "how", "how's", "i", "i'd",
					  "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself", "just",
					  "let's", "me", "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "now", "of", "off",
					  "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own",
					  "s", "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some",
					  "such", "t", "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then",
					  "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those",
					  "through", "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll",
					  "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's",
					  "which", "while", "who", "who's", "whom", "why", "why's", "will", "with", "won't", "would",
					  "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself",
					  "yourselves"]
		# val = []
		# numb = []
		# all_revs = []
		# pos_revs = []
		# neg_revs = []
		corp = []

		for line in lines:
			line = line.replace('\n', ' ')
			sep = line.split('|')
			corp.append(sep)
		for line in corp:
			rev = line[2]
			rev = rev.lower()
			rev = re.sub(r'[^a-z]', ' ', rev)  # removing punctuation doesn't affect score much?
			# taken from nlp project
			rev = [i for i in rev.split(' ') if (i not in stopwords2)]
			# wasted 4 hours on the following space:
			rev = ' '.join(rev)
			# the : in '[2:]' makes it a list
			line[2:] = rev.split(' ')
		return corp

	# for line in lines:
	# 	line = line.replace('\n', ' ')
	# 	sep = line.split('|')
	# 	val.append(sep[0])
	# 	numb.append(sep[1])
	# 	all_revs.append(sep[2])
	# 	if sep[0] == '5':
	# 		pos_revs.append(sep[2])
	# 	elif sep[0] == '1':
	# 		neg_revs.append(sep[2])
	# return ?
	# def parsing(self, corp):
	# 	# for words
	# 	neg = {}
	# 	pos = {}
	# 	negnum = 0
	# 	posnum = 0
	# for segm in lines:
	# 	# tokenize
	#
	# 	words = segm.split(' ')
	# 	for token in words:
	# 		token = token.lower()
	# 		# punctuation
	# 		token = re.sub(r'[^a-zA-Z]', ' ', token)

	def train(self, lines):
		self.posD = {}
		self.negD = {}
		self.posR = 0
		self.negR = 0
		self.posP = 0
		self.negP = 0
		self.allW = set()
		self.pos_part = 0
		self.neg_part = 0
		self.pos_whole = 0
		self.neg_whole = 0
		self.total = 0

		self.total = len(lines)
		cleaned = self.clean(lines=lines)
		self.posD = self.parse(lines=cleaned)[0]
		self.negD = self.parse(lines=cleaned)[1]
		self.posR = self.parse(lines=cleaned)[2]
		self.negR = self.parse(lines=cleaned)[3]
		self.allW = self.parse(lines=cleaned)[4]

		self.pos_part = len(self.posD)
		self.neg_part = len(self.negD)
		self.pos_whole = sum(self.posD.values())
		self.neg_whole = sum(self.negD.values())

	#
	def parse(self, lines):
		posD = {}
		negD = {}
		posR = 0
		negR = 0
		allW = set()

		vals = []
		for line in lines:
			if line[0] == '5':
				posR += 1
				for token in line[2:]:
					self.allW.add(token)
					if token in posD.keys():
						# problem with the math
						posD[token] = posD[token] + 1
					else:
						posD[token] = 1
			if line[0] == '1':
				negR += 1
				for token in line[2:]:
					self.allW.add(token)
					if token in negD.keys():
						# problem with the math
						negD[token] = negD[token] + 1
					else:
						negD[token] = 1
		vals.append(posD)
		vals.append(negD)
		vals.append(posR)
		vals.append(negR)
		vals.append(allW)
		return vals

	# keep getting math domain error???
	def classify(self, lines):
		# P(c|x) = P(x|c) * P(c) / P(x)
		# posterior = likelihood * class prior / predictor prior
		predict = []
		self.posP = 0
		self.negP = 0

		cleaned = self.clean(lines=lines)
		for line in cleaned:
			posP = math.log(self.posR / self.total)
			negP = math.log(self.negR / self.total)
			for token in line[2:]:
				if token in self.posD:
					num = self.posD[token] + 1
					den = self.pos_part + self.pos_whole
				elif token not in self.posD:
					num = 1
					den = self.pos_part + self.pos_whole + self.neg_whole
				posP += math.log(num / den)

			for token in line[2:]:
				if token in self.negD:
					num = self.negD[token] + 1
					den = self.neg_part + self.neg_whole
				elif token not in self.negD:
					num = 1
					den = self.neg_part + self.neg_whole + self.pos_whole
				negP += math.log(num / den)

			# strings not int
			if posP > negP:
				predict.append('5')
			elif posP <= negP:
				predict.append('1')
		return predict
