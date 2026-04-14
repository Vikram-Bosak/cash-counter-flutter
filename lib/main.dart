import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HOME PAGE
// ═══════════════════════════════════════════════════════════════════════════════

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  
  // CASH COUNTER DATA
  final Map<String, int> cashQty = {};
  final List<Map<String, dynamic>> notes = [
    {'val': 2000, 'name': '₹2000', 'hindi': 'दो हज़ार', 'color': Colors.orange},
    {'val': 500, 'name': '₹500', 'hindi': 'पाँच सौ', 'color': Colors.brown},
    {'val': 200, 'name': '₹200', 'hindi': 'दो सौ', 'color': Colors.amber},
    {'val': 100, 'name': '₹100', 'hindi': 'एक सौ', 'color': Colors.purple},
    {'val': 50, 'name': '₹50', 'hindi': 'पचास', 'color': Colors.cyan},
    {'val': 20, 'name': '₹20', 'hindi': 'बीस', 'color': Colors.green},
    {'val': 10, 'name': '₹10', 'hindi': 'दस', 'color': Colors.red},
    {'val': 5, 'name': '₹5', 'hindi': 'पाँच', 'color': Colors.blueGrey},
    {'val': 2, 'name': '₹2', 'hindi': 'दो', 'color': Colors.grey},
    {'val': 1, 'name': '₹1', 'hindi': 'एक', 'color': Colors.orangeAccent},
  ];

  // KHATA DATA
  final List<Map<String, dynamic>> customers = [
    {'name': 'Ramesh Sharma', 'phone': '9876543210', 'amount': 12500, 'type': 'लेना'},
    {'name': 'Suresh Patel', 'phone': '9765432109', 'amount': 4200, 'type': 'देना'},
    {'name': 'Meena Devi', 'phone': '9654321098', 'amount': 8750, 'type': 'लेना'},
  ];

  // STOCK DATA
  final List<Map<String, dynamic>> stocks = [
    {'name': 'Atta 10kg', 'qty': 25, 'rate': 450},
    {'name': 'Sugar 5kg', 'qty': 40, 'rate': 220},
    {'name': 'Rice Basmati', 'qty': 100, 'rate': 180},
  ];

  int get cashTotal {
    int sum = 0;
    notes.forEach((note) {
      sum += (note['val'] as int) * (cashQty['${note['val']}'] ?? 0);
    });
    return sum;
  }

  void addCash(int val) {
    setState(() {
      cashQty['$val'] = (cashQty['$val'] ?? 0) + 1;
    });
  }

  void removeCash(int val) {
    setState(() {
      if ((cashQty['$val'] ?? 0) > 0) {
        cashQty['$val'] = cashQty['$val']! - 1;
      }
    });
  }

  void clearCash() {
    setState(() {
      cashQty.clear();
    });
  }

  void addCustomer() {
    // Navigate to add customer screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCustomerPage(
          onSave: (name, phone, amount, type) {
            setState(() {
              customers.add({
                'name': name,
                'phone': phone,
                'amount': amount,
                'type': type,
              });
            });
          },
        ),
      ),
    );
  }

  void addStock() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStockPage(
          onSave: (name, qty, rate) {
            setState(() {
              stocks.add({'name': name, 'qty': qty, 'rate': rate});
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPage == 0 ? '💰 Cash Counter' : 
          currentPage == 1 ? '📒 उधार खाता' : '📦 Stock',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          if (currentPage == 0)
            TextButton(
              onPressed: clearCash,
              child: const Text('Clear', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: currentPage == 0 
          ? buildCashCounter() 
          : currentPage == 1 
              ? buildKhata() 
              : buildStock(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        selectedItemColor: Colors.green[700],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Cash'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Khata'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Stock'),
        ],
      ),
      floatingActionButton: currentPage != 0
          ? FloatingActionButton(
              backgroundColor: Colors.green[700],
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: currentPage == 1 ? addCustomer : addStock,
            )
          : null,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CASH COUNTER PAGE
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildCashCounter() {
    return Column(
      children: [
        // TOTAL BOX
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[700]!, Colors.green[500]!],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text('कुल नकदी', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Text(
                '₹${cashTotal.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // NOTES LIST
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final val = note['val'] as int;
              final qty = cashQty['$val'] ?? 0;
              final subtotal = val * qty;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: note['color'] as Color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (note['color'] as Color).withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // NOTE NAME
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              note['hindi'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              qty > 0 ? '₹$subtotal' : 'गिनती करें',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // BUTTONS
                      Row(
                        children: [
                          // MINUS BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: const CircleBorder(),
                              minimumSize: const Size(48, 48),
                            ),
                            onPressed: () => removeCash(val),
                            child: const Icon(Icons.remove, color: Colors.white),
                          ),

                          // QUANTITY
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              '$qty',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // PLUS BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: const CircleBorder(),
                              minimumSize: const Size(48, 48),
                            ),
                            onPressed: () => addCash(val),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // KHATA PAGE
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildKhata() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final customer = customers[index];
        final isLena = customer['type'] == 'लेना';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            onTap: () {
              // Show customer details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${customer['name']} - ${customer['phone']}')),
              );
            },
            leading: CircleAvatar(
              backgroundColor: isLena ? Colors.red[100] : Colors.green[100],
              child: Icon(
                isLena ? Icons.arrow_upward : Icons.arrow_downward,
                color: isLena ? Colors.red : Colors.green,
              ),
            ),
            title: Text(
              customer['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${customer['phone']} • ${customer['type']}'),
            trailing: Text(
              '₹${customer['amount']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isLena ? Colors.red : Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STOCK PAGE
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildStock() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.inventory_2, color: Colors.orange),
            ),
            title: Text(
              stock['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('₹${stock['rate']}/unit • ${stock['qty']} in stock'),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADD CUSTOMER PAGE
// ═══════════════════════════════════════════════════════════════════════════════

class AddCustomerPage extends StatefulWidget {
  final Function(String, String, int, String) onSave;

  const AddCustomerPage({super.key, required this.onSave});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  String type = 'लेना';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नया ग्राहक'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'नाम',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'फ़ोन नंबर',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'रकम',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == 'लेना' ? Colors.red : Colors.grey[300],
                    ),
                    onPressed: () {
                      setState(() {
                        type = 'लेना';
                      });
                    },
                    child: Text('लेना', style: TextStyle(color: type == 'लेना' ? Colors.white : Colors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == 'देना' ? Colors.green : Colors.grey[300],
                    ),
                    onPressed: () {
                      setState(() {
                        type = 'देना';
                      });
                    },
                    child: Text('देना', style: TextStyle(color: type == 'देना' ? Colors.white : Colors.black)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
                    widget.onSave(
                      nameController.text,
                      phoneController.text,
                      int.tryParse(amountController.text) ?? 0,
                      type,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('सेव करें', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADD STOCK PAGE
// ═══════════════════════════════════════════════════════════════════════════════

class AddStockPage extends StatefulWidget {
  final Function(String, int, int) onSave;

  const AddStockPage({super.key, required this.onSave});

  @override
  State<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  final rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नया स्टॉक'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'आइटम का नाम',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: qtyController,
              decoration: const InputDecoration(
                labelText: 'मात्रा',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: rateController,
              decoration: const InputDecoration(
                labelText: 'दर (₹)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    widget.onSave(
                      nameController.text,
                      int.tryParse(qtyController.text) ?? 0,
                      int.tryParse(rateController.text) ?? 0,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('सेव करें', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
