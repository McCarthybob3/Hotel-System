USE master
GO

--return all rooms for a particular customer
SELECT CONCAT(rr.Build,rr.FloorNum,'0',rr.RoomNum) AS Room, r.CustomerID
FROM RoomReservation RR
INNER JOIN Reservation R ON RR.ReservationID=R.ReservationID
WHERE R.CustomerID = 8;
GO