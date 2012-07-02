File myPath = new File(sketchPath("abc/def"));

println("Target directory: " + myPath);

if (!myPath.exists() ) {
  println("The path does not exist. Creating...");
  myPath.mkdirs();
} 
else {
  println("Path is already there.");
}

