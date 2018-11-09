class Entry {
  String title;
  String platform;
  int yearAcquired;
  int yearPublished;

  Entry (String title, String platform, int yearAcquired, int yearPublished) {
    this.title = title;
    this.platform = platform;
    this.yearAcquired = yearAcquired;
    this.yearPublished = yearPublished;
  }
}

class Database {
  String name;
  ArrayList <Entry> entryList = new ArrayList <Entry>();

  Database (String name) {
    this.name = name;
  }

  void createEntry () {
    println();
    println("===NEW ENTRY===");
    println();
    println("Creating a new entry in the " + name + " database");
    String title = getString("Enter the title of the game");
    String platform = getString("Enter the platform that the game runs on");
    int yearAcquired = getInt("Enter the year you acquired the game");
    int yearPublished = getInt("Enter the year that the game was published");
    entryList.add (new Entry (title, platform, yearAcquired, yearPublished));
  }

  void editEntry (int value) {
    entryList.get(value).title = getString("Enter the title of the game");
    entryList.get(value).platform = getString("Enter the platform that the game runs on");
    entryList.get(value).yearAcquired = getInt("Enter the year you acquired the game");
    entryList.get(value).yearPublished = getInt("Enter the year that the game was published");
  }

  void deleteEntry (int value) {
    entryList.remove(entryList.get(value));
  }

  void displayEntries () {
    println();
    println("Database: " + name);
    println("{");
    println("  ===ENTRIES===");
    println();
    for (int i = 0; i < entryList.size(); i++) {
      println("  ID: " + (i + 1) + " - Game Title: " + entryList.get(i).title + " | Game Platform: " + entryList.get(i).platform + " | Year Published: " + entryList.get(i).yearPublished + " | Year Acquired: " + entryList.get(i).yearAcquired);
    }
    println();
    println("  ===END OF ENTRIES===");
    println("}");
    println();
  }

  void selectEntry () {
    String selection;
    int value;
    displayEntries();
    value = getInt("Choose the ID value of the entry you want to choose");
    value -= 1;
    selection = getString("Would you like to edit or delete an entry");
    selection.toLowerCase();
    if (selection.equals("edit")) {
      editEntry(value);
    } else if (selection.equals("delete")) {
      deleteEntry(value);
    }
  }
}

// Universal Methods

void selectDatabase() {
  String selection;
  int value;
  displayDatabases();
  value = getInt("Choose the ID value of the database you want to choose");
  value -= 1;
  selection = getString("Do you want to make a NEW entry, DISPLAY entires, or SELECT an entry?");
  selection.toLowerCase();
  if (selection.equals("new")) {
    databases.get(value).createEntry();
  } else if (selection.equals("display")) {
    databases.get(value).displayEntries();
  } else if (selection.equals("select")) {
    databases.get(value).displayEntries();
    databases.get(value).selectEntry();
  }
}

void createDatabase() {
  println();
  println("===NEW DATABASE===");
  println();
  String confirm = "";
  String name = "";
  while (confirm == "" || confirm == "no") {
    name = getString("Enter the name of this new database");
    confirm = getString("Are you sure you want the name to be " + name + "?");
  }
  databases.add (new Database (name));
}

void displayDatabases() {
  println();
  println("===CURRENT DATABASES===");
  println();
  for (int i = 0; i < databases.size(); i++) {
    println("ID: " + (i + 1) + " - " + databases.get(i).name);
  }
  println();
  println("===END OF DATABASES===");
  println();
}

void editDatabase() {
  String confirm = "";
  String name = "";
  int id;
  displayDatabases();
  id = getInt("Enter the ID of the database you want to edit");
  id -= 1;
  while (confirm == "" || confirm == "no") {
    name = getString("Enter the name of this database");
    confirm = getString("Are you sure you want the name to be " + name + "?");
  }
}

void deleteDatabase() {
  int id;
  displayDatabases();
  id = getInt("Enter the ID of the database you want to delete");
  id -= 1;
  databases.remove(databases.get(id));
}

void saveDatabases() { // Incomplete. Need to work on the file architecture
  saveDatabase = createWriter("databases.txt");
  for (int i = 0; i < databases.size(); i++) { // save the database
    saveDatabase.print("Database - " + databases.get(i).name);
    for (int j = 0; j < databases.get(i).entryList.size(); j++) { // save the entries in a database
      saveDatabase.println(" | name("+ databases.get(i).entryList.get(j).title +"), platform("+ databases.get(i).entryList.get(j).platform +"), yearAcq("+ databases.get(i).entryList.get(j).yearAcquired +"), yearPub("+ databases.get(i).entryList.get(j).yearPublished +")");
    }
    saveDatabase.println(); // create a new line for the next database
  }
  saveDatabase.flush();
  saveDatabase.close();
  println("===CURRENT BUILD SAVED===");
}

void loadDatabases() { // Incomplete. Need to finish the save file before parsing is possible
  BufferedReader parser = createReader("databases.txt");
  String line = null;
  String word = "";
  int charVal = 11;
  int id = -1;
  try {
    while ((line = parser.readLine()) != null) {
      if (line.contains("Database - ")) { // find the database names
        while (line.charAt(charVal) != '|') {
          word += line.charAt(charVal);
          charVal++;
        }
        charVal = 11;
        databases.add (new Database (word));
        id++;
        println(word);
        word = "";
      } if (line.contains("name(")) { // find the names of the game entries
        String title = "";
        String platform = "";
        int yearAcq = 0;
        int yearPub = 0;
        int currentChar = line.indexOf("name(") + 5;

          while (line.charAt(currentChar) != ')') {
            word += line.charAt(currentChar);
            currentChar++;
          }
          title = word;
          println(title);
          word = "";

          if (line.contains("platform(")) {
            currentChar = line.indexOf("platform(") + 9;
            while(line.charAt(currentChar) != ')') {
              word += line.charAt(currentChar);
              currentChar++;
            }
            platform = word;
            println(platform);
            word = "";
          }

          if (line.contains("yearAcq(")) {
            currentChar = line.indexOf("yearAcq(") + 8;
            while(line.charAt(currentChar) != ')') {
              word += line.charAt(currentChar);
              currentChar++;
            }
            yearAcq = Integer.parseInt(word);
            println(yearAcq);
            word = "";
          }

          if (line.contains("yearPub(")) {
            currentChar = line.indexOf("yearPub(") + 8;
            while(line.charAt(currentChar) != ')') {
              word += line.charAt(currentChar);
              currentChar++;
            }
            yearPub = Integer.parseInt(word);
            println(yearPub);
            word = "";
          }
          databases.get(id).entryList.add (new Entry (title, platform, yearAcq, yearPub));
        }
    }
    parser.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  println("===DATABASES LOADED===");
}
