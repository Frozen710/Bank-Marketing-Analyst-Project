-- Bank Term Deposit Campaign - Conversion Analysis

11,162 mijoz ma'lumotlari asosida bank muddatli deposit kampaniyasining konversiya ko'rsatkichlarini tahlil qilish eng samarali mijozlar segmentini aniqlash va marketing resurslarini optimallashtirish bo'yicha tavsiyalar ishlab chiqish.

-- 1. Business Problem

Bank telefon orqali muddatli deposit mahsulotini sotmoqchi.Marketing bo'limi resurslardan foydalanib (operatorlar vaqti, qo'ng'iroqlar soni) bilan konversiya darajasini oshirishni xohlaydi.

Asosiy savol: Qaysi mijozlar segmenti va qanday kontakt strategiyasi eng yuqori konversiyani beradi va joriy kampaniya qayerda resurslarni behuda sarflayapti?


-- 2. Dataset

Parametr | Qiymat, 
Manba | Bank Marketing Dataset (UCI Machine Learning Repository),
Hajmi | 11,162 mijoz, 
Ustunlar | age, job, marital, education, default, balance, housing, loan, contact, day, month, duration, campaign, pdays, previous, poutcome, deposit

Cheklovlar
- Dataset ma'lum bir vaqt oralig'iga tegishli hozirgi mijozlarning ma'lumotini to'liq aks ettirmasligi mumkin

-- 3. Approach

Avval umumiy konversiya darajasini (baseline) hisobladim. Keyin mijozlarni uch yo'nalishda segmentladim

1. Demografik - ta'lim darajasi, kasb
2. Behaiovur tarixi - oldingi kampaniya natijasi (`poutcome`), kontaktlar soni
3. Operatsion - qo'ng'iroq davomiyligi, oy bo'yicha taqsimot

Har bir segment uchun konversiya darajasini solishtirib, eng katta farq qayerda ekanini aniqladim. Tahlil MySQL'da SQL query'lar orqali bajarildi, natijalar Power BI'da vizualizatsiya qilindi.

-- 4. Key Findings

- Baseline konversiya darajasi 47.4% (5289 mijoz deposit ochgan, 5873 mijoz ochmagan) - mijozlarning deyarli yarmi deposit ochgan bu segmentatsiya uchun yaxshi asos

- Oldingi kampaniyada "success" bo'lgan mijozlarning konversiya darajasi 91.3% - bu butun datasetdagi eng kuchli signal. Solishtirish uchun: "failure" bo'lganlarda 50.3%, "unknown" (umuman kontakt qilinmagan) mijozlarda 40.7%

- Qo'ng'iroq 300 sekunddan uzoq davom etganda konversiya 72.2%, qisqa qo'ng'iroqlarda esa atigi 28.7% - 2.5 baravar farq

- May oyida qo'ng'iroqlar soni eng yuqori (2,824 ta) lekin bu oy konversiya darajasi bo'yicha eng samarali oy emas - resurslarning noto'g'ri taqsimlanishini ko'rsatadi

- Tertiary ta'lim darajasidagi mijozlarda konversiya 54.1%, primary darajada esa 39.4% - ta'lim darajasi bilan konversiya orasida aniq bog'liqlik bor (secondary - 44.7%, unknown - 50.7%)

- 3+ marta kontakt qilingan mijozlarda konversiya (63.8%) va 1–3 marta kontakt qilinganlarda (62.9%) deyarli farq yo'q - demak kontakt sonini 1 dan 3 gacha oshirish yetarli undan ortig'i qo'shimcha samara bermaydi. Hali kontakt qilinmagan ("yangi") mijozlarda esa bu ko'rsatkich 37.3% - bu segmentga alohida yondashuv kerakligini ko'rsatadi

-- 5. Recommendation

1. Retargeting'ga ustuvorlik berish - oldingi kampaniyada muvaffaqiyatli bo'lgan mijozlar (91.3% konversiya) eng arzon va eng samarali segment. Operatorlar birinchi navbatda shu ro'yxatga qo'ng'iroq qilishi kerak.

2. Operatorlarni suhbatni davom ettirishga o'rgatish - qo'ng'iroq davomiyligi bilan konversiya o'rtasidagi kuchli bog'liqlik shuni ko'rsatadiki operatorlarga mijozni tezroq "yo'q" deb qo'yib yubormaslik savollarga to'liq javob berish bo'yicha training kerak.

3. May oyidagi qo'ng'iroq hajmini qayta ko'rib chiqish - yuqori hajm past samaradorlik bilan birga kelmoqda. Resurslarni boshqa, yuqori konversiya beradigan oylarga yo'naltirish tavsiya etiladi.

4. Kontakt sonini 3 tadan oshirmaslik - 3+ marta qo'ng'iroq qilish qo'shimcha konversiya bermayapti bu operator vaqtini behuda sarflash degani. Kontakt limitini 3 ta bilan cheklash tavsiya etiladi.

5. Ta'lim darajasiga qarab xabar matnini moslashtirish - tertiary darajadagi mijozlar uchun batafsilroq, moliyaviy asoslangan taklif; primary darajadagi mijozlar uchun soddaroq, tushunarliroq xabar tayyorlash mumkin.

-- 6. Tools Used

- MySQL - ma'lumotlarni saqlash va SQL orqali tahlil qilish
- Power BI Desktop - dashboard va vizualizatsiya
- DAX - measure va calculated column'lar (Conversion Rate%, duration_segment, contact_segment, deposit_flag)





