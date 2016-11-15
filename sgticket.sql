CREATE SCHEMA sgticket;
USE sgticket;

CREATE TABLE member (
	memberId INT(11) NOT NULL AUTO_INCREMENT,
	userName VARCHAR(32) NOT NULL,
	firstName VARCHAR(32),
	lastName VARCHAR(32), 
	dob Date,
	gender CHAR(2),
	mobileNumber VARCHAR(32) NOT NULL,
    userPassword VARCHAR(32) NOT NULL,
    ebalance DECIMAL(6,2),
    email VARCHAR(32),
	subscribe TINYINT(1), 
    securityQuestion VARCHAR(100),
    securityAnswer VARCHAR(100),
	profilePhoto VARCHAR(100) DEFAULT NULL,
	activities VARCHAR (100) DEFAULT NULL,
	PRIMARY KEY (memberId),
	UNIQUE(userName)	
) ENGINE INNODB;

CREATE TABLE creditCard (
	cardId CHAR(16) NOT NULL,
	name VARCHAR(32),
	cvv CHAR(3),
	expiryMonth CHAR(2),
	expiryYear CHAR(4),
	cardType VARCHAR(32),
	memberId INT(11) NOT NULL,
	PRIMARY KEY (cardId),
	FOREIGN KEY (memberId)
		references member
		(memberId)
		on update cascade
		on delete cascade
) ENGINE INNODB;

CREATE TABLE attraction (
	attractionId INT(5) NOT NULL AUTO_INCREMENT,
	attractionName VARCHAR(32),
	overView VARCHAR(7000),
	detail VARCHAR(3000),
	recommendDineIn VARCHAR(1500),
	PRIMARY KEY (attractionId),
	unique (attractionName)
) ENGINE INNODB;

CREATE TABLE ticket (
	ticketId INT(11) NOT NULL AUTO_INCREMENT,
	buyingPrice DECIMAL(5,2),
	sellingPrice DECIMAL(5,2),
	categoty VARCHAR(10),
	ticketDesc VARCHAR(200) DEFAULT NULL,
	qrCode VARCHAR(100),
	attractionId INT(5) NOT NULL,
	PRIMARY KEY (ticketId),
    FOREIGN KEY (attractionId)
		references attraction
		(attractionId)
		on update cascade
		on delete restrict
		
) ENGINE INNODB;

CREATE TABLE review (
	reviewId INT(11) NOT NULL AUTO_INCREMENT,
	memberId INT(11) NOT NULL,
	attractionId INT(5) NOT NULL,
	postTime Time,
	postDate Date,
	rating Decimal(2,1),
	comments VARCHAR(1500),
	PRIMARY KEY (reviewId),
	FOREIGN KEY (memberId)
		references member
		(memberId)
		on update cascade
		on delete cascade,
	Foreign	Key (attractionId)
		references attraction
		(attractionId)
		on update cascade
		on delete cascade
) ENGINE INNODB;

CREATE TABLE purchaseStatus (
	psId INT(11) NOT NULL AUTO_INCREMENT,
	psDesc VARCHAR (100),
	PRIMARY KEY (psId)
) ENGINE INNODB;

CREATE TABLE purchaseOrder (
	poId INT(11) NOT NULL AUTO_INCREMENT,
	memberId INT(11) NOT NULL,
	psId INT(11) NOT NULL,
	quantity INT(3), 
	/*unitPrice DECIMAL(5,2),*/
	amount DECIMAL(7,2),
	poDateTime datetime,
	discountpercent varchar(5),
	PRIMARY KEY (poId),
	FOREIGN KEY (memberId)
		references member
		(memberId)
		on update cascade
		on delete cascade,
	FOREIGN KEY (psId)
		references purchaseStatus
		(psId)
		on update cascade
		on delete cascade			
) ENGINE INNODB;

create table purchaseItem(
	piId INT(11) Not Null AUTO_INCREMENT,
	poId INT(11) NOT NULL,
    ticketId INT(11) NOT NULL,
    primary key (piId),
	Foreign key (poId) 
		references purchaseOrder
		(poId)
		on update cascade
		on delete cascade,
	Foreign	Key (ticketId)
		references ticket
		(ticketId)
		on update cascade
		on delete cascade
) ENGINE INNODB;


/*
Sequence for create database 
1) Member
2) Credit card 
3) Attraction
4) Ticket
5) Review
6) PurchaseStatus
7) PurchaseOrder
8) PurchaseItem 
*/

INSERT INTO member(userName, firstName, lastName, dob, gender, mobileNumber, userPassword, ebalance, email, subscribe, securityQuestion, 
securityAnswer, profilePhoto, activities)
	values('Alvin Lim','Alvin','Lim','1993-01-24','M','+65 87654321','Password','100','alvinlim@hotmail.com','1','What is my dog name?','John','NULL','NULL'),
		  ('Tan Wee Kek','Wee Kek','Tan','1980-02-23','M','+65 82345678','pw1234','200','twk@hotmail.com','0','What is my occupation?','NUS Teacher',' C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\pp1.png','MOnday 01-01-2016 GARDENS BY THE BAY'),
		  ('Yu Zong Dong','Zong Dong','Yu','1993-03-22','M','+65 98765432','Pass1234','90','yzd@hotmail.com','1','What is my cat name?','Tom','NULL','NULL'),
		  ('Tan Qing Yang','Qing Yang','Tan','1994-04-23','M','+65 91234567','passwords','100','tqy@hotmail.com','0','What is my pet name?','Tim','NULL','NULL'),
		  ('Ang Zhen Xuan','Zhen Xuan','Ang','1994-05-23','M','+65 98123456','pw4321','100','azx@hotmail.com','1','What is my mouse name?','Jerry','NULL','NULL');


INSERT INTO creditCard
    VALUES ('0987654321234567','Alvin Lim','998','08','2019','DBS CreditCard','1'),
		   ('1234567890123456','Tan Wee Kek','999','09','2020','OCBC DebitCard','2'),
		   ('1029384756657483','Zong Dong','997','07','2018','UOB CreditCard','3'),
		   ('5647382910019283','Qing Yang','996','06','2020','HSBC CreditCard','4'),
		   ('1987654321234567','Zhen Xuan','995','05','2019','Standard Chartered CreditCard','5');


	
Insert INTO attraction(attractionName, overView, detail, recommendDineIn)
	VALUES('Universal Studios Singapore','Go beyond the screen and Ride The Movies® at Universal Studios Singapore®. Experience cutting-edge rides, shows, and attractions based on your favourite blockbuster films and television series, including Puss In Boots’ Giant Journey, Battlestar Galactica: HUMAN vs. CYLON™, 
			 TRANSFORMERS The Ride: The Ultimate 3D Battle, Jurassic Park Rapids Adventure™, Sesame Street Spaghetti Space Chase and more! Immerse Yourself in Seven Zones Enter the thrilling world of movie magic as you Ride the Movies on roller coasters and other movie-themed attractions. Be dazzled and delighted by an immersive entertainment experience that brings the silver screen to life.
			 Hollywood Dreams Parade™ Be amazed as the Hollywood Dreams Parade™ brings to life your favourite blockbuster movies and beloved characters on magnificent floats that go beyond your imagination, only at Universal Studios Singapore.
			 Lake Hollywood Spectacular® An incredible fireworks show set to a brilliant musical score that will burst across the night sky right in front of you!', 
			 'Operating Hours 10AM to 8PM Address Resorts World Sentosa 8 Sentosa Gateway, Sentosa Island Singapore 098269 Route to Universal Studios Singapore 
			 1. Proceed to level 1 of VivoCity and look for directions to the Boardwalk. 
			 2. Upon reaching the entrance of Sentosa island, head towards Trick Eye Museum. 
			 3. Keep left and walk till you see the Universal Studios Globe.','Chicken Rice Combo Where: Discovery Food Court, Lost World Price: $11.50 Don’t be fooled by its price, 
			 this combo consists of the works: roasted or Hainanese chicken rice accompanied by achar, vegetable of the day and even dessert. For us the star of this dish is the rice; 
			 not too cloying or oily and strikes the right balance with its fragrance and softness. The achar packs a punch too, whetting our appetite with the crunchy cucumber and uniquely Asian flavour.
			 Plus, we bet you can’t find a T-Rex looming over you at any other food court.'),
		  ('Gardens By The Bay','Gardens by the Bay brings to life the National Parks Board Singapore s vision of creating a City in a Garden. 
			 The Gardens captures the essence of Singapore as the premier tropical Garden City with the perfect environment in which to live and work - making Singapore a leading global city of the 21st century.
			 Outdoor Gardens Outdoor Gardens consist of Bay East Garden, SuperTree Grove, Sun Pavillion, Heritage Gardens, World of Plants and Dragonfly & Kingfisher Lakes. Step into a picturesque world where 
			 beautiful pavilions, lush wide-open lawns and elegant palm trees await. With glorious views of the Marina Bay skyline, Bay East Garden offers scenic tranquility in the city. Free admission
			 Far East Organization Children s Garden Have a fun-filled family day with interactive play delights, water play features and educational programmes in a lush natural setting at the Far East Organization Children’s Garden.
			 Free admission Conservatories Step into the Flower Dome and stand in awe. Spectacular and innovative, it is the largest glass greenhouse in the world as listed in the 2015 Guinness World Records! Be amazed by changing display of flowers and plants from the Mediterranean and semi-arid regions.
			 Enter the Cloud Forest, a mysterious world veiled in mist. Take in breath-taking mountain views surrounded by diverse vegetation and hidden floral gems. And learn about rare plants and their fast-disappearing environment. OCBC Skyway
			 There’s nothing quite like a stroll along the OCBC Skyway. At a height of 22 metres and surrounded by panoramic vistas of the Gardens and Marina Bay skyline, this 128-metre-long aerial walkway is an experience not to be missed.',
			 'Operating Hours Outdoor Gardens: 5am to 2am (Daily) Far East Organization Childrens Garden: 10am to 7pm (Weekdays), 9am to 9pm (Weekends & Public Holidays) Address 18 Marina Gardens Drive Singapore 018953
			 Route to Gardens by the Bay 1. Follow the footpath which leads under the East Coast Parkway (ECP), which will bring you directly into Bay South Garden along the waterfront. 
			 2. Walk across the overhead bridge (Lions Bridge) located at Marina Bay Sands Hotel (open daily from 8.00am to 11.00pm), or take the underground linkway via Bayfront MRT Station (Exit B).',
			 'SATAY BY THE BAY Bond with friends and family over local delights, while enjoying the views of the waterfront at Satay by the Bay. Details Drinks stall : 24 hours Food Stalls open from 11am to 10pm daily
			 Noodles Stall : 12pm to 10pm (Close on Mon) Wholly Crab : 2pm to 10pm (Close at 11pm on Fri, Sat & eve of PH) Prata Stall 24 hrs (Except for Mon 9am to Tues 9pm) ');	
	
	
INSERT INTO ticket(buyingPrice, sellingPrice, categoty, ticketDesc, qrCode, attractionId)
	VALUES('65','74','Adult','NULL','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\ussqrcode',' 1'),
		  ('65','74','Adult','NULL','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\ussqrcode',' 1'),
		  ('20','28','Adult','Two - Conservatories','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\gbtbqrcode','2'),
		  ('20','28','Adult','Two - Conservatories','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\gbtbqrcode','2'),
		  ('20','28','Adult','Two - Conservatories','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\gbtbqrcode','2'),
		  ('20','28','Adult','Two - Conservatories','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\gbtbqrcode','2'),
		  ('4.5','5','Adult','OCBC Skyway ','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\ussqrcode','2'),
		  ('4.5','5','Adult','OCBC Skyway ','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\ussqrcode','2'),
		  ('4.5','5','Adult','OCBC Skyway ','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\ussqrcode','2'),
		  ('4.5','5','Adult','OCBC Skyway ','C:\Users\YZD\Desktop\SGTICKET WEBSITE\images\home\ussqrcode','2');
		
		
	 
INSERT INTO review(memberId,attractionId,postTime,postDate,rating,comments)
	VALUES('1','1','12:30:00','2016-03-31','4.5','Overall, an awesome experience. 
			Their E-tickets brought a great deal of convenience to my whole family. Definitely going to recommend this to my friends! Cheers!');
	
INSERT INTO purchaseStatus(psDesc)
	VALUES('In Cart'),
		  ('Completed');

INSERT INTO purchaseOrder(memberId, psId, quantity, amount, poDateTime,discountpercent)		  
	VALUES('2','1','2','148','2016-03-27 15:45:00','1.00%'),	
		  ('2','1','4','112','2016-03-27 15:50:00','1.00%'),
		  ('2','2','4','20','2016-03-28 12:30:00','1.00%');
		  	
INSERT INTO purchaseItem(poId,ticketId)
	values ('1','1'),
		   ('1','2'),
		   ('2','3'),
		   ('2','4'),
		   ('2','5'),
		   ('2','6'),
		   ('3','7'),
		   ('3','8'),
		   ('3','9'),
		   ('3','10');

