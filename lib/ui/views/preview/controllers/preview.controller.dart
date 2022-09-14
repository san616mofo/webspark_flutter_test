import 'dart:math';

// I know it's trash. Logical tasks are not for me)
// Some of this was Googled.
class PreviewController {
  int counter = 0;

  void checkCell(List gridList, dynamic x, dynamic y, cells, gridValues) {
    bool inside = stayInGrid(gridList, x, y);

    if (!inside) return;
    if (gridValues[x][y] == 'X') return;

    var found = cells.where((cell) => cell.x == x && cell.y == y);

    if (found) return;

    cells[++counter] = {x, y};
  }

  getCells(gridList, gridValues, startX, startY, endX, endY) {
    var countingEnd = false;
    List<Map<String, dynamic>> cells = [
      {"x": startX, "y": startY}
    ];
    var cellNumber = 0;

    while (!countingEnd) {
      if (cells[cellNumber].isEmpty) return;

      var x = cells[cellNumber]["x"];
      var y = cells[cellNumber]["y"];
      checkCell(gridList, x - 1, y, cells, gridValues);
      checkCell(gridList, x, y + 1, cells, gridValues);
      checkCell(gridList, x + 1, y, cells, gridValues);
      checkCell(gridList, x, y - 1, cells, gridValues);
      checkCell(gridList, x - 1, y - 1, cells, gridValues);
      checkCell(gridList, x - 1, y + 1, cells, gridValues);
      checkCell(gridList, x + 1, y + 1, cells, gridValues);
      checkCell(gridList, x + 1, y - 1, cells, gridValues);

      var last = cells.where((cell) => cell["x"] == endX && cell["y"] == endY);

      // if (last) countingEnd = true;

      cellNumber++;
    }

    // return cells;
  }

  getGridValues(gridList) {
    List gridValues = [];
    List gridRow = [];

    if (gridList is! List) return;
    if (gridList.length == 1 || gridList.length >= 100) return;

    for (var i = 0; i < gridList.length; i++) {
      gridRow = gridList[i].split('');
      gridValues[i] = [];

      if (gridRow.length != gridList.length) return;
      if (i > 0 && gridRow.length != gridValues[i - 1].length) return;

      for (var j = 0; j < gridRow.length; j++) {
        var gridValue = gridRow[j];

        if (gridValue != '.' && gridValue != 'X') return;

        gridValues[i][j] = gridValue;
      }
    }

    return gridValues;
  }

  getStepsArray(x, y, path, stepsArray) {
    var found = path.where((cell) => cell.x == x && cell.y == y);

    if (!found || (!found.steps && found.steps != 0)) return stepsArray;

    stepsArray.push(found.steps);
    return stepsArray;
  }

  List getSteps(List cells) {
    List path = [...cells];
    path[0].steps = 0;

    for (var i = 1; i < path.length; i++) {
      var x = path[i].x;
      var y = path[i].y;
      List<int> stepsArray = [];
      stepsArray = getStepsArray(x - 1, y, path, stepsArray);
      stepsArray = getStepsArray(x, y + 1, path, stepsArray);
      stepsArray = getStepsArray(x + 1, y, path, stepsArray);
      stepsArray = getStepsArray(x, y - 1, path, stepsArray);
      stepsArray = getStepsArray(x - 1, y - 1, path, stepsArray);
      stepsArray = getStepsArray(x - 1, y + 1, path, stepsArray);
      stepsArray = getStepsArray(x + 1, y + 1, path, stepsArray);
      stepsArray = getStepsArray(x + 1, y - 1, path, stepsArray);
      path[i].steps = stepsArray.reduce(min) + 1;
    }

    return path[path.length - 1].steps;
  }

  bool stayInGrid(List gridList, dynamic x, dynamic y) {
    int maxX = gridList.length - 1;
    int maxY = gridList[0].split('').length - 1;

    if (x is! int || y is! int) {
      return false;
    }
    if (x < 0 || x > maxX) return false;
    if (y < 0 || y > maxY) return false;

    return true;
  }

  dynamic minWalk(gridList, startX, startY, endX, endY) {
    var gridValues = getGridValues(gridList);

    if (!gridValues) return 'Invalid grid list';

    var insideStart = stayInGrid(gridList, startX, startY);
    var insideEnd = stayInGrid(gridList, endX, endY);

    if (!insideStart) return 'Invalid start cell';
    if (!insideEnd) return 'Invalid end cell';
    if (gridValues[startX][startY] != '.') return 'Locked start cell';
    if (gridValues[endX][endY] != '.') return 'Locked end cell';

    var cells = getCells(gridList, gridValues, startX, startY, endX, endY);

    if (!cells) return 'Impossible to reach end cell';

    return getSteps(cells);
  }
}
