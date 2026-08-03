-- 1-Savol deposit ochgan va ochmagan mijozlar soni va foizi qancha

Select Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan_mijozlar,
Sum(Case When deposit = 'no' Then 1 Else 0 End) as deposit_ochmagan_mijozlar,
Round((Sum(Case When deposit = 'yes' Then 1 Else 0 End)*100.0/ Count(*)),2) as deposit_ochgan_mijozlar_foizi,
Round((Sum(Case When deposit = 'no' Then 1 Else 0 End)*100.0/ Count(*)),2) as deposit_ochmagan_mijozlar_foizi
From bank;

-- 2-Savol qaysi oyda eng kop qo'ng'iroq qilingan

Select month, Count(*) as qongiroqlar_soni
From bank
group by month
Order by qongiroqlar_soni desc
Limit 1;

-- 3-Savol Har bir ta'lim darajasi uchun depozit conversion rate qancha

Select education,Round((Sum(Case When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by education;

-- 4-Savol Oldingi kompaniyada muvaffaqiyatli bo'lgan mijozlarning joriy deposit ochish ehtimoli qanchalik yuqori

Select poutcome,
Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by poutcome
Order by conversion_rate desc;

-- 5-Savol Qo'ng'iroq davomiyligi 300 sekunddan yuqori bo'lgan mijozlarda depozit ochish ehtimoli qancha

Select Case When duration > 300 Then '300+ sekund' Else '300 dan past' End as guruh,
Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Group by Case When duration > 300 Then '300+ sekund' Else '300 dan past' End;

-- 6-Savol Kamida 2 martda kontakt qilingan va avvalgi kampaniyada ham qatnashgan mijozlar ichida eng muvaffaqiyatli segment qaysi?

Select Case 
When previous = 0 Then 'yangi'
When previous Between 1 and 3 Then 'kam_kontakt(1-3)'
When previous > 3 Then 'kop_kontakt(3+)' End as kontakt_kogortlar,
Count(*) as jami,
Sum(Case When deposit = 'yes' Then 1 Else 0 End) as deposit_ochgan,
Round((Sum(Case 
When deposit = 'yes' Then 1 Else 0 End)*100/Count(*)),2) as conversion_rate
From bank
Where campaign >= 2
Group by kontakt_kogortlar
Order by conversion_rate desc

-- 7-Savol CAC ni hisoblash job, contact bo'yicha

Select 
    job, contact,
    Sum(campaign) / Nullif(Sum(Case When deposit = 'yes' Then 1 Else 0 End), 0) as CAC,
    Round(100.0 * Sum(Case When deposit = 'yes' Then 1 Else 0 End) / Count(*), 2) as ConversionRate
From bank
Where contact <> 'unknown'
Group By job, contact
Order By CAC Asc;

-- 8-Savol Z-test hisoblash contact bo'yicha n va x

Select 
    contact,
    Count(*) as n,
    Sum(Case When deposit = 'yes' Then 1 Else 0 End) as x
From bank
Where contact <> 'unknown'
Group By contact;













