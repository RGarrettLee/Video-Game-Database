// Video Game Database. Used to document all the games I own, along with relevant information regarding the game

PrintWriter saveDatabase;
ArrayList <Database> databases = new ArrayList <Database>();

void setup() {
  println("Welcome to Garrett's Video Game Database");
}

void draw() {
  runDatabase();
}

void runDatabase () {
  String selection = getString("Would you like to create a NEW database, DISPLAY databases, EDIT a database, SAVE current build, LOAD previous build, or DELETE a database?");
  selection.toLowerCase();
  if (selection.equals("new")) {
    createDatabase();
  } else if (selection.equals("edit")) {
    selectDatabase();
  } else if (selection.equals("display")) {
    displayDatabases();
  } else if (selection.equals("edit")) {
    editDatabase();
  } else if (selection.equals("delete")) {
    deleteDatabase();
  } else if (selection.equals("save")) {
    saveDatabases();
  } else if (selection.equals("load")) {
    loadDatabases();
  } else if (selection.equals("quit") || selection.equals("exit")) {
    exit();
  }
}
