/* How to do simple calendar calculations */

String myDateString = "6/21/2012 3:12:00 AM";
DateFormat myDateFormat = new SimpleDateFormat("M/d/yyyy h:mm:ss a");


/* Conversion */
Date myOldTime = null;

try {
   myOldTime = myDateFormat.parse( myDateString );
} catch (Exception e) {
  println("Could not parse date.");
}


/* Calculation */
if( myOldTime != null ) {    // Did we succeed parsing the date string?

  java.util.Calendar myCalendar = GregorianCalendar.getInstance();  // We need a calendar to calculate stuff
  myCalendar.setTime(myOldTime); // Put the time in the calendar
  myCalendar.add(java.util.Calendar.DATE, 14 ); // Add 14 days
  myCalendar.add(java.util.Calendar.HOUR, 8 ); // Add 8 hours

  Date myNewTime = myCalendar.getTime(); // Get the new time back


  /* Format and output */
  println( "Time at the beginning was:" );
  println( myDateFormat.format( myOldTime ) );
  
  println( "Time is now:" );
  println( myDateFormat.format( myNewTime ) );
}
 


