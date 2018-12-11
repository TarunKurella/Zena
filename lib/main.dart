import 'package:flutter/material.dart';
import 'package:googleapis/dialogflow/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';
import 'package:stringprocess/stringprocess.dart';
import 'pages/loaded.dart';
import 'data/data.dart';

int lq = 0;  // variable which tracks question to be asked from the list.

String personality = "hi";
String dummyData = Dummydata();
int lengthOfBlob;
int lengthOfChat=0;

List questions = ReturnQuestions();

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter App',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new ChatMessages(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatMessages extends StatefulWidget {


  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages>
    with TickerProviderStateMixin {
  List<ChatMessage> _messages = List<ChatMessage>();
  bool _isComposing = false;

  TextEditingController _controllerText = new TextEditingController();
  var tps = new StringProcessor();

  DialogflowApi _dialog;

  @override
  void initState() {
    super.initState();
    _initChatbot();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            padding: new EdgeInsets.only(top: statusBarHeight),
            height: statusBarHeight + 66.0,
            child: Column(
              children: <Widget>[
                buildHeading(),
                SizedBox(
                  height: 5.0,
                ),
                buildFooter()
              ],
            )),
        Divider(
          color: Colors.deepPurple,
        ),
        _buildList(),
        Divider(height: 8.0, color: Theme.of(context).accentColor),
        _buildComposer()
      ],
    ));
  }

  buildHeading()
  {
    return Center(
      child: new Text("Z E N A",
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 30.0)),
    );
  }

  buildFooter(){
    return Center(
      child: Text(
        "Recruiters Helping Hand",
        style: TextStyle(color: Colors.grey, fontSize: 10.0),
      ),
    );
  }

  _buildList() {
    return Flexible(
      child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemCount: _messages.length,
          itemBuilder: (_, index) {
            return Container(child: ChatMessageListItem(_messages[index]));
          }),
    );
  }

  _buildComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controllerText,
              onChanged: (value) {
                setState(() {
                  _isComposing = _controllerText.text.length > 0;
                });
              },
              onSubmitted: _handleSubmit,
              decoration:
                  InputDecoration.collapsed(hintText: " type something.."),
            ),
          ),
          InkWell(
            //For testing purposes, long press the user icon to pass dummy blob of data to api.
            onLongPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return tag(dummyData);
              }));
            },
            child: new IconButton(
                icon: Icon(Icons.assignment_ind),
                onPressed: () {

                  if (lengthOfChat > 600) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return tag(personality);
                    }));
                  } else {

                    String wait =
                        "more ${600 - lengthOfChat} words to understand you deeper :)";
                    // Api needs atleast 600 words to perform analysis.
                    _addMessage(
                      text: wait,
                      name: "John Doe",
                      initials: "DJ",
                      bot: true,
                    );
                    lq--;
                  }
                }),
          ),
          new IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.deepPurpleAccent,
            ),
            onPressed:
                _isComposing ? () => _handleSubmit(_controllerText.text) : null,
          ),
        ],
      ),
    );
  }


  //This function gets called to display message from bot
  askquestion(String value) {
    _addMessage(
      text: questions[lq],
      name: "John Doe",
      initials: "DJ",
      bot: true,
    );
    lq++;
  }

  //This function gets called to display message from bot after getting a query error from Dialogflow.
  askquestion1(String value) {
    String text1;
    if (value.contains("?"))
      text1 = "Anyways\n" + "${questions[lq]}";
    else
      text1 = "Cool!" + " " + "so" + " " + "${questions[lq]}";

    _addMessage(
      text: text1,
      name: "User",
      initials: "U",
      bot: true,
    );
    lq++;
  }

  //this function gets called whenever user submits

  _handleSubmit(String value) {
    _controllerText.clear();
    _addMessage(
      text: value,
      name: "user",
      initials: "U",
    );
    lengthOfBlob = tps.getWordCount("$value");
    lengthOfChat=lengthOfBlob+lengthOfChat;
    personality = personality + "." + value;

    //if user's input has Question, it sends request for info to dialogflow..like what are your hobbies zenna?
    if (!value.contains("?"))
      askquestion(value);
    // if user gives answer, zena goes with asking question with local list.
    else
      _requestChatBot(value);
  }

  _requestChatBot(String text) async {
    var dialogSessionId = "projects/hello-41e09/agent/sessions/helo";

    Map data = {
      "queryInput": {
        "text": {
          "text": text,
          "languageCode": "fr",
        }
      }
    };

    var request = GoogleCloudDialogflowV2DetectIntentRequest.fromJson(data);

    var resp = await _dialog.projects.agent.sessions
        .detectIntent(request, dialogSessionId);
    var result = resp.queryResult;
    _addMessage(
        name: "Chat Bot",
        initials: "CB",
        bot: true,
        text: result.fulfillmentText);
    askquestion1(result.fulfillmentText);
  }

  void _initChatbot() async {
    String configString = await rootBundle.loadString('config/dialogflow.json');
    String _dialogFlowConfig = configString;

    var credentials = new ServiceAccountCredentials.fromJson(_dialogFlowConfig);

    const _SCOPES = const [DialogflowApi.CloudPlatformScope];

    var httpClient = await clientViaServiceAccount(credentials, _SCOPES);
    _dialog = new DialogflowApi(httpClient);
  }

  void _addMessage(
      {String name, String initials, bool bot = false, String text}) {
    var animationController = AnimationController(
      duration: new Duration(milliseconds: 700),
      vsync: this,
    );

    var message = ChatMessage(
        name: name,
        text: text,
        initials: initials,
        bot: bot,
        animationController: animationController);

    setState(() {
      _messages.insert(0, message);
    });

    animationController.forward();
  }
}

class ChatMessage {
  final String name;
  final String initials;
  final String text;
  final bool bot;

  AnimationController animationController;

  ChatMessage(
      {this.name,
      this.initials,
      this.text,
      this.bot = false,
      this.animationController});
}

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  ChatMessageListItem(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: chatMessage.bot
          ? Container(
              child: SizeTransition(
                child: ChatBotBox(chatMessage.text),
                sizeFactor: CurvedAnimation(
                    parent: chatMessage.animationController,
                    curve: Curves.easeOut),
              ),
              margin: const EdgeInsets.only(right: 16.0),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0))
          : Container(
              child: UserBox(chatMessage.text),
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0)),
    );
  }
}


// UI Element for Displaying chatbot's message
class ChatBotBox extends StatelessWidget {
  ChatBotBox(this.pass);

  String pass;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      new Container(
        margin: EdgeInsets.only(left: 10.0),
        child: new CircleAvatar(
          radius: 15.0,
          backgroundImage: new AssetImage("images/hello-2.png"),
          backgroundColor: Colors.black,
        ),
      ),
      new Expanded(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
            child: new Text(pass),
          ),
        ],
      ))
    ]);
  }
}

// UI Element for Displaying User's message
class UserBox extends StatelessWidget {
  String pass;

  UserBox(this.pass);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 16.0),
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          width: 200.0,
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF00E676),
                    const Color(0xFFCCFF90),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(8.0)),
          child: new Text(pass),
        ),
      ],
    );
  }
}
