USE  kuchynka;

CREATE TABLE Branch (
  Branch_ID INT PRIMARY KEY AUTO_INCREMENT,
  city VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  description_nmb INT NOT NULL,
  zip_code CHAR(5) NOT NULL
);

CREATE TABLE Category (
  Category_ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Branch_category (
  branch_ID INT  PRIMARY KEY ,
  category_ID INT  PRIMARY KEY

);

CREATE TABLE Products (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL ,
  material VARCHAR(255) NOT NULL ,
  height INT,
  width INT,
  diameter INT,
  volume INT,
  dishwasher_safe BOOL,
  price INT NOT NULL ,
  in_stock BOOL NOT NULL ,
  category_ID INT NOT NULL
);

CREATE TABLE Customer_rating (
  Customer_ID INT AUTO_INCREMENT,
  Branch_ID INT ,
  Rating INT CHECK ( Rating >= 1 AND Rating <= 5),
  PRIMARY KEY (Customer_ID, Branch_ID)
);

CREATE TABLE Customers (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL ,
  surname VARCHAR(255) NOT NULL ,
  sex ENUM('F','M','O'),
  address_ID INT NOT NULL
);

CREATE TABLE Orders (
  order_ID INT PRIMARY KEY AUTO_INCREMENT,
  date DATETIME NOT NULL ,
  done DATETIME NOT NULL ,
  processed BOOL NOT NULL ,
  canceled DATETIME
);

CREATE TABLE Order_Product (
  order_ID INT,
  product_ID INT,
  nmb INT NOT NULL ,
  PRIMARY KEY (order_ID, product_ID)
);

CREATE TABLE Address (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  city VARCHAR(255) NOT NULL ,
  street VARCHAR(255) NOT NULL ,
  number INT NOT NULL ,
  zip_code INT NOT NULL
);



