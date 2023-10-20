///Project -> Water Consume Tracker
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      debugShowCheckedModeBanner: true,
      title: "Water Consume Tracker",
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _amountOfGlassTEController =
  TextEditingController(text: "0");
  List<WaterTrack> waterConsumeList = [];
  double totalAmount = 0.0;

  removeItem(index) {
    waterConsumeList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Consume Tracker"),
        centerTitle: true,
        leading: const Icon(
          Icons.water_drop_outlined,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Tips(),
                  ));
            },
            icon: const Icon(
              Icons.tips_and_updates,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total Consume",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                ),
                Text(
                  "$totalAmount Cups",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: _amountOfGlassTEController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            double amount = double.tryParse(
                                _amountOfGlassTEController.text.trim()) ??
                                1;
                            totalAmount += amount;
                            WaterTrack watertrack =
                            WaterTrack(DateTime.now(), amount);
                            waterConsumeList.add(watertrack);
                            setState(() {});
                            _amountOfGlassTEController.text = "0";
                            if (totalAmount == 8) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text(
                                        "Congratulations!",
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      content: Text(
                                          "Congratulations on consistently drinking 2 liters of water daily! Keep your body functioning at its best."),
                                    );
                                  });
                            } else if (totalAmount > 8) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.yellow,
                                          ),
                                          Text("Warning!"),
                                        ],
                                      ),
                                      content: Text(
                                          "You are exceeding the daily recommended water intake. Drinking too much might be unhealthy."),
                                    );
                                  });
                            }
                          },
                          child: const Text("Add"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: waterConsumeList.length,
                //reverse: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete!"),
                                content: const Text("Do You Want To Delete?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        totalAmount = totalAmount -
                                            waterConsumeList[index].noOfglass;
                                        setState(() {});
                                        removeItem(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok")),
                                ],
                              );
                            });
                      },
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(DateFormat("HH:mm:ss a || dd-MM-yyyy")
                          .format(waterConsumeList[index].time)),
                      trailing: Text(
                        "${waterConsumeList[index].noOfglass}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class WaterTrack {
  final DateTime time;
  final double noOfglass;

  WaterTrack(this.time, this.noOfglass);
}

class Tips extends StatelessWidget {
  const Tips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tips of Consume Water"),
          backgroundColor: Colors.cyan,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    color: Colors.cyan,
                    size: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("For men:"),
                              content: Text(
                                  "About 3.7 liters or 13 cups of total beverages per day."),
                            );
                          });
                    },
                    child: Text("Tips 01",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    color: Colors.cyan,
                    size: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("For women:"),
                              content: Text(
                                  "About 2.7 liters or 9 cups of total beverages per day."),
                            );
                          });
                    },
                    child: Text("Tips 02",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    color: Colors.cyan,
                    size: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Make it Routine:"),
                              content: Text(
                                  "Establish a regular schedule for drinking water, such as a glass when you wake up, before and after exercise, and before bed."),
                            );
                          });
                    },
                    child: Text("Tips 03",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.balance,
                    color: Colors.cyan,
                    size: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Kidney Strain:"),
                              content: Text(
                                  "Over hydration can put pressure on your kidneys as they work to excrete the excess water, potentially leading to stress and decreased function over time."),
                            );
                          });
                    },
                    child: Text("Maintain Balance",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

///Officially Coded by Team Contenders
