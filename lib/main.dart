import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
    await Hive.openBox('cash_counter_db');
  } catch (e) {
    debugPrint('Hive init error: $e');
  }
  runApp(const CashCounterApp());
}

class CashCounterApp extends StatelessWidget {
  const CashCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF15803D),
          brightness: Brightness.light,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const KhataScreen(),
    const CashCounterScreen(),
    const StockScreen(),
    const NotesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.book_outlined), selectedIcon: Icon(Icons.book), label: 'Khata'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), selectedIcon: Icon(Icons.payments), label: 'Cash'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Stock'),
          NavigationDestination(icon: Icon(Icons.note_alt_outlined), selectedIcon: Icon(Icons.note_alt), label: 'Notes'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HOME SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF052e16),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF052e16), Color(0xFF15803D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Namaste 🙏', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
                                const SizedBox(height: 4),
                                const Text('Aaj ka Hisaab', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                                  child: IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                                  child: IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('KUL BALANCE', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text('₹2,45,820', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _buildBalancePill('Dena', '₹45.2K', const Color(0xFFef4444)),
                                  const SizedBox(width: 10),
                                  _buildBalancePill('Lena', '₹1.23L', const Color(0xFF4ade80)),
                                  const SizedBox(width: 10),
                                  _buildBalancePill('Bachat', '₹3,200', const Color(0xFFf59e0b)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kya karna hai?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _buildModuleCard('💰', 'Cash Count', 'Nakdi ginein', const Color(0xFFdcfce7)),
                      _buildModuleCard('📒', 'Udhar Khata', 'Credit/Debit', const Color(0xFFdbeafe)),
                      _buildModuleCard('📈', 'Amdani', 'Income/Expense', const Color(0xFFede9fe)),
                      _buildModuleCard('📦', 'Stock', 'Maal ka hisaab', const Color(0xFFfee2e2)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Haal Ki Khabar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildTransactionCard('Ramesh Sharma', 'Gehu ka hisaab', '₹5,000', true),
                  _buildTransactionCard('Suresh Patel', 'Pichli bakaya', '₹2,000', false),
                  _buildTransactionCard('Meena Devi', 'Aaj ki payment', '₹1,500', true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalancePill(String label, String amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(amount, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 9)),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(String icon, String title, String subtitle, Color bgColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)), child: Center(child: Text(icon, style: const TextStyle(fontSize: 22)))),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(String name, String note, String amount, bool isCredit) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: isCredit ? const Color(0xFFfee2e2) : const Color(0xFFdcfce7), borderRadius: BorderRadius.circular(12)),
          child: Icon(isCredit ? Icons.arrow_upward : Icons.arrow_downward, color: isCredit ? Colors.red : Colors.green),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(note, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.w800, color: isCredit ? Colors.red : Colors.green, fontSize: 15)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// KHATA SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class KhataScreen extends StatelessWidget {
  const KhataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parties = [
      {'name': 'Ramesh Sharma', 'amount': 12500, 'type': 'credit', 'phone': '98765 43210'},
      {'name': 'Suresh Patel', 'amount': 4200, 'type': 'debit', 'phone': '97654 32109'},
      {'name': 'Meena Devi', 'amount': 8750, 'type': 'credit', 'phone': '96543 21098'},
      {'name': 'Kishan Agrawal', 'amount': 22000, 'type': 'credit', 'phone': '95432 10987'},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF052e16),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF052e16), Color(0xFF166534)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('📒 Udhar Khata', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            Container(
                              decoration: BoxDecoration(color: const Color(0xFFf59e0b), borderRadius: BorderRadius.circular(20)),
                              child: TextButton.icon(
                                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                                label: const Text('Khata', style: TextStyle(color: Colors.white)),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildSummaryPill('Milna Hai', '₹45.2K', const Color(0xFFef4444)),
                            const SizedBox(width: 10),
                            _buildSummaryPill('Dena Hai', '₹4.2K', const Color(0xFF4ade80)),
                            const SizedBox(width: 10),
                            _buildSummaryPill('Log', '4', Colors.white.withOpacity(0.3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildPartyCard(parties[index]),
              childCount: parties.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF16a34a),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSummaryPill(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 9)),
          ],
        ),
      ),
    );
  }

  Widget _buildPartyCard(Map<String, dynamic> party) {
    final isCredit = party['type'] == 'credit';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: isCredit ? const Color(0xFFfee2e2) : const Color(0xFFdcfce7),
          child: Text(
            party['name'].toString().split(' ').map((e) => e[0]).take(2).join(),
            style: TextStyle(color: isCredit ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(party['name'], style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('📱 ${party['phone']}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${party['amount'].toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
              style: TextStyle(fontWeight: FontWeight.w800, color: isCredit ? Colors.red : Colors.green, fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: isCredit ? const Color(0xFFfee2e2) : const Color(0xFFdcfce7), borderRadius: BorderRadius.circular(8)),
              child: Text(isCredit ? '⬆ Lena' : '⬇ Dena', style: TextStyle(fontSize: 10, color: isCredit ? Colors.red : Colors.green, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CASH COUNTER SCREEN - WITH REAL NOTE COLORS
// ═══════════════════════════════════════════════════════════════════════════════

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({super.key});

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {
  final Map<int, int> _quantities = {};
  
  // Indian Currency Notes with REAL colors
  final List<Map<String, dynamic>> _denominations = [
    {'val': 2000, 'label': '₹2000', 'sub': 'Do Hazaar', 'c1': const Color(0xFFFF5F00), 'c2': const Color(0xFFFF8C00)}, // Orange
    {'val': 500, 'label': '₹500', 'sub': 'Paanch Sau', 'c1': const Color(0xFF8B4513), 'c2': const Color(0xFFA0522D)}, // Brown
    {'val': 200, 'label': '₹200', 'sub': 'Do Sau', 'c1': const Color(0xFFFFD700), 'c2': const Color(0xFFFFA500)}, // Gold
    {'val': 100, 'label': '₹100', 'sub': 'Ek Sau', 'c1': const Color(0xFF4B0082), 'c2': const Color(0xFF6A0DAD)}, // Purple
    {'val': 50, 'label': '₹50', 'sub': 'Pachaas', 'c1': const Color(0xFF00CED1), 'c2': const Color(0xFF20B2AA)}, // Cyan
    {'val': 20, 'label': '₹20', 'sub': 'Bees', 'c1': const Color(0xFF228B22), 'c2': const Color(0xFF32CD32)}, // Green
    {'val': 10, 'label': '₹10', 'sub': 'Das', 'c1': const Color(0xFFFF6347), 'c2': const Color(0xFFFF7F50)}, // Tomato
    {'val': 5, 'label': '₹5', 'sub': 'Paanch', 'c1': const Color(0xFF4682B4), 'c2': const Color(0xFF5F9EA0)}, // Steel Blue
    {'val': 2, 'label': '₹2', 'sub': 'Do', 'c1': const Color(0xFF708090), 'c2': const Color(0xFF778899)}, // Gray
    {'val': 1, 'label': '₹1', 'sub': 'Ek', 'c1': const Color(0xFFB8860B), 'c2': const Color(0xFFDAA520)}, // Dark Golden
  ];

  int get _total => _denominations.fold(0, (sum, d) => sum + (d['val'] as int) * (_quantities[d['val']] ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF052e16),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF052e16), Color(0xFF16a34a)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('💰 Cash Count', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.history, color: Colors.white), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {}),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('KUL NAKDI', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(
                          '₹${_total.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                          style: const TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final d = _denominations[index];
                final qty = _quantities[d['val']] ?? 0;
                final subtotal = (d['val'] as int) * qty;
                final c1 = d['c1'] as Color;
                final c2 = d['c2'] as Color;
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [c1, c2], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: c1.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Note Label
                        Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                          ),
                          child: Center(
                            child: Text(d['label'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Hindi Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d['sub'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                              Text(
                                qty > 0 ? '₹${subtotal.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}' : 'Ginti karein',
                                style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        // Counter
                        Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: Colors.red),
                                iconSize: 20,
                                onPressed: () => setState(() => _quantities[d['val']] = (qty - 1).clamp(0, 99999)),
                              ),
                              SizedBox(width: 40, child: Text('$qty', textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                              IconButton(
                                icon: const Icon(Icons.add, color: Colors.green),
                                iconSize: 20,
                                onPressed: () => setState(() => _quantities[d['val']] = qty + 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: _denominations.length,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STOCK SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Atta (10kg)', 'rate': '₹450', 'stock': '25 pieces'},
      {'name': 'Sugar (5kg)', 'rate': '₹220', 'stock': '40 pieces'},
      {'name': 'Rice (Basmati)', 'rate': '₹180/kg', 'stock': '100 kg'},
      {'name': 'Dal (Toor)', 'rate': '₹140/kg', 'stock': '50 kg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('📦 Stock / Items'),
        backgroundColor: const Color(0xFF052e16),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.inventory_2, color: Colors.red),
              ),
              title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${item['rate']} • ${item['stock']}', style: TextStyle(color: Colors.grey.shade600)),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF16a34a),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// NOTES SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = [
      {'title': 'Market List', 'content': 'Aata, Daal, Tel, Chawal...', 'date': '14 Apr 2026'},
      {'title': 'Payment Pending', 'content': 'Ramesh se ₹5000 lene hain', 'date': '13 Apr 2026'},
      {'title': 'Meeting Notes', 'content': 'Supplier se baat karni hai', 'date': '12 Apr 2026'},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: const Color(0xFF052e16),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF052e16), Color(0xFF166534)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('📝 Notes', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final note = notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.note_alt, color: Colors.purple),
                    ),
                    title: Text(note['title']!, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(note['content']!, style: TextStyle(color: Colors.grey.shade700)),
                        const SizedBox(height: 4),
                        Text(note['date']!, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
              childCount: notes.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF16a34a),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SETTINGS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: const Color(0xFF052e16),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF052e16), Color(0xFF166534)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('⚙️ Settings', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)),
                      child: const Icon(Icons.business, color: Colors.green, size: 28),
                    ),
                    title: const Text('Mera Business', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: const Text('PC Computer • Amreli, Gujarat'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(20)),
                      child: const Text('FREE', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
              _buildSettingSection('App', [
                {'icon': Icons.language, 'label': 'Bhasha Badlo', 'sub': 'Abhi: Hindi'},
                {'icon': Icons.fingerprint, 'label': 'App Lock', 'sub': 'Fingerprint ON'},
                {'icon': Icons.palette, 'label': 'Theme', 'sub': 'Light Mode'},
              ]),
              _buildSettingSection('Data & Backup', [
                {'icon': Icons.cloud_upload, 'label': 'Drive Backup', 'sub': 'Last: Kal 11PM'},
                {'icon': Icons.download, 'label': 'Import Karein', 'sub': 'Drive se restore'},
                {'icon': Icons.folder_open, 'label': 'Export All', 'sub': 'PDF, Excel'},
              ]),
              _buildSettingSection('More', [
                {'icon': Icons.star, 'label': 'App ko Rate Karein', 'sub': 'Play Store par'},
                {'icon': Icons.diamond, 'label': 'Premium Unlock', 'sub': 'Ad-free experience'},
                {'icon': Icons.info, 'label': 'App ke Baare Mein', 'sub': 'v4.2.0 • PC Computer Amreli'},
              ]),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text('Cash Counter v4.2.0 • PC Computer Amreli', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Map<String, dynamic>> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 0.8)),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: items.map((item) => ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                  child: Icon(item['icon'] as IconData, color: Colors.grey.shade700),
                ),
                title: Text(item['label'], style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(item['sub'], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
