import game_rules, random

###########################################################################
# Explanation of the types:
# The board is represented by a row-major 2D list of characters, 0 indexed
# A point is a tuple of (int, int) representing (row, column)
# A move is a tuple of (point, point) representing (origin, destination)
# A jump is a move of length 2
###########################################################################

# I will treat these like constants even though they aren't
# Also, these values obviously are not real infinity, but close enough for this purpose
NEG_INF = -1000000000
POS_INF = 1000000000


class Player(object):
    """ This is the player interface that is consumed by the GameManager. """

    def __init__(self, symbol): self.symbol = symbol  # 'x' or 'o'

    def __str__(self): return str(type(self))

    def selectInitialX(self, board): return (0, 0)

    def selectInitialO(self, board): pass

    def getMove(self, board): pass

    def h1(self, board, symbol):
        return -len(game_rules.getLegalMoves(board, "o" if self.symbol == "x" else "x"))


# This class has been replaced with the code for a deterministic player.
class MinimaxPlayer(Player):
    def __init__(self, symbol, depth):
        super(MinimaxPlayer, self).__init__(symbol)
        self.curr_depth = depth

    # Leave these two functions alone.
    def selectInitialX(self, board):
        return (0, 0)

    def selectInitialO(self, board):
        validMoves = game_rules.getFirstMovesForO(board)
        return list(validMoves)[0]

    # Edit this one here. :)
    def getMove(self, board):

        # board
        turn = self.symbol
        att1, chosenMove = self.algoMM(board,
                                       self.curr_depth,
                                       turn,
                                       1)
        return chosenMove

    def algoMM(self, board, depth, turn, player):

        # board
        allowed = game_rules.getLegalMoves(board, turn)
        # NOT WORKING
        # self.legal_board(board, depth, allowed)
        if not depth > 0 or not len(allowed) > 0:
            return self.h1(board, 'x'), None

        # depth
        curr_depth = depth - 1

        # turn
        change_player = self.change(turn)

        # player
        if player == 1:
            temp = NEG_INF
            # ERROR ON TEST 3?
            # self.play_sequence_1(board, allowed, curr_depth, change_player, temp=temp)

            for a_move in allowed:
                new, att2 = self.algoMM(game_rules.makeMove(board, a_move),
                                        curr_depth,
                                        change_player,
                                        2)
                # encountering an error here? not sure what's wrong..
                # not allowing me to use a normal if-else combo
                if new > temp:
                    temp = new
                    chosenMove = a_move
            return temp, chosenMove

        elif player == 2:
            temp = POS_INF
            for a_move in allowed:
                new, att2 = self.algoMM(game_rules.makeMove(board, a_move),
                                        curr_depth,
                                        change_player,
                                        1)
                if temp > new:
                    temp = new
                    chosenMove = a_move
            return temp, chosenMove

    def change(self, turn):
        if turn == 'o':
            return 'x'
        else:
            return 'o'

    # ERROR ON TEST 3?
    def play_sequence_1(self, board, allowed, curr_depth, change_player, temp):
        for a_move in allowed:
            new, att2 = self.algoMM(game_rules.makeMove(board, a_move),
                                    curr_depth,
                                    change_player,
                                    2)
            if new > temp:
                temp = new
                chosenMove = a_move
        return temp, chosenMove

        # if num2 == NEG_INF:
        #     if new > num2:
        #         num2 = new
        #         chosenMove = a_move
        #     return num2, chosenMove
        # else:
        #     if num2 > new:
        #         num2 = new
        #         chosenMove = a_move
        #     return num2, chosenMove

    # NOT WORKING
    def legal_board(self, board, depth, x):
        if not depth > 0 or not len(x) > 0:
            return self.h1(board, 'x'), None


# This class has been replaced with the code for a deterministic player.
class AlphaBetaPlayer(Player):
    def __init__(self, symbol, depth):
        super(AlphaBetaPlayer, self).__init__(symbol)
        self.curr_depth = depth

    # Leave these two functions alone.
    def selectInitialX(self, board):
        return (0, 0)

    def selectInitialO(self, board):
        validMoves = game_rules.getFirstMovesForO(board)
        return list(validMoves)[0]

    # Edit this one here. :)
    def getMove(self, board):

        # board
        turn = self.symbol
        att1, chosenMove = self.algoAB(board,
                                       self.curr_depth,
                                       turn,
                                       1,
                                       NEG_INF,
                                       POS_INF)
        return chosenMove

    def algoAB(self, board, depth, turn, player, alpha, beta):

        # board same as above
        allowed = game_rules.getLegalMoves(board, turn)

        # depth same as above
        if depth == 0 or len(allowed) == 0:
            return self.h1(board, 'x'), None
        curr_depth = depth - 1

        # turn same as above
        change_player = self.change(turn)

        # player
        if player == 1:
            temp = NEG_INF
            for a_move in allowed:
                new, att2 = self.algoAB(game_rules.makeMove(board, a_move),
                                        curr_depth,
                                        change_player,
                                        2,
                                        alpha,
                                        beta)
                # encountering an error here? not sure what's wrong..
                # not allowing me to use a normal if-else combo
                if new > temp:
                    temp = new
                    # alpha
                    alpha = temp
                    chosenMove = a_move
                # NOTE: `beta < alpha` DOES NOT WORK!!
                if alpha >= beta: break  # 'pruning'
            return temp, chosenMove
        elif player == 2:
            temp = POS_INF
            for a_move in allowed:
                new, att2 = self.algoAB(game_rules.makeMove(board, a_move),
                                        curr_depth,
                                        change_player,
                                        1,
                                        alpha,
                                        beta)
                if temp > new:
                    temp = new
                    # beta
                    beta = temp
                    chosenMove = a_move
                # NOTE: `beta < alpha` DOES NOT WORK!!
                if alpha >= beta: break  # 'pruning'
            return temp, chosenMove

    def change(self, turn):
        if turn == 'o':
            return 'x'
        else:
            return 'o'


class RandomPlayer(Player):
    def __init__(self, symbol):
        super(RandomPlayer, self).__init__(symbol)

    def selectInitialX(self, board):
        validMoves = game_rules.getFirstMovesForX(board)
        return random.choice(list(validMoves))

    def selectInitialO(self, board):
        validMoves = game_rules.getFirstMovesForO(board)
        return random.choice(list(validMoves))

    def getMove(self, board):
        legalMoves = game_rules.getLegalMoves(board, self.symbol)
        if len(legalMoves) > 0:
            return random.choice(legalMoves)
        else:
            return None


class DeterministicPlayer(Player):
    def __init__(self, symbol):
        super(DeterministicPlayer, self).__init__(symbol)

    def selectInitialX(self, board):
        return (0, 0)

    def selectInitialO(self, board):
        validMoves = game_rules.getFirstMovesForO(board)
        return list(validMoves)[0]

    def getMove(self, board):
        legalMoves = game_rules.getLegalMoves(board, self.symbol)
        if len(legalMoves) > 0:
            return legalMoves[0]
        else:
            return None


class HumanPlayer(Player):
    def __init__(self, symbol): super(HumanPlayer, self).__init__(symbol)

    def selectInitialX(self, board): raise NotImplementedException('HumanPlayer functionality is handled externally.')

    def selectInitialO(self, board): raise NotImplementedException('HumanPlayer functionality is handled externally.')

    def getMove(self, board): raise NotImplementedException('HumanPlayer functionality is handled externally.')


def makePlayer(playerType, symbol, depth=1):
    player = playerType[0].lower()
    if player == 'h':
        return HumanPlayer(symbol)
    elif player == 'r':
        return RandomPlayer(symbol)
    elif player == 'm':
        return MinimaxPlayer(symbol, depth)
    elif player == 'a':
        return AlphaBetaPlayer(symbol, depth)
    elif player == 'd':
        return DeterministicPlayer(symbol)
    else:
        raise NotImplementedException('Unrecognized player type {}'.format(playerType))


def callMoveFunction(player, board):
    if game_rules.isInitialMove(board):
        return player.selectInitialX(board) if player.symbol == 'x' else player.selectInitialO(board)
    else:
        return player.getMove(board)
