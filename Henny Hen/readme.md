IGN-CodeFoo-HennyHen

Files:
index.html
style.css
grid.js

The path finding algorithm is contained in the grid.js file and the answer is displayed via the index.html file. If you reload the page it will generate a different starting location and solve for the available paths. 

The solution I implemented was to create a recursive function to iterate through the grid and find all possible paths using only the available valid moves of (x+1),(y+1) and (y-1). I used a random number function to determine the random starting position along the y axis and each time you load the page it will solve for all possible solutions from the new starting position.

This path finding algorithm would work on a grid of any size as it moves programmtically through the grid and is not constrained by a size requirement. 
