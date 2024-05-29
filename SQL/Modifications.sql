CREATE DATABASE kuchynka;
USE kuchynka;


ALTER TABLE `Branch_category` ADD FOREIGN KEY (`branch_ID`) REFERENCES `Branch` (`Branch_ID`);

ALTER TABLE `Branch_category` ADD FOREIGN KEY (`category_ID`) REFERENCES `Category` (`Category_ID`);

ALTER TABLE `Products` ADD FOREIGN KEY (`category_ID`) REFERENCES `Category` (`Category_ID`);

ALTER TABLE `Order_Product` ADD FOREIGN KEY (`product_ID`) REFERENCES `Products` (`ID`);

ALTER TABLE `Order_Product` ADD FOREIGN KEY (`order_ID`) REFERENCES `Orders` (`order_ID`);

ALTER TABLE `Customer_rating` ADD FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`);

ALTER TABLE `Customer_rating` ADD FOREIGN KEY (`Customer_ID`) REFERENCES `Customers` (`ID`);

ALTER TABLE `Address` ADD FOREIGN KEY (`ID`) REFERENCES `Customers` (`ID`);


CREATE TRIGGER delete_canceled_order
AFTER UPDATE
ON Orders
FOR EACH ROW
BEGIN
   IF NEW.canceled IS NOT NULL THEN
      DELETE FROM Orders WHERE order_ID = NEW.order_ID;
   END IF;
END;


