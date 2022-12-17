import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Challenge extends StatefulWidget {
  const Challenge({super.key});

  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  final chips = List.generate(3, (index) => 'Chip ${index + 1}').toSet();
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final focusKeyboard = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Input Chips Challenge'),
          ),
          body: RawKeyboardListener(
            focusNode: focusKeyboard,
            onKey: (key) {
              if (controller.text.isEmpty &&
                  key is RawKeyDownEvent &&
                  key.data.logicalKey == LogicalKeyboardKey.backspace) {
                setState(() {
                  chips.remove(chips.last);
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    focusNode.requestFocus();
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    isFocused: focusNode.hasFocus,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...chips.map(
                          (value) => Chip(
                            label: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onDeleted: () {
                              setState(() {
                                chips.remove(value);
                              });
                            },
                            deleteIcon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        EditableText(
                          focusNode: focusNode,
                          backgroundCursorColor: Colors.transparent,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          controller: controller,
                          maxLines: null,
                          forceLine: false,
                          // Si desean capturar el evento cuando presiona el botón DONE o SUBMIT
                          // onSubmitted: (val) {
                          //   print('VAL :$val');
                          // },
                          onChanged: (value) {
                            if (value.isEmpty) return;
                            final lastCharacter = value.characters.last;
                            if (lastCharacter == ',') {
                              final word = value.substring(0, value.length - 1);
                              setState(() {
                                chips.add(word);
                              });
                              controller.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//// Funciona pero el TextField se situa abajo.
// class Challenge extends StatefulWidget {
//   const Challenge({super.key});

//   @override
//   State<Challenge> createState() => _ChallengeState();
// }

// class _ChallengeState extends State<Challenge> {
//   final chips = List.generate(20, (index) => 'Chip ${index + 1}');
//   final controller = TextEditingController();

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Challenge'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Center(
//             child: Wrap(
//               spacing: 5,
//               runSpacing: 5,
//               children: [
//                 ...chips.map(
//                   (value) => Chip(
//                     label: Text(
//                       value,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     onDeleted: () {
//                       setState(() {
//                         chips.remove(value);
//                       });
//                     },
//                     deleteIcon: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 TextField(
//                   controller: controller,
//                   maxLines: null,

//                   // Si desean capturar el evento cuando presiona el botón DONE o SUBMIT
//                   // onSubmitted: (val) {
//                   //   print('VAL :$val');
//                   // },
//                   onChanged: (value) {
//                     final lastCharacter = value.characters.last;
//                     if (lastCharacter == ',') {
//                       final word = value.substring(0, value.length - 1);
//                       if (!chips.contains(word)) {
//                         setState(() {
//                           chips.add(word);
//                         });
//                       }
//                       controller.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
