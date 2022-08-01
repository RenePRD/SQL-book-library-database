use aragon_municipal_library
;
go

alter table Items
add constraint [FK_Items_Author_ID] FOREIGN KEY (Author_Id) REFERENCES [Author](Author_Id),
    constraint [FK_Items_Title_ID] foreign key (Title_Id) references [Title](Title_Id)
;

alter table Title
add constraint FK_Title__ISBN Foreign key (ISBN) references [Items](ISBN)
;

alter table Loan
add CONSTRAINT [FK_Loan.ISBN] FOREIGN KEY ([ISBN]) REFERENCES [Items]([ISBN]),
    CONSTRAINT [FK_Loan.Member_Id] FOREIGN KEY ([Member_Id]) REFERENCES [Member]([Member_Id])
;

alter table Copy
add CONSTRAINT [FK_Copy.ISBN] FOREIGN KEY ([ISBN]) REFERENCES [Items]([ISBN]),
    CONSTRAINT [FK_Copy.Current_Loan_Id] FOREIGN KEY ([Current_Loan_Id]) REFERENCES [Loan]([Loan_Id])
;

alter table Juvenile
add CONSTRAINT [FK_Juvenile.Member_ID] FOREIGN KEY ([Member_ID]) REFERENCES [Member]([Member_ID])
;

alter table Reservation
add CONSTRAINT [FK_Reservation.Member_Id] FOREIGN KEY ([Member_ID]) REFERENCES [Member]([Member_ID])
;

alter table Librarian
add CONSTRAINT [FK_Librarian.Member_ID] FOREIGN KEY ([Member_ID]) REFERENCES [Member]([Member_ID])
;

alter table Membership
add CONSTRAINT [FK_Membership.Member_Id] FOREIGN KEY ([Member_ID]) REFERENCES [Member]([Member_Id])
;

alter table Adult
add CONSTRAINT [FK_Adult.Member_ID] FOREIGN KEY ([Member_ID]) REFERENCES [Member]([Member_ID])
;

alter table Member
add CONSTRAINT [FK_Member.Adult_ID] FOREIGN KEY ([Adult_ID]) REFERENCES [Adult]([Adult_ID]),
    CONSTRAINT [FK_Member.Reservation_Id] FOREIGN KEY ([Reservation_Id]) REFERENCES [Reservation]([Reservation_ID]),
    CONSTRAINT [FK_Member.Juvenile_ID] FOREIGN KEY ([Juvenile_ID]) REFERENCES [Juvenile]([Juvenile_ID]),
    CONSTRAINT [FK_Member.Loan_Id] FOREIGN KEY ([Loan_ID]) REFERENCES [Loan]([Loan_ID])
	;


-- DEFAULT CONSTRAINTS ---------------------------

alter table  Member
	add constraint df_photograph default 'N' for Photograph
;
go

alter table Adult
	add constraint df_city default 'Montreal' for City
;
go

alter table Adult
	add constraint df_state default 'Quebec' for State
;
go

alter table Copy
	add constraint df_copy_on_loan default 'N' for On_Loan
;
go

alter table Librarian 
	add constraint df_city_librarian default 'Montreal' for City
;
go

alter table Librarian
	add constraint df_state_librarian default 'Quebec' for State
;
go


alter table Loan
	add constraint df_loan_period default (14) for Book_Due_Days_After_Checkout
;
go


-- check constraints

alter table Member
	add constraint ck_DOB_member check (Date_of_Birth <= getDate() )
;
go

alter table Member
	add constraint ck_Photograph check (Photograph = 'y' OR Photograph = 'n')
;
go

alter table Librarian
	add constraint ck_DOB_librarian check (Date_of_Birth <= getDate() )
;
go

alter table Loan
	add constraint ck_checkout_time check (Check_In_Date >= Check_Out_Book_Date)
;
go

alter table Copy
	add constraint ck_copy_on_loan check (On_Loan = 'y' OR On_Loan = 'n')
;
go

alter table Membership 
	add constraint ck_Membership_expiry_date check (Membership_Expiry_Date >= getDate() )
;
go

alter table Reservation
	add constraint ck_reservation_limit check (No_of_Books_Reserved <= 4)
;
go

