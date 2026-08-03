# Bank Term Deposit Campaign - Conversion Analysis

11,162 mijoz ma'lumotlari asosida bank muddatli deposit kampaniyasining konversiya ko'rsatkichlarini tahlil qilish eng samarali mijozlar segmentini aniqlash va marketing resurslarini optimallashtirish bo'yicha tavsiyalar ishlab chiqish.

## 1. Business Problem

Bank telefon orqali muddatli deposit mahsulotini sotmoqchi. Marketing bo'limi resurslardan foydalanib (operatorlar vaqti, qo'ng'iroqlar soni) bilan konversiya darajasini oshirishni xohlaydi.

Asosiy savol: Qaysi mijozlar segmenti va qanday kontakt strategiyasi eng yuqori konversiyani beradi va joriy kampaniya qayerda resurslarni behuda sarflayapti?

## 2. Dataset

| Parametr | Qiymat |
|---|---|
| Manba | Bank Marketing Dataset (UCI Machine Learning Repository) |
| Hajmi | 11,162 mijoz |
| Ustunlar | age, job, marital, education, default, balance, housing, loan, contact, day, month, duration, campaign, pdays, previous, poutcome, deposit |

**Cheklovlar**
- Dataset ma'lum bir vaqt oralig'iga tegishli, hozirgi mijozlarning ma'lumotini to'liq aks ettirmasligi mumkin

## 3. Approach

Avval umumiy konversiya darajasini (baseline) hisobladim. Keyin mijozlarni uch yo'nalishda segmentladim:

1. Demografik - ta'lim darajasi, kasb
2. Behavior tarixi - oldingi kampaniya natijasi (`poutcome`), kontaktlar soni
3. Operatsion - qo'ng'iroq davomiyligi, oy bo'yicha taqsimot

Har bir segment uchun konversiya darajasini solishtirib, eng katta farq qayerda ekanini aniqladim. Tahlil MySQL'da SQL query'lar orqali bajarildi, natijalar Power BI'da vizualizatsiya qilindi.

## 4. Key Findings

- Baseline konversiya darajasi 47.4% (5289 mijoz deposit ochgan, 5873 mijoz ochmagan) - mijozlarning deyarli yarmi deposit ochgan, bu segmentatsiya uchun yaxshi asos

- Oldingi kampaniyada "success" bo'lgan mijozlarning konversiya darajasi 91.3% - bu butun datasetdagi eng kuchli signal. Solishtirish uchun: "failure" bo'lganlarda 50.3%, "unknown" (umuman kontakt qilinmagan) mijozlarda 40.7%

- Qo'ng'iroq 300 sekunddan uzoq davom etganda konversiya 72.2%, qisqa qo'ng'iroqlarda esa atigi 28.7% - 2.5 baravar farq

- May oyida qo'ng'iroqlar soni eng yuqori (2,824 ta) lekin bu oy konversiya darajasi bo'yicha eng samarali oy emas - resurslarning noto'g'ri taqsimlanishini ko'rsatadi

- Tertiary ta'lim darajasidagi mijozlarda konversiya 54.1%, primary darajada esa 39.4% - ta'lim darajasi bilan konversiya orasida aniq bog'liqlik bor (secondary - 44.7%, unknown - 50.7%)

- 3+ marta kontakt qilingan mijozlarda konversiya (63.8%) va 1–3 marta kontakt qilinganlarda (62.9%) deyarli farq yo'q - demak kontakt sonini 1 dan 3 gacha oshirish yetarli, undan ortig'i qo'shimcha samara bermaydi. Hali kontakt qilinmagan ("yangi") mijozlarda esa bu ko'rsatkich 37.3% - bu segmentga alohida yondashuv kerakligini ko'rsatadi

## 5. Recommendation

1. **Retargeting'ga ustuvorlik berish** - oldingi kampaniyada "success" bo'lgan mijozlar (91.3% konversiya) eng arzon va eng samarali segment. Operatorlar birinchi navbatda shu ro'yxatga qo'ng'iroq qilishi kerak.

2. **Operatorlarni suhbatni davom ettirishga o'rgatish** - qo'ng'iroq davomiyligi bilan konversiya o'rtasidagi kuchli bog'liqlik shuni ko'rsatadiki, operatorlarga mijozni tezroq "yo'q" deb qo'yib yubormaslik, savollarga to'liq javob berish bo'yicha training kerak.

3. **May oyidagi qo'ng'iroq hajmini qayta ko'rib chiqish** - yuqori hajm past samaradorlik bilan birga kelmoqda. Resurslarni boshqa, yuqori konversiya beradigan oylarga yo'naltirish tavsiya etiladi.

4. **Kontakt sonini 3 tadan oshirmaslik** - 3+ marta qo'ng'iroq qilish qo'shimcha konversiya bermayapti, bu operator vaqtini behuda sarflash degani. Kontakt limitini 3 ta bilan cheklash tavsiya etiladi.

5. **Ta'lim darajasiga qarab xabar matnini moslashtirish** - tertiary darajadagi mijozlar uchun batafsilroq, moliyaviy asoslangan taklif; primary darajadagi mijozlar uchun soddaroq, tushunarliroq xabar tayyorlash mumkin.

## 6. Tools Used

- **MySQL** - ma'lumotlarni saqlash va SQL orqali tahlil qilish
- **Power BI Desktop** - dashboard va vizualizatsiya
- **DAX** - measure va calculated column'lar (Conversion Rate%, duration_segment, contact_segment, deposit_flag)

## 7. Customer Acquisition Effort (CAC Proxy) by Segment

**Business Question:** Qaysi job va contact type segmentida mijozni konvertatsiya qilish uchun eng kam effort (contact soni) sarflanmoqda?

**Formula:**
```
CAC (proxy) = SUM(campaign) / SUM(deposit = 'yes' mijozlar soni)
```

**Note:** Datasetda real marketing xarajati ($ da) mavjud emas, shuning uchun campaign contact soni cost proxy sifatida ishlatildi. Past CAC qiymati - segment yuqori konversiya samaradorligiga ega ekanini, yuqori CAC esa ko'proq resurs sarflanganini bildiradi.

**Result:**

| job | contact | CAC | ConversionRate |
|---|---|---|---|
| student | cellular | 2.51 | 79.10% |
| retired | telephone | 2.74 | 75.88% |
| retired | cellular | 2.92 | 70.66% |
| unemployed | cellular | 3.11 | 62.91% |
| admin. | cellular | 3.97 | 54.42% |
| unemployed | telephone | 4.38 | 54.17% |
| self-employed | cellular | 4.46 | 53.31% |
| entrepreneur | telephone | 4.50 | 61.54% |
| management | cellular | 4.55 | 55.86% |
| technician | cellular | 4.91 | 52.51% |
| blue-collar | cellular | 5.17 | 45.05% |
| services | cellular | 5.20 | 48.33% |
| student | telephone | 5.21 | 61.29% |
| unknown | cellular | 5.22 | 55.10% |
| housemaid | cellular | 5.82 | 45.41% |
| entrepreneur | cellular | 6.13 | 40.64% |
| unknown | telephone | 6.20 | 45.45% |
| management | telephone | 6.30 | 47.24% |
| self-employed | telephone | 7.08 | 40.00% |
| housemaid | telephone | 7.21 | 45.16% |
| admin. | telephone | 7.39 | 48.81% |
| services | telephone | 8.19 | 34.78% |
| technician | telephone | 10.59 | 34.18% |
| blue-collar | telephone | 10.66 | 33.04% |

**Insight:** Eng past CAC — **student (cellular, 2.51)** va **retired (telephone/cellular, ~2.7-2.9)** segmentlarida kuzatiladi bu guruhlar eng kam effort bilan eng yuqori konversiyani (70-79%) beradi. Eng yuqori CAC esa **blue-collar** va **technician** kasb egalarida ayniqsa telephone kanali orqali (10.6+) - bu segmentlarga ko'proq qo'ng'iroq sarflansa ham konversiya past (33-34%) qolmoqda. Umumiy ko'rinish: deyarli barcha kasblarda **cellular kanali telephone'ga qaraganda past CAC va yuqori konversiya** beradi, bu resurslarni cellular kontaktlarga yo'naltirish tavsiyasini kuchaytiradi.

## 8. Statistical Significance Test: Contact Channel Comparison

**Business Question:** Cellular va telephone contact turlari orasida konversiya darajasida (deposit = 'yes') statistik ahamiyatli farq bormi?

**Hypotheses:**
```
H0 (Null): p_cellular = p_telephone   → ikki guruh o'rtasida konversiya farqi yo'q
H1 (Alternative): p_cellular ≠ p_telephone → statistik ahamiyatli farq bor
```

**Method:** Z-test for two proportions

```
p_pooled = (x1 + x2) / (n1 + n2)

Z = (p1 - p2) / sqrt( p_pooled * (1 - p_pooled) * (1/n1 + 1/n2) )
```

- p1, p2 - har bir guruhning konversiya foizi
- n1, n2 - har bir guruh hajmi (contact soni)
- x1, x2 - har bir guruhdagi konversiya (deposit='yes') soni

Qaror qabul qilish qoidasi: agar p-value < 0.05 bo'lsa, farq statistik ahamiyatli (tasodifiy emas) deb topiladi.

**Calculation:**

| Group | n | Converted (x) | Conversion Rate (p) |
|---|---|---|---|
| Cellular | 8042 | 4369 | 54.33% |
| Telephone | 774 | 390 | 50.39% |

```
p_pooled = (4369 + 390) / (8042 + 774) = 0.5398

Z = (0.5433 - 0.5039) / sqrt(0.5398 * 0.4602 * (1/8042 + 1/774))
Z = 2.10

p-value (two-tailed) ≈ 0.036
```

**Conclusion:** p-value (0.036) < 0.05 bo'lgani uchun H0 rad etiladi - cellular va telephone kanallari orasidagi konversiya farqi (54.33% vs 50.39%) statistik ahamiyatli, tasodifiy emas. Cellular kanali telephone'ga nisbatan yuqori konversiya ko'rsatadi bu esa CAC natijalarini ham tasdiqlaydi (7-bo'limda ko'rsatilganidek aksariyat segmentlarda cellular kanali past CAC va yuqori konversiya beradi)

