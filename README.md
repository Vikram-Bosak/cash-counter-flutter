# 💰 Cash Counter — Credit Debit

> **Android Mobile Application for Indian Small Business Owners, Shopkeepers & Traders**

![Version](https://img.shields.io/badge/version-4.1.8-green)
![Platform](https://img.shields.io/badge/platform-Android-blue)
![License](https://img.shields.io/badge/license-Free-success)

---

## 📱 About The App

Cash Counter is a **100% offline-first** Android application designed for Indian small business owners, traders, shopkeepers, and individual users who need to manage:
- Daily cash transactions
- Credit/Debit ledgers (Udhar Khata)
- Income/Expense tracking
- Stock inventory
- Payment reminders

**All without requiring internet connection!**

---

## 🎯 Key Features

### 1. 💵 Cash Counter Module
| Feature | Description |
|---------|-------------|
| **Denomination Counting** | Count notes & coins: ₹2000, ₹500, ₹200, ₹100, ₹50, ₹20, ₹10, ₹5, ₹2, ₹1 |
| **Real-time Calculation** | Automatic total as you enter quantities |
| **Sound Effects** | Audio feedback on button presses |
| **PDF Export** | Full Report & Short Report generation |
| **WhatsApp Sharing** | Share cash count reports directly |
| **Receipt Generation** | Create JPG receipts |
| **Auto-save Sessions** | Timestamp-based session saving |
| **Text-to-Speech** | Hear the total amount spoken aloud |

### 2. 📒 Credit/Debit Module (Udhar Khata)
| Feature | Description |
|---------|-------------|
| **Party Management** | Add customers with name, phone, photo |
| **Transaction Entry** | Record credit (money given) & debit (money received) |
| **Smart Search** | Search parties by name |
| **Transaction History** | View all entries per party |
| **Photo Receipts** | Attach photos to transactions |
| **PDF Reports** | Full Report, Short Report, Single Person Report, Group Report |
| **Excel Export** | Export all C/D data to .xlsx |
| **WhatsApp Integration** | Share reports via WhatsApp/WhatsApp Business |
| **Auto-share Toggle** | Automatic sharing on transaction save |

### 3. 📈 Income/Expense Module
| Feature | Description |
|---------|-------------|
| **Category-wise Entry** | Record income & expenses with categories |
| **Date Filtering** | View entries by date range |
| **Linked to C/D** | Reconcile with Credit/Debit entries |
| **PDF Reports** | Full & Short reports |
| **JPG Receipts** | Generate image receipts |
| **WhatsApp Sharing** | Share summaries instantly |
| **Copy to Credit** | Copy income entry to Credit side |

### 4. 📦 Item/Stock Module
| Feature | Description |
|---------|-------------|
| **Item Master** | Add items with name, rate, unit |
| **Unit Management** | Define units: piece, kg, litre, etc. |
| **Soft Delete** | Items remain in old bills even after deletion |
| **Billing Invoices** | Create invoices with multiple line items |
| **Auto-calculation** | Item total = rate × qty |
| **Discount Support** | Percentage discount per bill |
| **Customer Details** | Capture name, phone, address |
| **Invoice Number** | Auto-generated invoice numbers |
| **Sales Reports** | Total sales, item-wise summaries |
| **PDF & Excel Export** | Export all stock reports |

### 5. 🧮 Calculator Module
| Feature | Description |
|---------|-------------|
| **Standard Calculator** | Basic arithmetic operations |
| **Calculation History** | Stored locally |
| **GST Calculator** | Calculate GST amounts |
| **Bill Calculator** | Quick billing without stock |

### 6. 📝 Notes Module
| Feature | Description |
|---------|-------------|
| **Free-text Notes** | Create, edit, delete notes |
| **Date Stamping** | Automatic date on each note |
| **PDF Export** | Export all notes as single PDF |
| **Bulk Delete** | Delete all notes with confirmation |

### 7. ⏰ Reminder Module
| Feature | Description |
|---------|-------------|
| **Payment Reminders** | Set collection/payment reminders |
| **AlarmManager Integration** | Notifications at exact time |
| **Boot Persistence** | Reminders restored after restart |
| **Delete Confirmation** | Safe deletion with confirmation |

---

## 🔒 Security & Backup

### App Lock
- **Fingerprint/Biometric Lock** using AndroidX Biometric
- Toggle: Enable/Disable in settings
- Secure unlock prompt on launch

### Google Drive Backup
- **Manual Backup**: User-triggered upload
- **Auto Backup**: WorkManager scheduled task
- **Restore**: Download and restore from Drive
- **Quota Detection**: Alert when Drive is full
- **Error Handling**: Graceful failure messages

### Network Security
- No custom backend — **zero user data transmitted to developer servers**
- Only Google Drive & AdMob require internet
- Cleartext traffic restricted
- Play Services use secure channels

---

## 🌐 Multi-Language Support

The app supports **9 Indian languages**:

| Language | Region |
|----------|--------|
| 🇮🇳 Hindi | Pan-India |
| 🇮🇳 Gujarati | Gujarat |
| 🇮🇳 Marathi | Maharashtra |
| 🇮🇳 Tamil | Tamil Nadu |
| 🇮🇳 Telugu | Andhra Pradesh / Telangana |
| 🇮🇳 Kannada | Karnataka |
| 🇮🇳 Bengali | West Bengal |
| 🇇🇬 English | Default |
| 🇮🇳 Hindi (Bonus) | Additional variants |

---

## 💎 Monetization

### Free Tier
- All core features available
- Google AdMob ads displayed

### Premium Tier
- **One-time in-app purchase**
- Ad-free experience
- All features unlocked

---

## 🛠 Technical Specifications

| Specification | Details |
|---------------|---------|
| **Platform** | Android (ARM64, x86) |
| **Min Android** | Android 5.0 Lollipop (SDK 21) |
| **Target Android** | Android 14 (SDK 34) |
| **Language** | Kotlin |
| **Architecture** | MVVM + Room + Coroutines |
| **Database** | SQLite via Room ORM |
| **Preferences** | DataStore |
| **Background Jobs** | WorkManager + AlarmManager |
| **Excel Export** | Apache POI |
| **PDF Generation** | Custom PDFCreator |
| **Ads** | Google AdMob |
| **Billing** | Google Play Billing v7.1.1 |
| **Analytics** | Firebase Analytics |
| **Cloud Backup** | Google Drive API |
| **Biometric** | AndroidX Biometric |

---

## 📊 Database Schema

### Tables
| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `CashCalc` | Cash counter sessions | id, time, phoneNo, accountNo, payerName |
| `CreditDebit` | C/D ledger entries | id, name, amount, date, viewId, imgName, incExId |
| `CreditDebitName` | Party master list | id, name, date, time |
| `IncomeExpence` | Income/Expense records | id, type, amount, date, viewId, crDrId |
| `Reminder` | Payment reminders | id, name, date, time, remark |
| `item` | Product/item master | id, name, unit_id, rate, soft_delete |
| `unit` | Unit of measurement | id, name |
| `item_stock` | Stock billing headers | id, milli, item_name, phone_no, address, item_total, discount |
| `item_stock_item` | Stock billing lines | id, is_id, i_id, rate, qty, unit_id |
| `notes` | Free text notes | id, title, content, date |

---

## 📁 File Storage Structure

```
/My Cash Counter/
├── Calculator/
│   └── Calculator history exports
├── Credit Debit Image/
│   └── Receipt images for C/D entries
├── Credit Debit/Reciept/
│   └── PDF receipts per transaction
├── Credit Debit/Person Report/
│   └── Individual party reports
├── Credit Debit/Full Report All Person.pdf
├── Credit Debit/Short Report All Person.pdf
├── Credit Debit/Statement/
│   └── Account statements
├── Income Expense Image/
│   └── Images for income/expense
├── Income Expense Report/
│   └── Income/expense PDFs
├── Cash Count Report/Receipt/
│   └── Cash count receipt PDFs
├── Cash Count Report/Full Report.pdf
├── Notes/All Note.pdf
├── Profile/
│   └── Profile/avatar images
├── Item/
│   └── Item/stock exports
└── Person Report/
    └── Party summary reports
```

---

## 📱 Screen Inventory

| Screen | Type | Purpose |
|--------|------|---------|
| `SplashActivity` | Activity | Launch screen with branding |
| `MainActivity` | Activity | Main container with bottom nav |
| `fregment_counter` | Fragment | Cash denomination counter |
| `fregment_credit_debit` | Fragment | Credit/Debit ledger list |
| `fregment_billcalc` | Fragment | Bill/income/expense calculator |
| `fregment_calculator` | Fragment | Scientific calculator |
| `NoteActivity` | Activity | Notes list and editor |
| `PDFCreatorActivity` | Activity | PDF generation and preview |
| `NEWPDFViewerActivity` | Activity | In-app PDF viewer |
| `CardActivity` | Activity | Receipt card maker |

### Dialogs
- Add/Edit Credit Entry
- Add/Edit Debit Entry
- Add/Edit Customer/Party
- Add/Edit Stock Item
- Excel Export Options
- PDF Export Options
- Set Payment Reminder
- Add Income Entry
- Add Expense Entry
- Date/Type Filter
- Generate Account Statement
- Restore from Drive
- Free Tier Limit Paywall
- GST Percentage Setting
- Language Selector
- Biometric Lock Prompt
- App Update Checker

---

## 🔑 Android Permissions

| Permission | Purpose |
|------------|---------|
| `INTERNET` | Google Drive backup, AdMob ads, Firebase |
| `CAMERA` | Capture receipt/transaction photos |
| `READ_EXTERNAL_STORAGE` | Import files, read media |
| `WRITE_EXTERNAL_STORAGE` | Save PDF, Excel, JPG exports |
| `USE_BIOMETRIC` | Fingerprint app lock |
| `RECEIVE_BOOT_COMPLETED` | Re-schedule reminders after reboot |
| `SCHEDULE_EXACT_ALARM` | Precise reminder notifications |
| `VIBRATE` | Haptic feedback |
| `POST_NOTIFICATIONS` | Android 13+ notification permission |
| `ACCESS_NETWORK_STATE` | Check connectivity before Drive backup |
| `GET_ACCOUNTS` | Google account selection for Drive |

---

## 🎨 Design System

### Colors (Material You 3)
| Token | Color | Usage |
|-------|-------|-------|
| Primary Green | `#15803D` | Trust, money, India |
| Forest Deep | `#052e16` | Dark backgrounds |
| Accent Saffron | `#f59e0b` | Indian warmth |
| Credit Red | `#ef4444` | Credit amounts |
| Debit Green | `#22c55e` | Debit amounts |
| Income Blue | `#3b82f6` | Income entries |
| Expense Purple | `#8b5cf6` | Expense entries |

### Typography
| Font | Usage |
|------|-------|
| Bricolage Grotesque | UI, Buttons, Labels |
| Instrument Serif | Display Numbers |
| JetBrains Mono | ₹ Amounts, Codes |

---

## 🚀 Installation

### Prerequisites
- Flutter SDK 3.19+
- Android SDK 34
- Java 17+

### Build from Source

```bash
# Clone repository
git clone https://github.com/Vikram-Bosak/cash-counter-flutter.git
cd cash-counter-flutter

# Install dependencies
flutter pub get

# Build APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Install APK
1. Download `app-release.apk`
2. Enable "Install from Unknown Sources" in Android settings
3. Open APK file and tap "Install"

---

## 📥 Download

### Latest APK
**Direct Download:** [cash-counter-v4.1.8.apk](./cash-counter-v4.1.8.apk)

### GitHub Releases
**Releases Page:** [https://github.com/Vikram-Bosak/cash-counter-flutter/releases](https://github.com/Vikram-Bosak/cash-counter-flutter/releases)

---

## 🏢 Developer Information

| Detail | Information |
|--------|-------------|
| **Developer** | PC Computer Amreli |
| **Location** | Amreli, Gujarat, India |
| **Support Blog** | [cashcounterbook.blogspot.com](http://cashcounterbook.blogspot.com) |
| **Play Store** | `com.pccomputeramreli.Cash_Calculator` |

### Related Apps
| App | Package ID | Type |
|-----|------------|------|
| Cash Calc Lite | `com.pccomputeramreli.Cash_Calc_Lite` | Free lite version |
| Udhar Khata Book | `com.pccomputer.udhar_khata_book` | Ledger-focused variant |
| Age Calculator | `com.pccomputeramreli.Age_Calc` | Utility calculator |

---

## 📋 Target Users

| Persona | Use Case | Key Features |
|---------|----------|--------------|
| **Kirana Store Owner** | Track daily credit given to customers | Credit/Debit Ledger, WhatsApp share |
| **Street Trader** | Count cash at end of day | Cash Counter, Denomination counting |
| **Freelancer/Agent** | Record income and expenses | Income/Expense, Invoice/Bill PDF |
| **Small Manufacturer** | Maintain item-wise stock | Item/Stock module, Excel export |
| **Individual/Family** | Personal finance tracking | Income/Expense, Notes, Reminders |
| **Shopkeeper** | GST-inclusive bill making | Bill Calculator, GST, AlarmManager |

---

## 🆚 Competitive Positioning

| App | Cash Counter Advantage |
|-----|----------------------|
| **Khatabook** | 100% offline vs cloud-first |
| **OkCredit** | No server dependency |
| **Vyapar** | Simpler, free-tier available |
| **MyBillBook** | All-in-one bundle (billing + cash + ledger) |

**Key Differentiator:** Complete offline bundle with WhatsApp-native sharing and 9 regional languages.

---

## 🐛 Known Limitations

- No multi-device sync (Drive backup only)
- No web or desktop version
- No multi-user/team access
- No GST invoice format (GSTIN, HSN codes)
- No bank integration or UPI payment
- No automated backup scheduling
- Large APK size (71MB base) due to Apache POI + ICU

---

## 🔮 Future Enhancements

- [ ] Cloud sync with Firebase Firestore
- [ ] UPI/QR code integration
- [ ] GST-compliant invoice generation
- [ ] Tally export format (.csv)
- [ ] WhatsApp Business API integration
- [ ] iOS version
- [ ] Home screen widget
- [ ] Recurring expense/income entries
- [ ] Auto-generated P&L statement

---

## 📄 License

This project is a **reverse-engineered implementation** based on the original app's PRD.

**Original App:** Cash Counter — Credit Debit by PC Computer Amreli  
**Original Package:** `com.pccomputeramreli.Cash_Calculator`

---

## 🙏 Acknowledgments

- **PC Computer Amreli** — Original app developer
- **Google Material Design 3** — Design system
- **Flutter Team** — Cross-platform framework
- **Indian SMB Community** — Target users

---

<div align="center">

**Made with ❤️ for Indian Small Businesses**

[Download Now](https://github.com/Vikram-Bosak/cash-counter-flutter/releases) | [Report Bug](https://github.com/Vikram-Bosak/cash-counter-flutter/issues) | [Request Feature](https://github.com/Vikram-Bosak/cash-counter-flutter/issues)

</div>
