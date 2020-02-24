from expand import expand
import heapq


# PEP8 naming convention?
class OrderedPath:

    # list of locations
    def __init__(self):
        self.loc = []

    # add_loc :
    # need to add location `start` to an ordered list
    def add_loc(self, traveled, precedence):
        return heapq.heappush(self.loc, (traveled, precedence))

    # rem_loc :
    # need to move location (by popping end of list) to `visited list`
    def rem_loc(self):
        return heapq.heappop(self.loc)

    # list_not_empty : list -> boolean
    # if the list is empty, return true
    def list_not_empty(self):
        return len(self.loc) > 0


def a_star_search(dis_map, time_map, start, end):
    # steps:
    # from start, calculate all adjacent locations' cost :
    #   f(n) = time_to(n) + dis(n)

    # initialize:
    path = []  # list of strings ONLY
    time_to_next_loc = {}
    time_to_next_loc[start] = 0
    loc_ordered = OrderedPath()
    loc_ordered.add_loc(0, [start])  # precedence = 0, and travel = START
    visited_list = set()  # UNORDERED, but doesn't matter

    # function:
    # while not empty, do things
    # NOTE: loc_ordered is a list of paths
    while loc_ordered.list_not_empty() == True:
        # add removed to list of removed
        just_removed = loc_ordered.rem_loc()

        # if latest removed was not visited before, add to list of visited
        if just_removed[-1][-1] not in visited_list:
            visited_list.add(just_removed[-1][-1])

            # if latest removed is the endpoint, this is the final path
            if just_removed[-1][-1] == end:
                path = just_removed[-1]
                return path

            else:
                # for each adjacent location, add a time and distance (cost) measure
                for loc in expand(just_removed[-1][-1], time_map):

                    # g(n)
                    gn = time_map[just_removed[-1][-1]][loc] + \
                         time_to_next_loc[just_removed[-1][-1]]

                    # h(n)
                    hn = dis_map[loc][end]

                    # f(n)
                    fn = gn + hn

                    # add shortest to ordered list
                    if loc not in time_to_next_loc.keys() or time_to_next_loc[loc] > gn:
                        time_to_next_loc[loc] = gn
                        append_loc = just_removed[-1].copy()
                        append_loc.append(loc)
                        loc_ordered.add_loc(fn, append_loc)
    return path
