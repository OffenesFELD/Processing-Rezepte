import java.net.*;

class PositalRotaryEncoder {  
  private static final String FIELD_POSITION = "POSITION";
  private static final String FIELD_VELOCITY = "VELOCITY";

  private static final String QUERY_STRING = "Run!";
  private static final int SOCKET_TIMEOUT = 100; // ms

  private static final String PATTERN = "([a-zA-Z0-9]*)=([-]*\\d*)"; 
  private final Pattern _myCompiledPattern;

  private  DatagramSocket _mySocket;
  private InetAddress _myAddress;
  private final int _myPort;

  private int _myResolution;
  private int _myRawPosition = 0;
  private int _myRawVelocity = 0;


  public PositalRotaryEncoder(int theSteps, String theAddressString, int thePort) {
    _myPort = thePort;
    _myResolution = theSteps;

    _myCompiledPattern = Pattern.compile(PATTERN);

    try {
      _mySocket = new DatagramSocket();
      _mySocket.setSoTimeout(SOCKET_TIMEOUT);
      _myAddress = InetAddress.getByName(theAddressString);
    } 
    catch(SocketException e) {
      println("ERROR: Could not open socket. Reason: " + e);
    } 
    catch(UnknownHostException e) {
      println("ERROR: Address not found: " + theAddressString);
    }
  }


  public void close() {
    if (_mySocket != null) {
      _mySocket.close();
    }
  }


  public void query() {
    if (_mySocket != null) {

      try {
        byte[] mySendBuffer = QUERY_STRING.getBytes();
        byte[] myReceiveBuffer = new byte[1024];

        DatagramPacket myQueryPacket = new DatagramPacket(mySendBuffer, mySendBuffer.length, _myAddress, _myPort);
        _mySocket.send(myQueryPacket);

        DatagramPacket myAnswerPacket = new DatagramPacket(myReceiveBuffer, myReceiveBuffer.length); 
        _mySocket.receive(myAnswerPacket);

        String myAnswerString = new String(myAnswerPacket.getData());

        parseAnswerString( myAnswerString );
      } 
      catch(IOException e) {
        println("ERROR: Could not communicate with encoder: " + e);
      }
    }
  }


  public int rawPosition() {
    return _myRawPosition;
  }


  public int rawVelocity() {
    return _myRawVelocity;
  }


  public float rotation() {
    return (float)((_myRawPosition / (double)_myResolution) * Math.PI * 2) ;
  }


  public float velocity() {
    return (float)((_myRawVelocity / (double)_myResolution) * Math.PI * 2) ;
  }


  private void parseAnswerString(final String theString) {
    for ( MatchResult myMatch : parseResponseParts( theString ) ) {
      if ( myMatch.groupCount() == 2) {
        if ( myMatch.group(1).equalsIgnoreCase( FIELD_POSITION ) ) {
          _myRawPosition = Integer.valueOf( myMatch.group(2) );
        }

        if ( myMatch.group(1).equalsIgnoreCase( FIELD_VELOCITY ) ) {
          _myRawVelocity = Integer.valueOf( myMatch.group(2) );
        }
      } 
      else {
        println("WARNING: Encountered answer string from the encoder that I could not parse: " + theString);
      }
    }
  }


  private List<MatchResult> parseResponseParts(String theAnswerString) { 
    final List<MatchResult> myResults = new ArrayList<MatchResult>(); 

    for ( Matcher myMatcher = _myCompiledPattern.matcher(theAnswerString); myMatcher.find(); ) {
      myResults.add( myMatcher.toMatchResult() );
    }

    return myResults;
  }
}

