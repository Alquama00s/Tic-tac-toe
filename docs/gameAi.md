# Game Ai (module at lib/gameAi)

There are 8 ways(configuration) of winning the game 3 rows, 3 columns and 2 diagonals. Each of these ways consist of three positions, and at any instant the positions can be in one of the following states.


assuming the ai is playing X
|no. of X|no. of O|no of Unfilled|Actions by Ai|
|--------|--------|--------------|-------------|
|3|0|0|we won no action required|
|0|3|0|player won no action required|
|2|1|0|all places occupied no action required|
|1|2|0|all places occupied no action required|
|2|0|1|we need to win priority 1|
|0|2|1|we need to block player priority 2|
|0|1|2|player has occupied one position we need to reduce his chances priority 3|
|1|0|2|we need to occupy this state so priority 4|
|0|0|3|no one has made a move so priority 5|
|1|1|1|no one is going to win here priority 6|

Now there can be multiple same priorities throughout the game(for eg: we may 3 p1) so to further
segregate priorities we assign importance numbers to each cell of the board according to different no. of ways we can win through each cell (for eg through central cell we can win by 4 ways 2 diagonals 1 row and 1 column)
||||
|-----------|-----------|-----------|
|3|2|3|
|2|4|2|
|3|2|3|

so the priorities for ai becomes as follows

||||
|-----------|-----------|-----------|
|2|3|2|
|3|1|3|
|2|3|2|

to really reduce the priority ambugity of ai we assign distinct priority to each cell

||||
|-----------|-----------|-----------|
|2|7|3|
|6|1|8|
|5|9|4|

## working

1. check according to first priority plan
1. even if single priority 1 or priority 2 detected go for it no need to check the second priority plan
1. if first priority plan gives priorities other than 1 or 2 
    1. pick up all the highest priority (priority plan 1 may give multiple same priority cell)
    1. apply second priority plan and choose a cell with highest priority 

