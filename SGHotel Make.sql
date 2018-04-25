Use master
if exists (select * from sysdatabases where name='HotelSG')
		drop database HotelSG
go



 CREATE TABLE Amenities(
    AmenityID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
   [Name] CHAR(30) NOT NULL,   
)
GO

  CREATE TABLE RoomRate (
   RateID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
   Amount SMALLINT NOT NULL,
   
)
GO

 CREATE TABLE RoomInfo (
   RoomTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
   Occupancy TINYINT NOT NULL,
   RateID INT FOREIGN KEY REFERENCES RoomRate(RateID) NOT NULL,
   [Name] CHAR(30) NOT NULL,
)
GO

CREATE TABLE Room (
   Room# TINYINT NOT NULL,
   Floor# TINYINT NOT NULL,
   Building CHAR(1) NOT NULL,
   RoomType INT FOREIGN KEY REFERENCES RoomInfo(RoomTypeID) NOT NULL
   CONSTRAINT RoomID PRIMARY KEY (Building,Floor#,Room#) 
)
GO


   CREATE TABLE RoomAmenities (
	AmenityID INT NOT NULL,
	RoomNum TINYINT NOT NULL,
	Build char(1) NOT NULL,
	FloorNum TINYINT NOT NULL

	CONSTRAINT PK_RoomAmenities
		PRIMARY KEY (Build, RoomNum, FloorNum, AmenityID),
		CONSTRAINT FK_Room_RoomAmenities
		FOREIGN KEY (Build,FloorNum, RoomNum) 
		REFERENCES Room(Building, Floor#, Room#), 
	CONSTRAINT FK_Amenities_RoomAmenities
		FOREIGN KEY (AmenityID) 
		REFERENCES Amenities(AmenityID),
		
)
GO

 CREATE TABLE AddOns (
   AddOnID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
   Price INT NOT NULL,
   [Name] CHAR(30) NOT NULL,
)
GO


CREATE TABLE [Guest Info](
CustomerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
[Name] CHAR(30) NOT NULL,
Phone CHAR(13) NULL,
Email CHAR(50) NULL,
Age TINYINT NOT NULL
)
GO

CREATE TABLE [Promo Code](
PromoCode Char(10) PRIMARY KEY NOT NULL,
DateStart Date NOT NULL,
ExpirationDate Date NOT NULL,
[IsPercentage?] BIT NOT NULL,
Amount TINYINT NOT NULL
)
GO
CREATE TABLE Reservation(
ReservationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
CustomerID INT NOT NULL,
DateStart DATE NOT NULL,
DateEnd DATE NOT NULL,
Promotion Char(10) NULL,
CONSTRAINT CustomerID FOREIGN KEY (CustomerID) REFERENCES [Guest Info](CustomerID),
CONSTRAINT Promotion FOREIGN KEY (Promotion) REFERENCES [Promo Code](PromoCode)
)
GO
CREATE TABLE GuestReservation(
ReservationID INT NOT NULL,
GuestID INT NOT NULL,
CONSTRAINT ReservationID FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
CONSTRAINT GuestID FOREIGN KEY (GuestID) REFERENCES [Guest Info](CustomerID)
)
GO

 CREATE TABLE RoomReservation (
	ReservationID INT NOT NULL,
	RoomNum TINYINT NOT NULL,
	Build char(1) NOT NULL,
	FloorNum TINYINT NOT NULL
	PRIMARY KEY (Build,FloorNum,RoomNum, ReservationID),
	CONSTRAINT FK_Reservation_RoomReservation
		FOREIGN KEY (ReservationID) 
		REFERENCES Reservation(ReservationID),
	CONSTRAINT FK_Room_RoomReservation
		FOREIGN KEY (Build,FloorNum,RoomNum)
		REFERENCES Room(Building,Floor#,Room#),
)
GO

 CREATE TABLE RoomReservationAddOns (
   AddOnID INT NOT NULL,
   ReservationID INT NOT NULL,
   PRIMARY KEY (ReservationID, AddOnID),
	CONSTRAINT FK_AddOn_RoomReservationAddOns
		FOREIGN KEY (AddOnID) 
		REFERENCES AddOns(AddOnID),

)
GO

CREATE TABLE Bill(

 BillID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Total INT NOT NULL,
	CustomerName char(1) NOT NULL,
	Tax TINYINT NOT NULL
)
GO

CREATE TABLE [Bill Detail](
	AddOns INT NOT NULL,
	RoomRate INT NOT NULL,
	PromotionID CHAR(10) NULL
	  CONSTRAINT TotalID PRIMARY KEY (AddOns,RoomRate)
)
GO