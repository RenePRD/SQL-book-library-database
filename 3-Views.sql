use aragon_municipal_library
go

-- View 1
Create view [Mailing List] as 
		select last_name, first_name, Street, City, State, Zip
		from Member, Adult
		where CAST(getDate() as date) <= (select Membership_Expiry_Date from membership as date)
;
go


-- View 2
create view [Book_View_2] as
		select Items.ISBN, Copy.Copy_No, on_Loan, Title.Title_Name, Language, Binding_type
		from Title, Items, Copy
		where Items.ISBN = 1 and Items.ISBN = 500 and Items.ISBN = 1000 
;
go

--View 3
create view adultwideView
as
    SELECT 
CONCAT    (First_Name, Middle_Initial, Last_Name ) as Name,
CONCAT  (Street, City, State, Zip) as Address
    FROM Member leftouterjoin Adult
     ON Member.Member_ID = Adult.Member_ID
     Where Adult.Member_ID is not null

;
go

--View 4
Create view showInformationOfSelectedMember
as

        SELECT 
CONCAT    (First_Name, Middle_Initial, Last_Name ) as FullName, ISBN, Reservation_Date_Time as log_date
        from Member as Mem, Title, Reservation
        Where Mem.Member_Id = 250 and Mem.Member_Id = 341 and Mem.Member_Id = 1675
        GROUP BY Mem.Member_Id
        ORDER By Mem.Member_Id ASC

;
go

-- View 5
create view [ChildwideView] as
	select  MB.Last_Name, MB.First_Name, AD.Street, AD.City, AD.State, AD.ZIP
	from Juvenile as JV
		inner join Member as MB
			on JV.Juvenile_ID = MB.Juvenile_ID
		inner join Adult as AD
			on MB.Adult_ID = AD.Adult_ID
;
go


-- View 6

create view [CopywideView] as
	select CP.Copy_No, TL.Title_Name, ITM.ISBN, ITM.Language, ITM.Author_Id, ITM.Binding_Type, CP.On_Loan, CP.Current_Loan_ID, CP.Waitlist
	from Items as ITM
		inner join Copy as CP
			on ITM.Copy_No = CP.Copy_No
		inner join Title as TL
			on CP.ISBN = TL.ISBN
;
go

-- View 7

create view [LoanableView] as
	select Copy_No, Title_Name, ISBN, Language, Author_Id, Binding_Type, On_Loan, Current_Loan_ID, Waitlist
	from CopywideView
	where On_Loan = 'y'
;
go



-- view 8
CREATE VIEW [OnshelfView] AS
	SELECT on_loan = 'N',
	From CopywideView
;
go


-- View 9
CREATE VIEW [OnloanView] AS
	SELECT Loan.Loan_id, Member.Member_ID, title_name
	From Loan, title, Member
	Where Loan.Loan_ID = title.On_Loan and  Loan.Loan_ID = Member.Loan_Id
;
go


-- View 10
CREATE VIEW [OverdueView] AS
	SELECT Loan, title, Member
	From OnloanView
	Where cast(getDate() as date) >= Loan.Book_Due_Days_After_Checkout and Loan.Check_In_Date = null
;
go