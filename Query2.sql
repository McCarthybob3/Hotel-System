USE master
GO

--write a query that returns rooms that do not contain a specific amenity
SELECT CONCAT(ra.Build,ra.FloorNum,'0',ra.RoomNum) AS Room, ra.AmenityID
FROM Amenities A
INNER JOIN RoomAmenities RA ON A.AmenityID=RA.AmenityID
WHERE NOT A.AmenityID= 1;
GO