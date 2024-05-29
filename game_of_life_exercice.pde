/**
 * Game of Life
 *
 * Press SPACE BAR to pause and change the cell's values
 * with the mouse. On pause, click to activate/deactivate
 * cells. Press 'R' or 'C' to reset the cells' grid.
**/

// Size of cells
int cellSize = 20;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Colors for active/inactive cells
color alive = color(0);
color dead = color(255);

// Array of cells
float[][] cells; 
// Buffer to record the state of the cells and use this 
// while changing the others in the interations
float[][] cellsBuffer; 

// Pause
boolean pause = true;

void setup() {
	size (1900, 1000);

	// Instantiate arrays 
	cells = new float[width/cellSize][height/cellSize];
	cellsBuffer = new float[width/cellSize][height/cellSize];

	// This stroke will draw the background grid
	stroke(48);

	noSmooth();

	// Initialization of cells
	for (int x = 0; x < width / cellSize; x++) {
		for (int y = 0; y < height / cellSize; y++) {
			cells[x][y] = 0; // Save state of each cell
		}
	}
	// Fill in black in case cells don't cover all the windows
	background(0); 
}


void draw() {
	//Draw grid
	for (int x = 0; x < width / cellSize; x++) {
		for (int y = 0; y < height / cellSize; y++) {
			if (cells[x][y] == 1) {
				fill(alive); // If alive
			}
			else {
				fill(dead); // If dead
			}
			rect (x * cellSize, y * cellSize, cellSize, cellSize);
		}
	}
	// Iterate if timer ticks
	if (!pause && millis() - lastRecordedTime > interval) {
		iteration();
		lastRecordedTime = millis();
	}

	// Create  new cells manually on pause
	if (pause && mousePressed) {
		int xCellOver = int(map(mouseX, 0, width, 0, width / cellSize));
		xCellOver = constrain(xCellOver, 0, width / cellSize - 1);
		int yCellOver = int(map(mouseY, 0, height, 0, height / cellSize));
		yCellOver = constrain(yCellOver, 0, height / cellSize - 1);
		if (cellsBuffer[xCellOver][yCellOver] == 1) {
			cells[xCellOver][yCellOver] = 0;
			fill(dead);
		} else {
			cells[xCellOver][yCellOver] = 1;
			fill(alive);
		}
	} else if (pause && !mousePressed) {
		// Save cells to buffer (so we opeate with one array keeping the other intact)
		for (int x = 0; x < width / cellSize; x++) {
			for (int y = 0; y < height / cellSize; y++) {
				cellsBuffer[x][y] = cells[x][y];
			}
		}
	}
}

void iteration() { // When the clock ticks
	// Save cells to buffer (so we opeate with one array keeping the other intact)
	for (int x = 0; x < width / cellSize; x++) {
		for (int y = 0; y < height / cellSize; y++) {
			cellsBuffer[x][y] = cells[x][y];
		}
	}

	// computing
}

void keyPressed() {
	// Restart
	if (key=='r' || key == 'R' || key=='c' || key == 'C') {
		pause = true;
		for (int x = 0; x < width / cellSize; x++) {
			for (int y = 0; y < height / cellSize; y++) {
				cells[x][y] = 0;
			}
		}
	}
	// Pause
	if (key == ' ') {
		pause = !pause;
	}
}
