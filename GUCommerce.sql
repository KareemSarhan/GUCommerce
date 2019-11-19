Create DataBase GUCommerce;
Create Table Users(
	username Varchar(200) Primary Key,
	password Varchar(20),
	first_name Varchar(50),
	last_name Varchar(50),
	email Varchar(50)
);
Create Table User_mobile_numbers(
	mobile_number Varchar(20),
	username Varchar(200),
	Primary Key(mobile_number,username),
	Foreign Key(username) References Users on Delete Cascade on Update Cascade
);
Create Table User_Addresses(
	address Varchar(500),
	username Varchar(200),
	Primary Key(username,address),
	Foreign Key(username) References Users on Delete Cascade on Update Cascade
);
Create Table Customer(
	points Int,
	username Varchar(200),
	Foreign Key(username) References Users on Delete Cascade on Update Cascade,
	Primary Key(username)
);
Create Table Admins(
	username Varchar(200) Primary Key,
	Foreign Key(username) References Users on Delete Cascade on Update Cascade
);
Create Table Vendor(
	username Varchar(200) Primary Key,
	activated Bit,
	company_name Varchar(20),
	bank_acc_no Varchar(20),
	admin_username Varchar(200),
	Foreign Key(username) References Users on Delete Cascade on Update Cascade,
	Foreign Key(admin_username) References Admins on Delete No Action on Update No action --Delete and update manually
);
Create Table Delivery_Person(
	username Varchar(200) Primary Key,
	is_activated Bit,
	Foreign Key(username) References Users on Delete Cascade on Update Cascade
);
Create Table Credit_Card(
	number Varchar(30) Primary Key,
	expiry_date DATE,
	cvv_code Varchar(20)
);
Create Table Delivery(
	id INT Primary Key IDENTITY,
	type Varchar(20),
	time_duration Int,
	fees Decimal(5,3),
	username Varchar(200),
	Foreign Key(username) References Admins on Delete Cascade on Update Cascade
);
Create Table GiftCard(
	code Varchar(20) Primary Key,
	expiry_date Date,
	amount Int,
	username Varchar(200),
	Foreign Key(username) References Admins on Delete Cascade on Update Cascade
);
Create Table Orders(
	order_no Int Primary Key,
	total_amount Decimal(10,3),
	order_date Date,
	cash_amount Decimal(10,3),
	credit_amount Decimal(10,3),
	payment_type Varchar(20),
	order_status Varchar(50),
	remaining_days Int,
	time_limit Int,
	GiftCardCodeUsed Varchar(20),
	customer_name Varchar(200),
	delivery_id Int,
	CreditCard_number Varchar(30),
	Foreign Key(CreditCard_number) References Credit_Card on Delete Cascade on Update Cascade,
	Foreign Key(GiftCardCodeUsed) References GiftCard on Delete Cascade on Update Cascade,
	Foreign Key(customer_name) References Customer on Delete No Action on Update No Action, --Delete and update manually
	Foreign Key(delivery_id) References Delivery on Delete No Action on Update No Action --Delete and update manually
);
Create Table Products(
	serial_no Int Primary Key IDENTITY,
	product_name Varchar(50),
	category Varchar(20),
	product_description Varchar(1000),
	price Decimal(10,2),
	final_price Decimal(10,2),
	color Varchar (20),
	available Bit,
	rate int,
	vendor_username Varchar(200),
	customer_username Varchar(200),
	customer_order_id Int,
	Foreign Key(vendor_username) References Vendor on Delete No Action on Update No Action, --Delete and update manually
	Foreign Key(customer_username) References Customer on Delete No Action on Update No Action, --Delete and update manually
	Foreign Key(customer_order_id) References Orders on Delete Cascade on Update Cascade
);
Create Table CustomerAddstoCartProduct(
	serial_no Int,
	customer_username Varchar(200),
	Primary Key(serial_no,customer_username),
	Foreign Key(serial_no) References Products on Delete Cascade on Update Cascade,
	Foreign Key(customer_username) References Customer on Delete No Action on Update No Action --Delete and update manually
);
Create Table Todays_Deals(
	deal_id Int Primary Key,
	deal_amount Int,
	expiry_date Date,
	admin_username Varchar(200),
	Foreign Key(admin_username) References Admins on Delete Cascade on Update Cascade
);
Create Table Todays_Deals_Products(
	deal_id Int,
	serial_no Int,
	Primary Key(deal_id, serial_no),
	Foreign Key(deal_id) References Todays_Deals on Delete Cascade on Update Cascade,
	Foreign Key(serial_no) References Products on Delete No Action on Update No Action --Delete and update manually
);
Create Table offer(
	offer_id Int Primary Key,
	offer_amount int,
	expiry_date Date
);
Create Table offersOnProduct(
	offer_id Int,
	serial_no Int,
	Primary Key(offer_id,serial_no),
	Foreign Key(offer_id) References Offer on Delete Cascade on Update Cascade,
	Foreign Key(serial_no) References Products on Delete Cascade on Update Cascade
);
Create Table Customer_Question_Product(
	serial_no Int,
	customer_name Varchar(200),
	question Varchar(100),
	answer Varchar(500),
	Primary Key(serial_no,customer_name),
	Foreign Key(serial_no) References Products on Delete Cascade on Update Cascade,
	Foreign Key(customer_name) References Customer on Delete No Action on Update No Action --delete and update manualy
);
Create Table Wishlist(
	username Varchar(200),
	name Varchar(100),
	Primary Key(username,name),
	Foreign Key(username) References Customer on Delete Cascade on Update Cascade
);
Create Table Wishlist_Product(
	username Varchar(200),
	wish_name Varchar(100),
	serial_no int,
	Primary Key(username, wish_name, serial_no),
	Foreign Key(username,wish_name) References Wishlist on Delete Cascade on Update Cascade,
	Foreign Key(serial_no) References Products on Delete No Action on Update No Action --Delete and update manually
);
Create Table Admin_Customer_Giftcard(
	code Varchar(20),
	customer_username Varchar(200),
	admin_username Varchar(200),
	remaining_points Int,
	Primary Key(code, customer_username, admin_username),
	Foreign Key(code) References GiftCard on Delete Cascade on Update Cascade,
	Foreign Key(customer_username) References Customer on Delete No Action on Update No Action, --Delete and update manually
	Foreign Key(admin_username) References Admins on Delete No Action on Update No Action --Delete and update manually
);
Create Table Admin_Delivery_Order(
	delivery_username Varchar(200),
	order_no Int,
	admin_username Varchar(200),
	delivery_window VarchAr(100),
	Primary Key(delivery_username,order_no),
	Foreign Key(delivery_username) References Delivery_Person on Delete Cascade on Update Cascade,
	Foreign Key(order_no) References Orders on Delete No Action on Update No Action, --Delete and update manually
	Foreign Key(admin_username) References Admins on Delete No Action on Update No Action --Delete and update manually
);
Create Table Customer_CreditCard(
	customer_name Varchar(200),
	cc_number Varchar(30),
	Primary Key(customer_name,cc_number),
	Foreign Key(customer_name) References Customer on Delete Cascade on Update Cascade,
	Foreign Key(cc_number) References Credit_Card on Delete Cascade on Update Cascade
);
Alter Table Customer Add Constraint df_points Default 0 For points;
Exec sp_rename 'Products.availabe', 'availabe', 'COLUMN';

Alter Table Delivery Alter Column id int Primary Key Identity;
------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Procedures---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------Regesteration-------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
Go;
Create Proc customerRegister
	@username Varchar(20),
	@first_name Varchar(20),
	@last_name Varchar(20),
	@password Varchar(20),
	@email Varchar(50)
	AS
	Begin
		IF Not Exists(Select username
			From Customer
			Where Customer.username = @username)
			Begin
				Insert Into Users(username,first_name,last_name,password,email) 
					Values(@username,@first_name,@last_name,@password,@email);
				Insert Into Customer(username) Values(@username);
			End
		Else
			print'Username Already Taken';
	End
Go;
Create Proc vendorRegister
	@username Varchar(20),
	@first_name Varchar(20),
	@last_name Varchar(20),
	@password Varchar(20),
	@email Varchar(50),
	@company_name Varchar(20),
	@bank_acc_no Varchar(20)
	AS
	Begin
		IF Not Exists(Select username
			From Vendor
			Where Vendor.username = @username)
			Begin
				Insert Into Users(username,first_name,last_name,password,email) 
					Values(@username,@first_name,@last_name,@password,@email);
				Insert Into Vendor(username, bank_acc_no, company_name)
					Values(@username, @bank_acc_no, @company_name);
			End
		Else
			print'Username Already Taken';
	End
drop Table Todays_Deals_Products;
------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------Users-----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
--a)
Go;
Create Procedure userLogin
	@username Varchar(20),
	@password Varchar(20),
	@success Bit Output,
	@type Int Output
	AS
	Begin
		If Exists (Select username, password
				   From Users 
				   Where username = @username AND password = @password)
		Begin
			Set @success =1
			if Exists(Select username
				 From Customers
				 Where username=@username)
				 Set @type =0
			Else
				Begin
					if Exists (Select username
							   From Vendor 
							   Where username=@username)
						Set @type =1
				    Else
						if Exists (Select username
								   From Admins
								   Where username =@username)
							Set @type =2
						Else
							Set @type =3
				End
			End
			Else
				Set @success =0
		print @success
		print @type	
	End
--b)
Go;
Create Procedure addMobile
	@username Varchar(20),
	@mobile_number Varchar(20)
	AS
	Begin
		Declare @tempU Varchar(20)
		Select @tempU
		From Users 
		Where @tempU =@username
		Insert Into User_mobile_numbers (username ,mobile_number) Values (@tempU ,@mobile_number)
	End
--c)
Go;
Create Procedure addAddress
	@username Varchar(20),
	@address Varchar(100)
	AS
		Declare @tempU Varchar(20)
		Select @tempU
		From Users 
		Where @tempU =@username
		Insert Into User_Addresses(username ,address) Values (@tempU ,@address)
------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------Customer---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
--a)
Go;
Create Procedure showProducts
	AS
	Begin
		Select *
		From Products
	End
--b)
Go;
Create Proc ShowProductsbyPrice
	AS
	Begin
		Select *
		From Products
		Order BY price ASC
	End
--c)
Go;
Create Proc searchbyname
	@text Varchar(20)
	AS
	Begin
		Select *
		From Products
		Where product_name=@text
	END
--d)
Go;
Create Proc AddQuestion
	@serial int, 
	@customer varchar(20), 
	@Question varchar(50)
	AS
	Begin
		Insert Into Customer_Question_Product(serial_no, customer_name, question) Values(@serial, @customer, @Question)
	END
--e)
Go;
Create Proc addToCart
	@customername varchar(20), 
	@serial int
	AS
	Begin
		Insert Into CustomerAddstoCartProduct(customer_username, serial_no) Values(@customername, @serial)
	End
Go;
Create Proc removefromCart
	@customername varchar(20), 
	@serial int
	AS
	Begin
		Delete From CustomerAddstoCartProduct Where customer_username=@customername AND serial_no=@serial
	End
--f)
Go;
Create Proc createWishlist
	@customername varchar(20), 
	@name varchar(20)
	AS
	Begin
		Insert Into Wishlist(username,name) Values(@customername,@name)
	End
--g)
Go;
Create Proc AddtoWishlist
	@customername varchar(20), 
	@wishlistname varchar(20), 
	@serial int
	As
	Begin
		Insert Into Wishlist_Product (username, serial_no, wish_name) Values(@customername, @serial, @wishlistname) 
	End
GO;
Create Proc removefromWishlist
	@customername varchar(20), 
	@wishlistname varchar(20), 
	@serial int
	AS
	Begin
		Delete From Wishlist_Product Where username=@customername AND wish_name = @wishlistname AND serial_no=@serial
	End
--h)
Go;
Create Proc showWishlistProduct
	@customername varchar(20), 
	@name varchar(20)
	AS
	Begin
		Select p.*
		From Products p	
			Inner Join Wishlist_Product w On w.serial_no=p.serial_no
		Where w.username=@customername AND w.wish_name=@name
	End
--i)
Go;
Create Proc viewMyCart
	@customer varchar(20)
	AS
	Begin
		Select p.*
		From Products p
			Inner Join CustomerAddstoCartProduct c On p.serial_no=c.serial_no
		Where c.customer_username=@customer
	End
--j)


------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------Insertions------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Users(Username,first_name,last_name,password,email) VALUES('hana.aly','hana','aly','pass1','hana.aly@guc.edu.eg')
INSERT INTO Users(Username,first_name,last_name,password,email) VALUES('ammar.yasser','ammar','yasser','pass4','ammar.yasser@guc.edu.eg')
INSERT INTO Users(Username,first_name,last_name,password,email) VALUES('nada.sharaf','nada','sharaf','pass7','nada.sharaf@guc.edu.eg')
INSERT INTO Users(Username,first_name,last_name,password,email) VALUES('hadeel.adel','hadeel','adel','pass13','hadeel.adel@guc.edu.eg')
INSERT INTO Users(Username,first_name,last_name,password,email) VALUES('mohamed.tamer','mohamed','tamer','pass16','mohamed.tamer@guc.edu.eg')

INSERT INTO Admins(Username) VALUES('hana.aly')
INSERT INTO Admins(Username) VALUES('nada.sharaf')

INSERT INTO Customer(Username,points) VALUES('ammar.yasser',15)

INSERT INTO CustomerAddstoCartProduct(serial_no,customer_username)VALUES(1,'ammar.yasser')

INSERT INTO Vendor(username,activated,company_name,bank_acc_no,admin_username) VALUES('hadeel.adel',1,'Dello',47449349234,'hana.aly')

INSERT INTO Delivery_Person(is_activated,username) VALUES(1,'mohamed.tamer')

INSERT INTO User_Addresses(address,username) VALUES('New Cairo','hana.aly')
INSERT INTO User_Addresses(address,username) VALUES('Heliopolis','hana.aly')

INSERT INTO User_mobile_numbers (mobile_number,username) VALUES(01111111111,'hana.aly')
INSERT INTO User_mobile_numbers (mobile_number,username) VALUES(1211555411,'hana.aly')

INSERT INTO Credit_Card(number,expiry_date ,cvv_code) VALUES( '4444-5555-6666-8888' ,'2028-10-19',232)


INSERT INTO Delivery(Type,time_duration ,fees) VALUES('pick-up',7 ,10)
INSERT INTO Delivery(Type,time_duration ,fees) VALUES('regular',14 ,30)
INSERT INTO Delivery(Type,time_duration ,fees) VALUES('speedy ',1 ,50)

INSERT INTO Products(product_name, category ,product_description ,price, final_price ,color ,available ,rate ,vendor_username ) VALUES('Bag','Fashion','backbag',100,100,'yellow',1,0,'hadeel.adel')
INSERT INTO Products(product_name, category ,product_description ,price, final_price ,color ,available ,rate ,vendor_username ) VALUES('Blue pen','stationary','useful pen',10,10,'Blue',1,0,'hadeel.adel')
INSERT INTO Products(product_name, category ,product_description ,price, final_price ,color ,available ,rate ,vendor_username ) VALUES('Blue pen','stationary','useful pen',10,10,'Blue',0,0,'hadeel.adel')

INSERT INTO Todays_Deals(deal_id,deal_amount, admin_username ,expiry_date) VALUES(1,30,'hana.aly','2019-11-30')
INSERT INTO Todays_Deals(deal_id,deal_amount, admin_username ,expiry_date) VALUES(2,40,'hana.aly','2019-11-18')
INSERT INTO Todays_Deals(deal_id,deal_amount, admin_username ,expiry_date) VALUES(3,50,'hana.aly','2019-12-12')
INSERT INTO Todays_Deals(deal_id,deal_amount, admin_username ,expiry_date) VALUES(4,10,'nada.sharaf','2019-11-12')

INSERT INTO offer(offer_id ,offer_amount,expiry_date) VALUES(1,50,'2019-11-30')

INSERT INTO Wishlist (username,name) VALUES( 'ammar.yasser','fashion')

INSERT INTO Wishlist_Product(username ,wish_name,serial_no) VALUES('ammar.yasser','fashion',2)
INSERT INTO Wishlist_Product(username ,wish_name,serial_no) VALUES('ammar.yasser','fashion',3)

INSERT INTO Customer_CreditCard(customer_name,cc_number) VALUES('ammar.yasser', '4444-5555-6666-8888')
------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------Viewing---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM Users;
SELECT * FROM Admins;
SELECT * FROM Customer;
SELECT * FROM CustomerAddstoCartProduct;
SELECT * FROM Vendor;
SELECT * FROM Delivery_Person;
SELECT * FROM User_Addresses;
SELECT * FROM User_mobile_numbers;
SELECT * FROM Credit_Card;
SELECT * FROM Delivery;
SELECT * FROM Products;
SELECT * FROM Todays_Deals;
SELECT * FROM offer;
SELECT * FROM Wishlist;
SELECT * FROM Wishlist_Product;
SELECT * FROM Customer_CreditCard;
SELECT * FROM GiftCard;
SELECT * FROM Orders;
SELECT * FROM Todays_Deals_Products;
SELECT * FROM offersOnProduct;
SELECT * FROM Customer_Question_Product;
SELECT * FROM Admin_Customer_Giftcard;
SELECT * FROM Admin_Delivery_Order;
------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------Execution Procedures-------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

Exec showWishlistProduct 'ammar.yasser','fashion'
Exec viewMyCart 'ammar.yasser'









------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------Extras--------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
drop Proc showWishlistProduct;
Drop Table Delivery;
Delete From Products;
Delete From Wishlist_Product;
