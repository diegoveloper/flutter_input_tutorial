import 'package:flutter/material.dart';

class Basics extends StatefulWidget {
  const Basics({super.key});

  @override
  State<Basics> createState() => _BasicsState();
}

class _BasicsState extends State<Basics> {
  void _goTo(Widget widget) => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => widget),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basics Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text('Sample 1'),
              onPressed: () => _goTo(const _Sample1()),
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('Sample 2'),
              onPressed: () => _goTo(const _Sample2()),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sample1 extends StatefulWidget {
  const _Sample1();

  @override
  State<_Sample1> createState() => __Sample1State();
}

class __Sample1State extends State<_Sample1> {
  String? errorMessage;
  String? myValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // setState(() {
        //   errorMessage = 'Hubo un error';
        // });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sample 1'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      myValue = value;
                    });
                  },
                  decoration: const InputDecoration(
                    //errorText: errorMessage,
                    //border: OutlineInputBorder(),
                    //border: UnderlineInputBorder(),
                    //border: InputBorder.none,
                    hintText: 'Hint text',
                    labelText: 'Label text',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.light),
                    suffixIcon: Icon(Icons.add_home_work_sharp),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Text(
                  myValue ?? '',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Sample2 extends StatefulWidget {
  const _Sample2();

  @override
  State<_Sample2> createState() => __Sample2State();
}

class __Sample2State extends State<_Sample2> {
  final textController = TextEditingController(text: 'my text');
  String? myValue;

  void _onTextChanged() {
    setState(() {
      myValue = textController.text;
    });
  }

  @override
  void initState() {
    textController.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sample 2'),
          actions: [
            IconButton(
              onPressed: () {
                textController.clear();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Hint text',
                    labelText: 'Label text',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.light),
                    suffixIcon: Icon(Icons.add_home_work_sharp),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Text(
                  myValue ?? '',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
