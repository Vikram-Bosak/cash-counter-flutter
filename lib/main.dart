import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cash_counter_db');
  runApp(const CashCounterApp());
}

class CashCounterApp extends StatelessWidget {
  const CashCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Cash Counter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF15803D),
            brightness: Brightness.light,
          ),
          fontFamily: 'Poppins',
        ),
        home: const MainScreen(),
      ),
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
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Khata'),
          NavigationDestination(icon: Icon(Icons.payments), label: 'Cash'),
          NavigationDestination(icon: Icon(Icons.inventory), label: 'Stock'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

// ─── SCREENS ────────────────────────────────────────────────────────────────

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
                                Text(
                                  'Namaste 🙏',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  'Aaj ka Hisaab',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.search, color: Colors.white),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                                  onPressed: () {},
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
                              Text(
                                'KUL BALANCE',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '₹2,45,820',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'JetBrainsMono',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _buildBalancePill('Dena Baaki', '₹45.2K', const Color(0xFFef4444)),
                                  const SizedBox(width: 10),
                                  _buildBalancePill('Lena Baaki', '₹1.23L', const Color(0xFF4ade80)),
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
                  const Text(
                    'Kya karna hai?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _buildModuleCard(context, '💰', 'Cash Count', 'Nakdi ginein', const Color(0xFFdcfce7)),
                      _buildModuleCard(context, '📒', 'Udhar Khata', 'Credit/Debit', const Color(0xFFdbeafe)),
                      _buildModuleCard(context, '📈', 'Amdani', 'Income/Expense', const Color(0xFFede9fe)),
                      _buildModuleCard(context, '📦', 'Stock', 'Maal ka hisaab', const Color(0xFFfee2e2)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Haal Ki Khabar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildTransactionCard('Ramesh Sharma', 'Gehu ka hisaab', '₹5,000', true),
                  _buildTransactionCard('Suresh Patel', 'Pichli bakaya', '₹2,000', false),
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
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String icon, String title, String subtitle, Color bgColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
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
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isCredit ? const Color(0xFFfee2e2) : const Color(0xFFdcfce7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(isCredit ? Icons.arrow_upward : Icons.arrow_downward, color: isCredit ? Colors.red : Colors.green),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(note, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: isCredit ? Colors.red : Colors.green,
            fontFamily: 'JetBrainsMono',
          ),
        ),
      ),
    );
  }
}

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
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF052e16), Color(0xFF166534)],
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
                            const Text(
                              '📒 Udhar Khata',
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('Khata'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFf59e0b),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  onPressed: () => _showAddPartyDialog(context),
                                ),
                              ],
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
              (context, index) {
                final party = parties[index];
                return _buildPartyCard(party);
              },
              childCount: parties.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF16a34a),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _showAddTransactionDialog(context),
      ),
    );
  }

  Widget _buildSummaryPill(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'JetBrainsMono')),
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📱 ${party['phone']}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            Text('Akhri: Kal • ₹500', style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${party['amount'].toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: isCredit ? Colors.red : Colors.green,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isCredit ? const Color(0xFFfee2e2) : const Color(0xFFdcfce7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isCredit ? '⬆ Lena Hai' : '⬇ Dena Hai',
                style: TextStyle(fontSize: 10, color: isCredit ? Colors.red : Colors.green, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPartyDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Naya Khata'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(decoration: InputDecoration(labelText: 'Naam', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Phone', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
        ],
      ),
      actions: [
        TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
        ElevatedButton(child: const Text('Save'), onPressed: () => Navigator.pop(context)),
      ],
    ));
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Naya Hisaab'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100, foregroundColor: Colors.red),
                  child: const Text('⬆ Credit'),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade100, foregroundColor: Colors.green),
                  child: const Text('⬇ Debit'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount (₹)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
        ElevatedButton(child: const Text('Save'), onPressed: () => Navigator.pop(context)),
      ],
    ));
  }
}

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({super.key});

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {
  final Map<int, int> _quantities = {};
  final List<Map<String, dynamic>> _denominations = [
    {'val': 2000, 'label': '₹2000', 'sub': 'Do Hazaar', 'color': const Color(0xFFfce7f3)},
    {'val': 500, 'label': '₹500', 'sub': 'Paanch Sau', 'color': const Color(0xFFede9fe)},
    {'val': 200, 'label': '₹200', 'sub': 'Do Sau', 'color': const Color(0xFFffedd5)},
    {'val': 100, 'label': '₹100', 'sub': 'Ek Sau', 'color': const Color(0xFFdbeafe)},
    {'val': 50, 'label': '₹50', 'sub': 'Pachaas', 'color': const Color(0xFFd1fae5)},
    {'val': 20, 'label': '₹20', 'sub': 'Bees', 'color': const Color(0xFFfef3c7)},
    {'val': 10, 'label': '₹10', 'sub': 'Das', 'color': const Color(0xFFecfccb)},
    {'val': 5, 'label': '₹5', 'sub': 'Paanch (Coin)', 'color': const Color(0xFFf1f5f9)},
    {'val': 2, 'label': '₹2', 'sub': 'Do (Coin)', 'color': const Color(0xFFf8fafc)},
    {'val': 1, 'label': '₹1', 'sub': 'Ek (Coin)', 'color': const Color(0xFFf9fafb)},
  ];

  int get _total {
    return _denominations.fold(0, (sum, d) => sum + (d['val'] as int) * (_quantities[d['val']] ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF052e16), Color(0xFF16a34a)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '💰 Cash Count',
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                        if (_total >= 100000)
                          Text(
                            '${(_total / 100000).toStringAsFixed(2)} Lakh',
                            style: TextStyle(color: Colors.green.shade300, fontSize: 14),
                          ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildQuickChip('Reset'),
                            _buildQuickChip('PDF Export'),
                            _buildQuickChip('WhatsApp'),
                            _buildQuickChip('Save'),
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
              (context, index) {
                final d = _denominations[index];
                final qty = _quantities[d['val']] ?? 0;
                final subtotal = (d['val'] as int) * qty;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: qty > 0 ? const Color(0xFFf0fdf4) : Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: d['color'],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(d['label'], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(d['sub'], style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color: Colors.green,
                            onPressed: () => setState(() => _quantities[d['val']] = (qty - 1).clamp(0, 99999)),
                          ),
                          Text('$qty', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'JetBrainsMono')),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            color: Colors.green,
                            onPressed: () => setState(() => _quantities[d['val']] = qty + 1),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 70,
                        child: Text(
                          '₹${subtotal.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: subtotal > 0 ? Colors.green.shade700 : Colors.grey.shade400,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildQuickChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }
}

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📦 Stock / Items'),
        backgroundColor: const Color(0xFF052e16),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItemCard('Atta (10kg)', '₹450', '25 pieces'),
          _buildItemCard('Sugar (5kg)', '₹220', '40 pieces'),
          _buildItemCard('Rice (Basmati)', '₹180/kg', '100 kg'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF16a34a),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _buildItemCard(String name, String rate, String stock) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFfee2e2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.inventory_2, color: Colors.red),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('$rate • $stock', style: TextStyle(color: Colors.grey.shade600)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

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
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF052e16), Color(0xFF166534)],
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
                        const Text(
                          '⚙️ Settings',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
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
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFdcfce7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.business, color: Colors.green, size: 28),
                    ),
                    title: const Text('Mera Business', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: const Text('PC Computer • Amreli, Gujarat'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFfef3c7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('FREE', style: TextStyle(color: Color(0xFFb45309), fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
              _buildSettingSection('App', [
                {'icon': Icons.language, 'label': 'Bhasha Badlo', 'sub': 'Abhi: Hindi'},
                {'icon': Icons.fingerprint, 'label': 'App Lock', 'sub': 'Fingerprint ON', 'toggle': true},
                {'icon': Icons.palette, 'label': 'Theme', 'sub': 'Light Mode'},
              ]),
              _buildSettingSection('Data & Backup', [
                {'icon': Icons.cloud_upload, 'label': 'Drive Backup', 'sub': 'Last: Kal 11PM'},
                {'icon': Icons.download, 'label': 'Import Karein', 'sub': 'Drive se restore'},
                {'icon': Icons.folder_open, 'label': 'Export All', 'sub': 'PDF, Excel'},
              ]),
              _buildSettingSection('More', [
                {'icon': Icons.star, 'label': 'App ko Rate Karein', 'sub': 'Play Store par'},
                {'icon': Icons.diamond, 'label': 'Premium Unlock', 'sub': 'Ad-free experience', 'special': true},
                {'icon': Icons.info, 'label': 'App ke Baare Mein', 'sub': 'v4.1.8 • PC Computer Amreli'},
              ]),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Cash Counter v4.1.8 • PC Computer Amreli',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 11, fontFamily: 'JetBrainsMono'),
                ),
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
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 0.8),
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Container(
                  decoration: BoxDecoration(
                    color: item['special'] == true ? const Color(0xFFfef3c7) : null,
                    border: index < items.length - 1 ? Border(bottom: BorderSide(color: Colors.grey.shade100)) : null,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: item['special'] == true ? const Color(0xFFfcd34d) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item['icon'], color: item['special'] == true ? const Color(0xFFb45309) : Colors.grey.shade700),
                    ),
                    title: Text(
                      item['label'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: item['special'] == true ? const Color(0xFF78350f) : null,
                      ),
                    ),
                    subtitle: Text(item['sub'], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    trailing: item['toggle'] == true
                        ? Switch(value: true, onChanged: (v) {}, activeColor: Colors.green)
                        : const Icon(Icons.chevron_right, color: Colors.grey),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
