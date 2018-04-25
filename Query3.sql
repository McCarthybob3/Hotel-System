USE master
GO

--Count all times a particular promo code is used
SELECT P.PromoCode, count(R.Promotion) as count
FROM [Promo Code] P
Left JOIN Reservation R on P.PromoCode=R.Promotion
GROUP BY p.PromoCode