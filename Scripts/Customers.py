import mysql.connector
import csv

mydb = mysql.connector.connect(
    host="localhost",
    user="",
    password="",
    database="kuchynka"
)

cursor = mydb.cursor()

add_customers = ("INSERT INTO customers"
                 "(ID, name, surname, sex, address_ID) "
                 "VALUES (%s, %s, %s, %s, %s)")

with open('C:/Users/####/####/Customers_data.csv', 'r') as cus_file:
    data = csv.reader(cus_file)
    next(data)

    for row in data:
        row = tuple(None if value == '' else value for value in row)
        cursor.execute(add_customers, row)

        mydb.commit()

cursor.close()
mydb.close()
