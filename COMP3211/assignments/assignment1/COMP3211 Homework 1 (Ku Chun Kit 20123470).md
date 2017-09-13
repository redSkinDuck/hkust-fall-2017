# COMP 3211 Homework 1
## By Ku Chun Kit 20123470

### How to read the maps

I modified the program to show the path taken by pacman. In the
following example, `>` means pacman moves right, `<` means left,  `^`
means up and `v` means down.

If a location is visited twice or more, it will only shows the last path
taken by pacman. I have added annotations to help you understand
pacman's path.

In an example below, pacman starts from the middle, and runs from left
to right to go downwards until it hits to bottom-left corner.

```
%%%%%%%%%%%%%%%%%%%%%
%                   %
%                   %
%                   %
%                   %
%<<<<<<<<<>         %
%v>>>>>>>>>>>>>>>>>>%
%<<<<<<<<<<<<<<<<<<v%
%v>>>>>>>>>>>>>>>>>>%
%><<<<<<<<<<<<<<<<<v%
%%%%%%%%%%%%%%%%%%%%%
```

### Layout 1: contoursMaze

`contoursMaze` is a layout with the pacman starting in the middle and the
food is at the bottom-left corner. In this map, breadth first search and
uniform cost search performs identically. Depth first search performs
with less nodes expanded yet the solution is more costly.

| Algorithm | Nodes expanded | Total cost | Score |
|-----------|----------------|------------|-------|
| BFS/UCS   | 170            | 13         | 497   |
| DFS       | 85             | 85         | 425   |

---

```
%%%%%%%%%%%%%%%%%%%%%
%                   %
%                   %
%                   %
%                   %
%         >         %
%         v         %
%         v         %
%         v         %
%><<<<<<<<v         %
%%%%%%%%%%%%%%%%%%%%%
```
<small>BFS/UCS have the same path</small>

---

```
%%%%%%%%%%%%%%%%%%%%%
%                   %
%                   %
%                   %
%                   %
%<<<<<<<<<>         %
%v>>>>>>>>>>>>>>>>>>%
%<<<<<<<<<<<<<<<<<<v%
%v>>>>>>>>>>>>>>>>>>%
%><<<<<<<<<<<<<<<<<v%
%%%%%%%%%%%%%%%%%%%%%
```
<small>DFS takes a longer path</small>

---

Breadth first search and uniform cost search perform with exactly the
same performance because the cost for uniform cost search is set as
depth of the search tree, meaning it's always less costly to explore
sibling nodes than to explore child nodes, giving it exactly the same
behavior as breadth first search.

This way, breadth first search and uniform cost search would might
expand more nodes than depth first search before reaching to a solution
as it searches in all directions - even going up or right. It also
guarantee the least costly solution because paths with the least costs
are discovered first as it searches down the tree.

Depth first search results in less nodes expanded because it takes the
first solution that it found regardless of it's cost. This does not mean
that depth first search always expand the least nodes, as seen if the
food is placed on the top-right corner, the nodes expanded will be 170,
which is close to 167, what breadth first search achieved. Depth first search
just happened to find the solution on it's first run digging down the tree in
the original map.

---

```
%%%%%%%%%%%%%%%%%%%%%
%^>>>>>>>>>>>>>>>>><%
%<<<<<<<<<<<<<<<<<<^%
%^>>>>>>>>>>>>>>>>>>%
%<<<<<<<<<<^        %
%<<<<<<<<<><<<<<<<<^%
%v>>>>>>>>>>>>>>>>>>%
%                   %
%                   %
%                   %
%%%%%%%%%%%%%%%%%%%%%
```
<small>DFS, food at top-right corner. Pacman goes down one row before
going back up for the food.</small>

---

```
%%%%%%%%%%%%%%%%%%%%%
%         ^>>>>>>>><%
%         ^         %
%         ^         %
%         ^         %
%         >         %
%                   %
%                   %
%                   %
%                   %
%%%%%%%%%%%%%%%%%%%%%

```

<small>BFS, food at top-right corner. Pacman goes directly up for food.</small>

---

### Layout 2: mediumMaze

`mediumMaze` is a maze-like layout with the pacman starting on the top-right
corner and food is at the bottom-left corner. Again in this map breadth first
search and uniform cost search performs identically. This wouldn't have differed
due to the underlying cost assignment favors breadth first search-like behavior
over depth first search-like one.

| Algorithm | Nodes expanded | Total cost | Score |
|-----------|----------------|------------|-------|
| BFS/UCS   | 269					   | 68				  | 442   |
| DFS       | 146            | 130	      | 380   |

---

```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        <<<<<<<<<>%
% %%%%%%%%%%%%%%%%%%%%%%%v%%%%%%%% %
% %%   %   %      %%%%%%%v>>%%     %
% %% % % % % %%%% %%%%%%%%%v%% %%%%%
% %% % % % %        <<<<^%%v%%     %
% %% % % % % % %%%% v%%%<<<v%%%%%% %
% %  % % %   %    %%v%%%%%%%%      %
% %% % % %%%%%%%% %%v>>>>>>>%% %%%%%
% %% %   %%       %%%%%%%%%v%%     %
%    %%%%%% %%%%%%%      %%v%%%%%% %
%%%%%%      %       %%%% %%v%      %
%      %%%%%% %%%%% %    %%v%% %%%%%
% %%%%%%      %       %%%%%v%%     %
%        %%%%%% %%%%%%%%%%%v%%  %% %
%%%%%%%%%%<<<<<<<<<<<<<<<<<v%%%%%% %
%><<<<<<<<v%%%%%%%%%%%%%%%%        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
<small>BFS/UCS</small>

---

```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>%
%v%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%% %
%v%%^>>%^>>%      %%%%%%%   %%     %
%v%%^%v%^%v% %%%% %%%%%%%%% %% %%%%%
%v%%^%v%^%v%^>>>>>>>>    %% %%     %
%v%%^%v%^%v%^% %%%% v%%%    %%%%%% %
%v% ^%v%^%v>>%    %%v%%%%%%%%      %
%v%%^%v%^%%%%%%%% %%v>>>>>>>%% %%%%%
%v%%^%v>>%%       %%%%%%%%%v%%     %
%v>>>%%%%%% %%%%%%%      %%v%%%%%% %
%%%%%%      %       %%%% %%v%      %
%      %%%%%% %%%%% %    %%v%% %%%%%
% %%%%%%      %       %%%%%v%%     %
%        %%%%%% %%%%%%%%%%%v%%  %% %
%%%%%%%%%%<<<<<<<<<<<<<<<<<v%%%%%% %
%><<<<<<<<v%%%%%%%%%%%%%%%%        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
<small>DFS, note that it favors leftwards operation because it's the first possible
action it gets when exploring the tree</small>

Here we are seeing how the supposedly better uniform cost search does not out-perform
the two other algorithms due the flaw in cost setting. The current experiment setting wouldn't
have any impact, until some nodes are set to be more costly.

We also observe again depth first search favors left-downwards path over other possibilities
because leftward action is first action it sees in `getPossibleActions`. The list of possible when printed out from the source is ordered as `West, Stop, East, North, South`.

### Layout 3: mediumDottedMaze

`mediumDottedMaze` is a layout with the pacman starting at the top-right corner
and the foods are distributed on the right, with one lone food at the bottom-left corner.
Breadth first search and uniform cost search performs identically. Depth first search has
really taken a dumb path to run back-and-forth, up-and-down between foods instead of getting
foods with the most direct path due to it's tendency to go left.

| Algorithm | Nodes expanded | Total cost | Score |
|-----------|----------------|------------|-------|
| BFS/UCS   | 3696           | 74         | 646   |
| DFS       | 2870           | 2650       | -1930 |

---

```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 >%
% %%%%%%%%%%%%%%%%%%% %%% %%%%%%%%v%
% %%   %   %      %%% %%%   %%<<<<v%
% %% % % % % %%%% %%%%%%%%% %%v%%%%%
% %% % % % % %    %%     %% %%v>>>>%
% %% % % % % % %%%%  %%%    %%%%%%v%
% %  % % %   %    %% %%%%%%%% <<<<v%
% %% % % %%%%%%%% %%        %%v%%%%%
% %% %   %%       %%%%%%%%% %%v>>>>%
%    %%%%%% %%%%%%%      %% %%%%%%v%
%%%%%%      %       %%%% %% % <<<<v%
%      %%%%%% %%%%% %    %% %%v%%%%%
% %%%%%%      %       %%%%% %%v>>>>%
%        %%%%%% %%%%%%%%%%% %%  %%v%
%%%%%%%%%%<<<<<<<<<<<<<<<<<^%%%%%%v%
%><<<<<<<<v%%%%%%%%%%%%%%%%<<<<<<<v%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
<small>BFS/UCS found the optimal solution with least cost</small>

---

```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%^>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%
%^%%%%%%%%%%%%%%%%%%% %%% %%%%%%%%v%
%^%%<<^%<<^%<<<<<^%%% %%%   %%<<<<v%
%^%%v%^%v%^%v%%%%^%%%%%%%%% %%v%%%%%
%^%%v%^%v%^%v%^>>>%%     %% %%v>>>>%
%^%%v%^%v%^%v%^%%%%  %%%    %%%%%%v%
%^% v%^%v%<<v%<<<^%% %%%%%%%% <<<<v%
%^%%v%^%v%%%%%%%%^%%        %%v%%%%%
%^%%v%<<v%%^>>>>>>%%%%%%%%% %%v>>>>%
%<<<v%%%%%%^%%%%%%%<<<<<^%% %%%%%%v%
%%%%%%^>>>>>%<<<<<<v%%%%^%% % <>><v%
%^>>>>>%%%%%%v%%%%%v%^>>>%% %%v%%%%%
%^%%%%%%<<<<<v%^>>>>>>%%%%% %%v>>>>%
%<<<<<<<v%%%%%%^%%%%%%%%%%% %%  %%v%
%%%%%%%%%%^>>>><<<<<<<<<<<<^%%%%%%v%
%<>>>>>>>>>%%%%%%%%%%%%%%%%<<<<<<<v%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
<small>DFS, pacman goes from the top, getting one food, going through the left part of the maze to get one food near the bottom-right corner, then go back for foods on top repeatedly until it gets them all due to it's tendency to go left</small>

---

The way the tree expands have great impact on how depth first search behave. For example, I changed direction it loops through in `FoodSearchProblem#getSuccessors` from `[Directions.NORTH, Directions.SOUTH, Directions.EAST, Directions.WEST]` to `[Directions.SOUTH, Directions.WEST, Directions.EAST, Directions.NORTH]` and the total cost of the solution was reduced to 1338 and nodes expanded 1507.

```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%<<<<<<<<<<<<<<<<<<<<<<<<^>>>>>>>>>%
%v%%%%%%%%%%%%%%%%%%% %%%^%%%%%%%%v%
%v%%^>>%^>>%^>>>>>%%% %%%<<^%%<<<<v%
%v%%^%v%^%v%^%%%%v%%%%%%%%%^%%v%%%%%
%v%%^%v%^%v%^%<<<v%%^>>>>%%^%%v>>>>%
%v%%^%v%^%v%^%v%%%% ^%%%v>>>%%%%%%v%
%v% ^%v%^%v>>%v>>>%%^%%%%%%%% <<<<v%
%v%%^%v%^%%%%%%%%v%%<<<<<<<^%%v%%%%%
%v%%^%v>>%%<<<<<<v%%%%%%%%%^%%v>>>>%
%v>>>%%%%%%v%%%%%%%^>>>>>%%^%%%%%%v%
%%%%%%<<<<<v%^>>>>>>%%%%v%%^% <<<<v%
%<<<<<v%%%%%%^%%%%% %<<<v%%^%%v%%%%%
%v%%%%%%^>>>>>%<<<<<<v%%%%%^%%v>>>>%
%v>>>>>>>%%%%%%v%%%%%%%%%%%^%%  %%v%
%%%%%%%%%%<<<<<v>>>>>>>>>>>^%%%%%%v%
%><<<<<<<<v%%%%%%%%%%%%%%%%<<<<<<<v%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
<small>DFS takes a different path (pretty difficult to visualize here) when the order of possible actions is altered (i.e. the left-most node is a different action)</small>
