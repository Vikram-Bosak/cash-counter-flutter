import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'main.g.dart';

// ==================== MODELS ====================

@HiveType(typeId: 0)
class Party extends HiveObject {
  @HiveField(0)
  String name;
  
  @HiveField(1)
  String phone;
  
  @HiveField(2)
  double totalCredit;
  
  @HiveField(3)
  double totalDebit;
  
  @HiveField(4)
  DateTime createdAt;
  
  Party({
    required this.name,
    this.phone = '',
    this.totalCredit = 0,
    this.totalDebit = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String partyId;
  
  @HiveField(1)
  double amount;
  
  @HiveField(2)
  bool isCredit; // true = lena, false = dena
  
  @HiveField(3)
  String remark;
  
  @HiveField(4)
  DateTime date;
  
  Transaction({
    required this.partyId,
    required this.amount,
    required this.isCredit,
    this.remark = '',
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

@HiveType(typeId: 2)
class CashEntry extends HiveObject {
  @HiveField(0)
  int denomination;
  
  @HiveField(1)
  int quantity;
  
  @HiveField(2)
  DateTime date;
  
  CashEntry({
    required this.denomination,
    required this.quantity,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

@HiveType(typeId: 3)
class Note extends HiveObject {
  @HiveField(0)
  String title;
  
  @HiveField(1)
  String content;
  
  @HiveField(2)
  DateTime date;
  
  Note({
    required this.title,
    required this.content,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

// ==================== THEME ====================

class AppTheme {
  // Primary Colors - Deep Forest Green
  static const Color primary = Color(0xFF00652c);
  static const Color primaryContainer = Color(0xFF15803d);
  static const Color primaryFixedDim = Color(0xFF79db8d);
  
  // Secondary - Saffron Amber
  static const Color secondary = Color(0xFF855300);
  static const Color secondaryContainer = Color(0xFFfea619);
  
  // Surfaces - No-Line Philosophy
  static const Color surface = Color(0xFFf9f9f8);
  static const Color surfaceContainerLow = Color(0xFFf3f4f3);
  static const Color surfaceContainer = Color(0xFFeeeeed);
  static const Color surfaceContainerHighest = Color(0xFFe2e2e2);
  
  // On-Surface
  static const Color onSurface = Color(0xFF1a1c1c);
  static const Color onSurfaceVariant = Color(0xFF3f493f);
  
  // Semantic
  static const Color error = Color(0xFFba1a1a);
  static const Color success = Color(0xFF00652c);
  
  // Tertiary - Blue
  static const Color tertiary = Color(0xFF0053b4);
  
  // Outline
  static const Color outlineVariant = Color(0xFFbecabc);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primary,
      primaryContainer: primaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      surface: surface,
      onSurface: onSurface,
      error: error,
    ),
    scaffoldBackgroundColor: surface,
    textTheme: GoogleFonts.bricolageGrotesqueTextTheme().copyWith(
      displayLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
        color: onSurface,
      ),
      headlineMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      bodyLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      labelMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: onSurfaceVariant,
      ),
    ),
  );

  // Monospace for financial data
  static TextStyle dataMono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );
  
  static TextStyle dataMonoLarge = TextStyle(
    fontFamily: 'monospace',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -2,
    color: Colors.white,
  );
}

// ==================== MAIN APP ====================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Register adapters
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(PartyAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TransactionAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(CashEntryAdapter());
  if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(NoteAdapter());
  
  // Open boxes
  await Hive.openBox<Party>('parties');
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<CashEntry>('cashEntries');
  await Hive.openBox<Note>('notes');
  
  runApp(const CashCounterApp());
}

class CashCounterApp extends StatelessWidget {
  const CashCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Counter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}

// ==================== MAIN SCREEN ====================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeDashboard(),
    const UdharKhataScreen(),
    const CashCounterScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppTheme.primary,
            unselectedItemColor: AppTheme.onSurfaceVariant,
            selectedLabelStyle: GoogleFonts.bricolageGrotesque(
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'Khata',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payments_rounded),
                label: 'Cash',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== HOME DASHBOARD ====================

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Glassmorphism Header
            _buildGlassHeader(context),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Balance Card
                  _buildHeroBalanceCard(),
                  
                  const SizedBox(height: 20),
                  
                  // Quick Stats
                  _buildQuickStats(),
                  
                  const SizedBox(height: 24),
                  
                  // Action Cards
                  _buildActionCards(context),
                  
                  const SizedBox(height: 24),
                  
                  // Recent Activity
                  _buildRecentActivity(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryContainer, AppTheme.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(Icons.store, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'The Ledger',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.search, color: AppTheme.onSurfaceVariant),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryContainer, AppTheme.primaryFixedDim],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: const GradientRotation(135 * 3.14159 / 180),
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GOOD MORNING, BOUTIQUE',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Ready for today\'s growth?',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'CURRENT WORKING CAPITAL',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '₹12,85,420.00',
            style: AppTheme.dataMonoLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        _buildStatCard('Debit', '₹42.5k', AppTheme.error, true),
        const SizedBox(width: 12),
        _buildStatCard('Credit', '₹18.2k', AppTheme.success, true),
        const SizedBox(width: 12),
        _buildStatCard('Savings', '₹8.9L', AppTheme.tertiary, false),
      ],
    );
  }

  Widget _buildStatCard(String label, String amount, Color color, bool animate) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (animate)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              amount,
              style: TextStyle(fontFamily: "monospace", 
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCards(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildActionCard(
          context,
          'Cash Counter',
          'Manage daily cash flow',
          Icons.payments_rounded,
          const Color(0xFFfea619),
          const Color(0xFFfef3c7),
          () {},
        ),
        _buildActionCard(
          context,
          'Udhar Khata',
          'Customer credit logs',
          Icons.menu_book_rounded,
          AppTheme.primary,
          const Color(0xFFdcfce7),
          () {},
        ),
        _buildActionCard(
          context,
          'Income/Expense',
          'Ledger statements',
          Icons.swap_vert_rounded,
          AppTheme.tertiary,
          const Color(0xFFdbeafe),
          () {},
        ),
        _buildActionCard(
          context,
          'Stock Inventory',
          'Track merchandise',
          Icons.inventory_2_rounded,
          const Color(0xFF9333ea),
          const Color(0xFFf3e8ff),
          () {},
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    Color bgColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 12,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              'VIEW ALL',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.15,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTransactionItem('Amit Kumar', 'Wholesale Supply', '-₹12,400', '10m ago', true),
        const SizedBox(height: 12),
        _buildTransactionItem('Priya Sharma', 'Retail Payment', '+₹8,500', '2h ago', false),
        const SizedBox(height: 12),
        _buildTransactionItem('Rahul Patel', 'Material Purchase', '-₹25,000', '5h ago', true),
      ],
    );
  }

  Widget _buildTransactionItem(String name, String remark, String amount, String time, bool isDebit) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                name.split(' ').map((e) => e[0]).take(2).join(),
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  '$time • $remark',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(fontFamily: "monospace", 
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDebit ? AppTheme.error : AppTheme.success,
                ),
              ),
              Text(
                isDebit ? 'PAID' : 'RECEIVED',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: (isDebit ? AppTheme.error : AppTheme.success).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==================== UDHAR KHATA SCREEN ====================

class UdharKhataScreen extends StatefulWidget {
  const UdharKhataScreen({super.key});

  @override
  State<UdharKhataScreen> createState() => _UdharKhataScreenState();
}

class _UdharKhataScreenState extends State<UdharKhataScreen> {
  late Box<Party> partyBox;
  List<Party> parties = [];

  @override
  void initState() {
    super.initState();
    partyBox = Hive.box<Party>('parties');
    _loadParties();
  }

  void _loadParties() {
    setState(() {
      parties = partyBox.values.toList();
    });
  }

  void _addParty(String name, String phone) {
    final party = Party(name: name, phone: phone);
    partyBox.add(party);
    _loadParties();
  }

  void _showAddPartyDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Add New Party',
          style: GoogleFonts.bricolageGrotesque(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.bricolageGrotesque(),
                filled: true,
                fillColor: AppTheme.surfaceContainerLow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: GoogleFonts.bricolageGrotesque(),
                filled: true,
                fillColor: AppTheme.surfaceContainerLow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.bricolageGrotesque()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                _addParty(nameController.text, phoneController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Add', style: GoogleFonts.bricolageGrotesque(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '📒 Udhar Khata',
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryContainer,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white, size: 18),
                      label: Text(
                        'Add Party',
                        style: GoogleFonts.bricolageGrotesque(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _showAddPartyDialog,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildSummaryChip('To Receive', '₹45.2K', AppTheme.error),
                    const SizedBox(width: 12),
                    _buildSummaryChip('To Pay', '₹4.2K', AppTheme.success),
                    const SizedBox(width: 12),
                    _buildSummaryChip('Parties', '${parties.length}', AppTheme.tertiary),
                  ],
                ),
              ],
            ),
          ),
          
          // List
          Expanded(
            child: parties.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_outlined, size: 64, color: AppTheme.onSurfaceVariant.withOpacity(0.3)),
                        const SizedBox(height: 16),
                        Text(
                          'No parties yet',
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'Tap + to add your first party',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: parties.length,
                    itemBuilder: (context, index) {
                      final party = parties[index];
                      return _buildPartyCard(party);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _showAddPartyDialog,
      ),
    );
  }

  Widget _buildSummaryChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontFamily: "monospace", 
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyCard(Party party) {
    final balance = party.totalCredit - party.totalDebit;
    final isCredit = balance > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isCredit
                    ? [const Color(0xFFdcfce7), AppTheme.primaryContainer]
                    : [const Color(0xFFfee2e2), const Color(0xFFfca5a5)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                party.name.split(' ').map((e) => e[0]).take(2).join().toUpperCase(),
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isCredit ? AppTheme.primary : AppTheme.error,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  party.name,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                if (party.phone.isNotEmpty)
                  Text(
                    party.phone,
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 12,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? "+" : ""}₹${balance.abs().toStringAsFixed(0)}',
                style: TextStyle(fontFamily: "monospace", 
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isCredit ? AppTheme.success : AppTheme.error,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isCredit ? AppTheme.success : AppTheme.error).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isCredit ? 'RECEIVE' : 'PAY',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isCredit ? AppTheme.success : AppTheme.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==================== CASH COUNTER SCREEN ====================

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({super.key});

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {
  final Map<int, int> _quantities = {};

  final List<Map<String, dynamic>> _denominations = [
    {'val': 2000, 'label': '₹2000', 'sub': 'Do Hazaar', 'c1': const Color(0xFFFF5F00), 'c2': const Color(0xFFFF8C00)},
    {'val': 500, 'label': '₹500', 'sub': 'Paanch Sau', 'c1': const Color(0xFF8B4513), 'c2': const Color(0xFFA0522D)},
    {'val': 200, 'label': '₹200', 'sub': 'Do Sau', 'c1': const Color(0xFFFFD700), 'c2': const Color(0xFFFFA500)},
    {'val': 100, 'label': '₹100', 'sub': 'Ek Sau', 'c1': const Color(0xFF4B0082), 'c2': const Color(0xFF6A0DAD)},
    {'val': 50, 'label': '₹50', 'sub': 'Pachaas', 'c1': const Color(0xFF00CED1), 'c2': const Color(0xFF20B2AA)},
    {'val': 20, 'label': '₹20', 'sub': 'Bees', 'c1': const Color(0xFF228B22), 'c2': const Color(0xFF32CD32)},
    {'val': 10, 'label': '₹10', 'sub': 'Das', 'c1': const Color(0xFFFF6347), 'c2': const Color(0xFFFF7F50)},
    {'val': 5, 'label': '₹5', 'sub': 'Paanch', 'c1': const Color(0xFF4682B4), 'c2': const Color(0xFF5F9EA0)},
    {'val': 2, 'label': '₹2', 'sub': 'Do', 'c1': const Color(0xFF708090), 'c2': const Color(0xFF778899)},
    {'val': 1, 'label': '₹1', 'sub': 'Ek', 'c1': const Color(0xFFB8860B), 'c2': const Color(0xFFDAA520)},
  ];

  int get _total => _denominations.fold(0, (sum, d) => sum + (d['val'] as int) * (_quantities[d['val']] ?? 0));

  void _add(int val) => setState(() => _quantities[val] = (_quantities[val] ?? 0) + 1);
  void _remove(int val) => setState(() => _quantities[val] = ((_quantities[val] ?? 0) - 1).clamp(0, 99999));
  void _clear() => setState(() => _quantities.clear());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '💰 Cash Counter',
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.refresh, color: Colors.white, size: 20),
                          ),
                          onPressed: _clear,
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.share, color: Colors.white, size: 20),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'TOTAL CASH',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${_total.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                  style: AppTheme.dataMonoLarge,
                ),
              ],
            ),
          ),

          // Denominations
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _denominations.length,
              itemBuilder: (context, index) {
                final d = _denominations[index];
                final qty = _quantities[d['val']] ?? 0;
                final subtotal = (d['val'] as int) * qty;
                final c1 = d['c1'] as Color;
                final c2 = d['c2'] as Color;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [c1, c2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: c1.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                          ),
                          child: Center(
                            child: Text(
                              d['label'],
                              style: TextStyle(fontFamily: "monospace", 
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d['sub'],
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                qty > 0
                                    ? '₹${subtotal.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}'
                                    : 'Tap to count',
                                style: TextStyle(fontFamily: "monospace", 
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: AppTheme.error),
                                onPressed: () => _remove(d['val']),
                              ),
                              SizedBox(
                                width: 44,
                                child: Text(
                                  '$qty',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: "monospace", 
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.onSurface,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, color: AppTheme.success),
                                onPressed: () => _add(d['val']),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SETTINGS SCREEN ====================

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                '⚙️ Settings',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.primaryContainer, AppTheme.primary],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.business, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Business',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.onSurface,
                                ),
                              ),
                              Text(
                                'PC Computer • Amreli, Gujarat',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 12,
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryContainer.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'FREE',
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Settings Sections
                  _buildSettingsSection('App', [
                    {'icon': Icons.language, 'label': 'Language', 'sub': 'Hindi'},
                    {'icon': Icons.fingerprint, 'label': 'App Lock', 'sub': 'Fingerprint ON'},
                    {'icon': Icons.palette, 'label': 'Theme', 'sub': 'Light Mode'},
                  ]),

                  const SizedBox(height: 16),

                  _buildSettingsSection('Data & Backup', [
                    {'icon': Icons.cloud_upload, 'label': 'Google Drive Backup', 'sub': 'Last: Yesterday'},
                    {'icon': Icons.download, 'label': 'Import Data', 'sub': 'Restore from backup'},
                    {'icon': Icons.folder_open, 'label': 'Export All', 'sub': 'PDF, Excel, JSON'},
                  ]),

                  const SizedBox(height: 16),

                  _buildSettingsSection('More', [
                    {'icon': Icons.star, 'label': 'Rate App', 'sub': 'Play Store'},
                    {'icon': Icons.diamond, 'label': 'Premium Unlock', 'sub': 'Ad-free experience'},
                    {'icon': Icons.info, 'label': 'About', 'sub': 'v5.0.0 • PC Computer Amreli'},
                  ]),

                  const SizedBox(height: 30),

                  Text(
                    'Cash Counter v5.0.0 • Made with ❤️ in India',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 11,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item['icon'], color: AppTheme.primary, size: 22),
                    ),
                    title: Text(
                      item['label'],
                      style: GoogleFonts.bricolageGrotesque(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      item['sub'],
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 12,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant),
                    onTap: () {},
                  ),
                  if (i < items.length - 1)
                    Divider(
                      height: 1,
                      indent: 60,
                      endIndent: 20,
                      color: AppTheme.outlineVariant.withOpacity(0.2),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
