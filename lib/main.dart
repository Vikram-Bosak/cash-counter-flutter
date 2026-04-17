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
  bool isCredit; // true = receive (you'll get), false = pay (you'll give)
  
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

// ==================== THEME - THE LEDGER DESIGN SYSTEM ====================

class AppTheme {
  // Primary - Emerald Green
  static const Color primary = Color(0xFF00652c);
  static const Color primaryContainer = Color(0xFF15803d);
  static const Color primaryFixedDim = Color(0xFF79db8d);
  static const Color primaryFixed = Color(0xFF95f8a7);
  static const Color inversePrimary = Color(0xFF79db8d);
  
  // Secondary - Saffron Amber
  static const Color secondary = Color(0xFF855300);
  static const Color secondaryContainer = Color(0xFFfea619);
  static const Color secondaryFixed = Color(0xFFffddb8);
  static const Color secondaryFixedDim = Color(0xFFffb95f);
  
  // Tertiary - Blue
  static const Color tertiary = Color(0xFF0053b4);
  static const Color tertiaryContainer = Color(0xFF156bde);
  static const Color tertiaryFixed = Color(0xFFd8e2ff);
  static const Color tertiaryFixedDim = Color(0xFFadc6ff);
  
  // Surfaces - Clean, minimal
  static const Color surface = Color(0xFFf9f9f8);
  static const Color surfaceBright = Color(0xFFf9f9f8);
  static const Color surfaceDim = Color(0xFFdadad9);
  static const Color surfaceContainerLowest = Color(0xFFffffff);
  static const Color surfaceContainerLow = Color(0xFFf3f4f3);
  static const Color surfaceContainer = Color(0xFFeeeeed);
  static const Color surfaceContainerHigh = Color(0xFFe8e8e7);
  static const Color surfaceContainerHighest = Color(0xFFe2e2e2);
  static const Color surfaceTint = Color(0xFF006d30);
  
  // On-Surface
  static const Color onSurface = Color(0xFF1a1c1c);
  static const Color onSurfaceVariant = Color(0xFF3f493f);
  
  // On-Primary
  static const Color onPrimary = Color(0xFFffffff);
  static const Color onPrimaryContainer = Color(0xFFd3ffd5);
  static const Color onPrimaryFixed = Color(0xFF00210a);
  static const Color onPrimaryFixedVariant = Color(0xFF005323);
  
  // On-Secondary
  static const Color onSecondary = Color(0xFFffffff);
  static const Color onSecondaryContainer = Color(0xFF684000);
  static const Color onSecondaryFixed = Color(0xFF2a1700);
  static const Color onSecondaryFixedVariant = Color(0xFF653e00);
  
  // On-Tertiary
  static const Color onTertiary = Color(0xFFffffff);
  static const Color onTertiaryContainer = Color(0xFFf2f3ff);
  static const Color onTertiaryFixed = Color(0xFF001a42);
  static const Color onTertiaryFixedVariant = Color(0xFF004395);
  
  // Error
  static const Color error = Color(0xFFba1a1a);
  static const Color errorContainer = Color(0xFFffdad6);
  static const Color onError = Color(0xFFffffff);
  static const Color onErrorContainer = Color(0xFF93000a);
  
  // Outline
  static const Color outline = Color(0xFF6f7a6e);
  static const Color outlineVariant = Color(0xFFbecabc);
  
  // Inverse
  static const Color inverseSurface = Color(0xFF2f3130);
  static const Color inverseOnSurface = Color(0xFFf1f1f0);
  
  // Background
  static const Color background = Color(0xFFf9f9f8);
  static const Color onBackground = Color(0xFF1a1c1c);

  // Success (for credit/receive)
  static const Color success = Color(0xFF00652c);
  
  // Typography Styles - Using Roboto Mono (available in google_fonts)
  static TextStyle get dataMono => GoogleFonts.robotoMono(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );
  
  static TextStyle get dataMonoLarge => GoogleFonts.robotoMono(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -2,
    color: Colors.white,
  );
  
  static TextStyle get headlineLarge => GoogleFonts.bricolageGrotesque(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: onSurface,
  );
  
  static TextStyle get headlineMedium => GoogleFonts.bricolageGrotesque(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: onSurface,
  );
  
  static TextStyle get titleLarge => GoogleFonts.bricolageGrotesque(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.bricolageGrotesque(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: onSurface,
  );
  
  static TextStyle get labelSmall => GoogleFonts.bricolageGrotesque(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    color: onSurfaceVariant,
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primary,
      primaryContainer: primaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      surface: surface,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      error: error,
      errorContainer: errorContainer,
      onError: onError,
      onErrorContainer: onErrorContainer,
      outline: outline,
      outlineVariant: outlineVariant,
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
  
  runApp(const TheLedgerApp());
}

class TheLedgerApp extends StatelessWidget {
  const TheLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Ledger',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}

// ==================== MAIN SCREEN WITH BOTTOM NAV ====================

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
    const AddTransactionScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.06),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        child: BottomAppBar(
          color: Colors.white.withOpacity(0.7),
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, 'Home', Icons.home),
              _buildNavItem(1, Icons.menu_book_outlined, 'Khata', Icons.menu_book),
              _buildAddButton(),
              _buildNavItem(3, Icons.history_outlined, 'History', Icons.history),
              _buildNavItem(4, Icons.settings_outlined, 'Settings', Icons.settings),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, IconData activeIcon) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected 
            ? AppTheme.secondaryContainer.withOpacity(0.2)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 24,
              color: isSelected 
                ? const Color(0xFF855300) 
                : Colors.grey[600],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: isSelected 
                  ? const Color(0xFF855300)
                  : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 2),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _currentIndex == 2 
                  ? AppTheme.primary 
                  : AppTheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_circle,
                size: 28,
                color: _currentIndex == 2 
                  ? Colors.white 
                  : AppTheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Add',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: _currentIndex == 2 
                  ? AppTheme.primary 
                  : Colors.grey[600],
              ),
            ),
          ],
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
            // Glass Header
            _buildGlassHeader(context),
            
            // Hero Balance Card
            _buildHeroBalanceCard(context),
            
            // Quick Stats
            _buildQuickStats(context),
            
            // Action Cards
            _buildActionCards(context),
            
            // Recent Activity
            _buildRecentActivity(context),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.business,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'The Ledger',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF064e3b),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search,
                color: const Color(0xFF064e3b),
                size: 20,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Search coming soon...', style: GoogleFonts.bricolageGrotesque()),
                  backgroundColor: AppTheme.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary,
            AppTheme.primaryContainer,
            AppTheme.primaryFixedDim,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -40,
            bottom: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -40,
            top: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xfffbbf24).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning, Boutique',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.15,
                  color: AppTheme.onPrimaryContainer.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ready for today\'s growth?',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'CURRENT WORKING CAPITAL',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '₹12,85,420.00',
                style: GoogleFonts.robotoMono(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildStatChip('Debit', '₹42.5k', AppTheme.error, true),
          const SizedBox(width: 12),
          _buildStatChip('Credit', '₹18.2k', AppTheme.primary, false),
          const SizedBox(width: 12),
          _buildStatChip('Savings', '₹8.9L', AppTheme.tertiary, false),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color, bool isPulse) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isPulse)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  label,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.15,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.robotoMono(
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
        children: [
          _buildActionCard(
            'Cash Counter',
            'Manage daily cash flow',
            Icons.payments,
            const Color(0xfffbbf24),
            const Color(0xFF78350f),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CashCounterScreen()),
              );
            },
          ),
          _buildActionCard(
            'Udhar Khata',
            'Customer credit logs',
            Icons.menu_book,
            AppTheme.primary,
            Colors.white,
            onTap: () {
              final state = context.findAncestorStateOfType<_MainScreenState>();
              if (state != null) {
                state.setState(() {
                  state._currentIndex = 1;
                });
              }
            },
          ),
          _buildActionCard(
            'Income/Expense',
            'Ledger statements',
            Icons.swap_vert,
            AppTheme.tertiary,
            Colors.white,
            onTap: () {},
          ),
          _buildActionCard(
            'Stock Inventory',
            'Track merchandise',
            Icons.inventory_2,
            const Color(0xFF7c3aed),
            Colors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color bgColor,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: bgColor, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
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

  Widget _buildRecentActivity(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
              TextButton(
                onPressed: () {
                  final state = context.findAncestorStateOfType<_MainScreenState>();
                  if (state != null) {
                    state.setState(() {
                      state._currentIndex = 3; // History tab
                    });
                  }
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.15,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTransactionItem('Amit Kumar', '10m ago • Wholesale Supply', -12400, 'AK'),
          _buildTransactionItem('Sana Rashid', '45m ago • Silk Saree Sale', 8200, 'SR'),
          _buildTransactionItem('Modern Decor', '2h ago • Store Rent', -45000, 'MD'),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String name, String details, double amount, String initials) {
    final isCredit = amount > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
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
                  details,
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
                '${isCredit ? '+' : '-'}₹${amount.abs().toStringAsFixed(0)}',
                style: GoogleFonts.robotoMono(
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
                  isCredit ? 'Received' : 'Paid',
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

// ==================== UDHAR KHATA SCREEN ====================

class UdharKhataScreen extends StatefulWidget {
  const UdharKhataScreen({super.key});

  @override
  State<UdharKhataScreen> createState() => _UdharKhataScreenState();
}

class _UdharKhataScreenState extends State<UdharKhataScreen> {
  String _filter = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchAndFilter(),
          _buildSummaryCard(),
          _buildPartyList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPartyDialog(context),
        backgroundColor: AppTheme.secondaryContainer,
        child: const Icon(Icons.person_add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.business, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'The Ledger',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF064e3b),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search, color: const Color(0xFF064e3b), size: 20),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Search coming soon...', style: GoogleFonts.bricolageGrotesque()),
                  backgroundColor: AppTheme.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppTheme.outline),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search customer or amount...',
                      hintStyle: GoogleFonts.bricolageGrotesque(
                        color: AppTheme.outline.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', _filter == 'All'),
                const SizedBox(width: 12),
                _buildFilterChip('Credit (You Give)', _filter == 'Credit (You Give)'),
                const SizedBox(width: 12),
                _buildFilterChip('Debit (You Take)', _filter == 'Debit (You Take)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL BALANCE',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹ 14,250.00',
                    style: GoogleFonts.robotoMono(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.account_balance_wallet,
                size: 40,
                color: Colors.white.withOpacity(0.5),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You\'ll Get',
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.15,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹ 18,500',
                        style: GoogleFonts.robotoMono(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You\'ll Give',
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.15,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹ 4,250',
                        style: GoogleFonts.robotoMono(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.secondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyList() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildPartyItem('Arun Sharma', 'Last entry: 2 hrs ago', 4500, true, 'AS'),
          _buildPartyItem('Kiran Patel', 'Last entry: Yesterday', 1200, false, 'KP'),
          _buildPartyItem('Rahul Jain', 'Last entry: 3 days ago', 12800, true, 'RJ'),
          _buildPartyItem('Sana Malik', 'Last entry: 1 week ago', 3050, false, 'SM'),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildPartyItem(String name, String lastEntry, double amount, bool isCredit, String initials) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isCredit ? AppTheme.error : AppTheme.primary,
            width: 4,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isCredit 
                  ? AppTheme.errorContainer 
                  : AppTheme.primaryFixed,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isCredit 
                      ? AppTheme.onErrorContainer 
                      : AppTheme.onPrimaryFixed,
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
                  lastEntry,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 12,
                    color: AppTheme.outline,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isCredit ? 'You\'ll Get' : 'You\'ll Give',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: isCredit ? AppTheme.error : AppTheme.primary,
                    ),
                  ),
                  Text(
                    '₹ ${amount.toStringAsFixed(2)}',
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isCredit ? AppTheme.error : AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chat,
                  color: const Color(0xFF25D366),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPartyDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Add Party', style: AppTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Party "${nameController.text}" added!', style: GoogleFonts.bricolageGrotesque()),
                    backgroundColor: AppTheme.primary,
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ==================== ADD TRANSACTION SCREEN ====================

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isCredit = true;
  final TextEditingController _amountController = TextEditingController(text: '0.00');
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildTransactionTypeToggle(),
            _buildAmountInput(),
            _buildQuickAmounts(),
            _buildFormFields(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildSaveButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 16),
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
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Color(0xFF064e3b)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'The Ledger',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF064e3b),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTypeToggle() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isCredit = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _isCredit ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _isCredit
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  'INCOME / CREDIT',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                    color: _isCredit 
                        ? const Color(0xFF064e3b) 
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isCredit = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !_isCredit ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: !_isCredit
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  'EXPENSE / DEBIT',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                    color: !_isCredit 
                        ? AppTheme.error 
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(
            'TRANSACTION AMOUNT',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: const Color(0xFF064e3b).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '₹',
                style: GoogleFonts.robotoMono(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF064e3b),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _amountController,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoMono(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF064e3b),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmounts() {
    final amounts = ['500', '1000', '2000', '5000'];
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: amounts.map((amount) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _amountController.text = amount;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.surfaceContainer,
                foregroundColor: const Color(0xFF064e3b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: Text(
                '₹$amount',
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _buildInputField(
            'Select Party / Customer',
            Icons.person_search,
            _partyController,
            'Search customer or add new...',
          ),
          const SizedBox(height: 20),
          _buildInputField(
            'Notes / Description',
            Icons.description,
            _notesController,
            'What is this for? (e.g. Raw materials, Advance payment)',
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  'Date',
                  Icons.calendar_today,
                  TextEditingController(text: 'Oct 24, 2023'),
                  '',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  'Time',
                  Icons.schedule,
                  TextEditingController(text: '02:30 PM'),
                  '',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    IconData icon,
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.15,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: maxLines > 1 ? 16 : 0,
          ),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: maxLines > 1 
                ? CrossAxisAlignment.start 
                : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: maxLines > 1 ? 4 : 0),
                child: Icon(icon, color: AppTheme.outline, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.bricolageGrotesque(
                      color: AppTheme.outline.withOpacity(0.6),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        final amount = double.tryParse(_amountController.text) ?? 0;
        if (amount > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _isCredit ? 'Income of ₹$amount recorded!' : 'Expense of ₹$amount recorded!',
                style: GoogleFonts.bricolageGrotesque(),
              ),
              backgroundColor: _isCredit ? AppTheme.primary : AppTheme.error,
            ),
          );
          _amountController.text = '0.00';
          _partyController.clear();
          _notesController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please enter a valid amount',
                style: GoogleFonts.bricolageGrotesque(),
              ),
              backgroundColor: AppTheme.error,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.25),
                  blurRadius: 40,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Save Transaction',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

// ==================== HISTORY SCREEN ====================

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDateSection('Today', [
                  {'name': 'Amit Kumar', 'amount': -12400, 'time': '10:30 AM', 'type': 'Paid'},
                  {'name': 'Sana Rashid', 'amount': 8200, 'time': '09:15 AM', 'type': 'Received'},
                ]),
                _buildDateSection('Yesterday', [
                  {'name': 'Modern Decor', 'amount': -45000, 'time': '06:00 PM', 'type': 'Paid'},
                  {'name': 'Rahul Jain', 'amount': 12800, 'time': '02:30 PM', 'type': 'Received'},
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'History',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppTheme.onSurface,
            ),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.filter_list, color: const Color(0xFF064e3b)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Filter coming soon...', style: GoogleFonts.bricolageGrotesque()),
                  backgroundColor: AppTheme.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String date, List<Map<String, dynamic>> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            date,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        ...transactions.map((tx) => _buildTransactionCard(tx)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> tx) {
    final isCredit = tx['amount'] > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isCredit 
                  ? AppTheme.primary.withOpacity(0.1) 
                  : AppTheme.error.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? AppTheme.primary : AppTheme.error,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['name'],
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  tx['time'],
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
                '${isCredit ? '+' : '-'}₹${(tx['amount'] as num).abs().toStringAsFixed(0)}',
                style: GoogleFonts.robotoMono(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isCredit ? AppTheme.primary : AppTheme.error,
                ),
              ),
              Text(
                tx['type'],
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isCredit ? AppTheme.primary : AppTheme.error,
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
          // Header with gradient
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Share coming soon...', style: GoogleFonts.bricolageGrotesque()),
                                backgroundColor: AppTheme.primary,
                              ),
                            );
                          },
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
                              style: GoogleFonts.robotoMono(
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
                                style: GoogleFonts.robotoMono(
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
                                  style: GoogleFonts.robotoMono(
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
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
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

            // Profile Card
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
                      ),
                      child: const Icon(Icons.business, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Small Business Owner',
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'boutique.ledger@business.com',
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Premium',
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Settings Sections
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildSettingsSection('Account', [
                    {'icon': Icons.lock, 'label': 'App Lock', 'sub': 'Fingerprint ON', 'toggle': true},
                    {'icon': Icons.language, 'label': 'Language', 'sub': 'English (US)'},
                  ]),
                  const SizedBox(height: 20),
                  _buildSettingsSection('Data Management', [
                    {'icon': Icons.cloud_upload, 'label': 'Backup to Drive', 'sub': 'Last synced: 2 hours ago', 'sync': true},
                    {'icon': Icons.picture_as_pdf, 'label': 'Export to PDF', 'sub': ''},
                    {'icon': Icons.table_chart, 'label': 'Export to Excel', 'sub': ''},
                  ]),
                  const SizedBox(height: 20),
                  _buildSettingsSection('Customization', [
                    {'icon': Icons.dark_mode, 'label': 'Dark Mode', 'sub': '', 'toggle': true},
                    {'icon': Icons.palette, 'label': 'Theme Colors', 'sub': 'Emerald Green'},
                  ]),
                  const SizedBox(height: 20),
                  _buildSettingsSection('Help & Support', [
                    {'icon': Icons.support_agent, 'label': 'Contact Us', 'sub': ''},
                    {'icon': Icons.star, 'label': 'Rate App', 'sub': ''},
                  ]),
                  const SizedBox(height: 30),
                  Text(
                    'Version 4.2.0-Editorial',
                    style: GoogleFonts.robotoMono(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                      color: AppTheme.outline,
                    ),
                  ),
                  Text(
                    'Made with Precision for Modern Business',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 12,
                      color: AppTheme.outlineVariant,
                    ),
                  ),
                  const SizedBox(height: 100),
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
          title.toUpperCase(),
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
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
                        color: AppTheme.primary.withOpacity(0.1),
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
                    subtitle: item['sub'].isNotEmpty
                        ? Text(
                            item['sub'],
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 12,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          )
                        : null,
                    trailing: item['toggle'] == true
                        ? Switch(value: true, onChanged: (v) {})
                        : item['sync'] == true
                            ? Icon(Icons.sync, color: AppTheme.primary)
                            : const Icon(Icons.chevron_right),
                    onTap: () {
                      if (item['label'] == 'Export to PDF') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Exporting to PDF...', style: GoogleFonts.bricolageGrotesque()),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      } else if (item['label'] == 'Export to Excel') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Exporting to Excel...', style: GoogleFonts.bricolageGrotesque()),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      }
                    },
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
