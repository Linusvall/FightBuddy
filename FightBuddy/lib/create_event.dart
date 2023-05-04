import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: createEventPage(),
    );
  }
}

class createEventPage extends StatefulWidget {
  @override
  _createEventPageState createState() => _createEventPageState();
}

class _createEventPageState extends State<createEventPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _nameInput = TextEditingController();
  final _dateInput = TextEditingController();
  DateTime pickedDate = DateTime.now();
  final _timeFromInput = TextEditingController();
  final _timeToInput = TextEditingController();
  final _placeInput = TextEditingController();
  final _aboutInput = TextEditingController();
  final martialArts = [
    "Boxning",
    "MMA",
    "Taekwondo",
    "Judo",
    "Karate",
    "Kickboxning",
    "Kendo",
    "Sumo",
    "Wushu",
  ];

  final eventCapacity = ["2", "3", "4", "5", "6"];
  final weightClasses = ["Inget valt", "Tungvikt", "Fjädervikt"];
  final levels = ["Inget valt", "Avancerad", "Nybörjare"];
  String? selectedMartialArts = 'Boxning';
  String? selectedCapacity = '2';
  String? selectedClass = 'Inget valt';
  String? selectedLevel = 'Inget valt';

  late TimeOfDay from;
  late TimeOfDay to;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        from = TimeOfDay.now().replacing(minute: 0);
        to = from.replacing(hour: from.hour + 1);
        _timeFromInput.text = from.format(context);
        _timeToInput.text = to.format(context);
        _dateInput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Color.fromRGBO(3, 137, 129, 50), //change your color here
            ),
            elevation: 0,
            backgroundColor: Colors.white10,
            title: const Text(
              "Skapa event",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: const <Widget>[
              //Inget här tror jag kan tas bort
            ]),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: "Namn ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                          controller: _nameInput,
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Eventets namn',
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Namnge ditt event';
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: "När ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        readOnly: true,
                        controller: _dateInput,
                        decoration: InputDecoration(
                            filled: true,
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            ),
                            hintText: 'Välj datum',
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(25.0))),
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: pickedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));

                          if (newDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(newDate);
                            setState(() {
                              pickedDate = newDate;
                              _dateInput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Välj ett datum';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              readOnly: true,
                              controller: _timeFromInput,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'Starttid',
                                prefixIcon: const Icon(Icons.access_time),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(25.0)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onTap: () async {
                                //Välj tid från här
                                TimeOfDay? newTime = await showTimePicker(
                                    context: context, initialTime: from);

                                if (newTime == null) {
                                  return;
                                }
                                setState(() {
                                  from = newTime;
                                  _timeFromInput.text = newTime.format(context);
                                });
                              },
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                              readOnly: true,
                              controller: _timeToInput,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'Sluttid',
                                prefixIcon: const Icon(Icons.access_time),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(25.0)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onTap: () async {
                                TimeOfDay? newTime = await showTimePicker(
                                    context: context, initialTime: to);

                                if (newTime == null) {
                                  return;
                                }
                                setState(() {
                                  to = newTime;
                                  _timeToInput.text = newTime.format(context);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: "Plats ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                          readOnly: true,
                          controller: _placeInput,
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon:
                                  const Icon(Icons.place, color: Colors.blue),
                              labelText: 'Lägg till plats',
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Välj en plats';
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: "Kategori ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25.0))),
                          value: selectedMartialArts,
                          onChanged: (String? value) {
                            setState(() {
                              selectedMartialArts = value!;
                            });
                          },
                          items: martialArts
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          isExpanded: true,
                          menuMaxHeight: 300,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: "Antal deltagare ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                          value: selectedCapacity,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCapacity = value!;
                            });
                          },
                          items: eventCapacity
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          isExpanded: true,
                          menuMaxHeight: 300,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(
                              text: const TextSpan(
                                text: "Nivå",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(
                              text: const TextSpan(
                                text: "Viktklass",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton<String>(
                              value: selectedLevel,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedLevel = value!;
                                });
                              },
                              items: levels.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isExpanded: true,
                              menuMaxHeight: 300,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton<String>(
                              value: selectedClass,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedClass = value!;
                                });
                              },
                              items: weightClasses
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isExpanded: true,
                              menuMaxHeight: 300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: "Om eventet ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 120,
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: _aboutInput,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Beskriv ditt event här',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor:
                              const Color.fromRGBO(3, 137, 129, 50),
                          fixedSize: const Size(250, 60),
                        ),
                        child: Row(
                          children: const [
                            Spacer(),
                            Text('SKAPA EVENT'),
                            Spacer(),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('validated');
                            //skicka grejs till databasen
                          }
                          // Navigator.push(     );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
