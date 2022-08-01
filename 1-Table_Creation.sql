create database aragon_municipal_library

--use aragon_municipal_library


on primary
(
	name = 'aragon_municipal_library',
	size = 12MB,
	filegrowth = 8MB,
	maxsize = 500MB,	-- unlimited
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\aragon_municipal_library.mdf'
)
log on
(
	-- 1) log logical filename
	name = 'aragon_municipal_library_log',
	size = 3MB,
	filegrowth = 10%,
	maxsize = 25MB,
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\aragon_municipal_library_log.ldf'
)
;
go

CREATE TABLE [Author] (
  [Author_ID] SmallInt unique not null,
  [Author_Name] VarChar(30) unique not null,
  PRIMARY KEY ([Author_ID])
);

CREATE TABLE [Items] (
  [ISBN] VarChar(17)unique not null,
  [Language] VarChar(20) not null,
  [Binding_Type] VarChar(15) not null,
  [Current_Loan_ID] Varchar(50),
  [Copy_No] Varchar(15) not null,
  [Title_Id] Varchar(20) not null, -- foreign key from Title
  [Author_Id] Smallint not null, -- Foreing key from Author table
  PRIMARY KEY ([ISBN]),
  check (copy_no>0)
);

CREATE TABLE [Title] (
  [Title_Id] Varchar(20) unique not null,
  [Title_Name] VarChar(100) Not null,
  [ISBN] VarChar(17)Not null, -- Foreign key from Items table
  PRIMARY KEY ([Title_Id])
);

CREATE TABLE [Loan] (
  [Loan_ID] BigInt unique not null,
  [Check_Out_Book_Time] Time not null,
  [Check_Out_Book_Date] Date not null,
  [Book_Due_Days_After_Checkout] TinyInt not null,
  [Check_In_Time] Time,
  [Check_In_Date] Date,
  [ISBN] VarChar(17) Not null, -- Foreign key from Items table
  [Member_Id] smallint Not null, -- Foreign key from Member table
  PRIMARY KEY ([Loan_ID]),
  check (check_in_date>=check_out_book_date),
  check (check_in_time>=check_out_Book_time)
);

CREATE TABLE [Copy] (
  [Copy_No] VarChar(15) unique not null,
  [On_Loan] Char(1) not null,
  [Waitlist] Tinyint,
  [Current_Loan_ID] BIGINT, -- Foreign key from Loan ID
  [ISBN] VarChar(17) not null, -- Foreign key from Items table
  PRIMARY KEY ([Copy_No])
);

CREATE TABLE [Juvenile] (
  [Juvenile_ID] SmallInt unique not null,
  [Street] VarChar(100) not null,
  [City] VarChar(30) not null,
  [State] VarChar(10) not null,
  [ZIP] VarChar(10) not null,
  [Phone_No] VarChar(20) not null,
  [Member_ID] SmallInt not null, -- Foreign key from Member table
  PRIMARY KEY ([Juvenile_ID])
);

CREATE TABLE [Reservation] (
  [Reservation_ID] BigInt not null,
  [Reservation_Date] Date not null,
  [Reservation_Time] Time not null,
  [No_Of_Books_Reserved] VarChar(4) not null,
  [Member_ID] SmallInt not null, -- Foreign key from Member table
  PRIMARY KEY ([Reservation_ID])
);

CREATE TABLE [Librarian] (
  [Librarian_ID] SmallInt unique not null,
  [Last_Name] VarChar(50) not null,
  [First_Name] VarChar(50) not null,
  [Middle_Initial] Char(1),
  [Date_Of_Birth] Date not null,
  [Street] VarChar(100) not null,
  [City] VarChar(30) not null,
  [State] VarChar(10) not null,
  [ZIP] VarChar(10) not null,
  [Phone_No] VarChar(20) not null,
  [Member_ID] SmallInt not null, --Foreign key from Member table
  PRIMARY KEY ([Librarian_ID])
);

CREATE TABLE [Membership] (
  [Membership_Card_No] VarChar(20) unique not null,
  [Membership_Type] VarChar(20)not null,
  [Membership_Start_Date] Date not null,
  [Membership_Expiry_Date] Date not null,
  [Member_ID] SmallInt not null, --Foreign key from Member table
  PRIMARY KEY ([Membership_Card_No]),
  check(membership_expiry_date>=Membership_start_date)
);

CREATE TABLE [Adult] (
  [Adult_ID] SmallInt unique not null,
  [Street] VarChar(100) not null,
  [City] VarChar(30) not null,
  [State] VarChar(10) not null,
  [ZIP] VarChar(10) not null,
  [Phone_No] VarChar(20) not null,
  [Member_ID] SmallInt not null, -- Foreign key from Member table
  PRIMARY KEY ([Adult_ID])
);

CREATE TABLE [Member] (
  [Member_ID] SmallInt unique not null,
  [Last_Name] VarChar(50) not null,
  [First_Name] VarChar(50) not null,
  [Middle_Initial] Char(1),
  [Photograph] Char(1),
  [Date_of_Birth] Date not null,
  [Adult_ID] SmallInt not null, -- Foreign key from Adult Table
  [Juvenile_ID] SmallInt, -- Foreign key from Juvenile Table
  [Loan_Id] Bigint, -- Foreign key from Loan table
  [Reservation_Id] Bigint, -- Foreign key from Reservation table
  PRIMARY KEY ([Member_ID])
);
