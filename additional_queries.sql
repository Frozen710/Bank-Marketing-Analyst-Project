
-- Additional SQL Queries
-- Quyidagi query'lar asosiy tahlilni to'ldiruvchi qo'shimcha tekshiruvlar sifatida bajarilgan

-- 1 - Savol har bir kasb (job) bo'yicha nechta mijoz bor va ularning o'rtacha balansi qancha?

Select job,Count(*) as mijozlar_soni, Avg(balance) as avg_balance
From bank
Group by job
Order by mijozlar_soni desc;

-- 2-Savol kredit defaultiga uchraganlarning o'rtacha balansi qanday

Select Round(Avg(balance),2) as avg_balance
From bank
Where `default` = 'yes';

-- 3-Savol Uy-joy krediti bo'lgan mijozlar ichida depozit ochganlar necha foiz

Select Round((Sum(Case When housing = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as housing_deposit_ochganlar_foizi
From bank
Where deposit = 'yes';

-- 4-Savol Balansdi segmentlarga bo'lish 
 
Select  Case
When balance < 0 Then 'Salbiy'
When balance Between 0 and 1000 Then 'Past(0-1k)'
When balance Between 1001 and 5000 Then 'Orta(1k-5k)'
When balance > 5000 Then 'Yuqori (5k+)'
End as balance_segment,
Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by balance_segment
Order by conversion_rate desc;

-- 5-Savol Kampaniya davomida har bir oy uchun qo'ng'iroqlar soni va depozit ochishlar dinamikasini

Select month,Count(*) as jami_qongiroqlar,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by month
Order by Field(month, 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec');

-- 6-Savol Har bir job kategoriyasi ichida depozit bo'yicha RANK

Select job, Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate,
Rank() Over (Order by Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) desc) as rank_tartib
From bank
Group by job;

-- 7-Savol Mijozlarning oldingi kontakt soni bo'yicha kogortlarga bo'lish

Select Case 
When previous = 0 Then 'yangi'
When previous Between 1 and 3 Then 'kam_kontakt(1-3)'
When previous > 3 Then 'kop_kontakt(3+)' End as kontakt_kogortlar,
Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by kontakt_kogortlar
Order by conversion_rate desc;

-- 8-Savol Har bir oy uchun depozit ochgan mijozlar sonini oldingi oy bilan solishtirish

Select month, Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Lag(Sum(Case When deposit = 'yes' Then 1 Else 0 End)) Over (Order by Field
(month, 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec')) as oldingi_oy_deposit_ochgan,
Round((Sum(Case When deposit = 'yes' Then 1 Else 0 End)-
Lag(Sum(Case When deposit = 'yes' Then 1 Else 0 End)) Over (Order by Field
(month, 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'))),2) as foizli_ozgarish,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by month;












