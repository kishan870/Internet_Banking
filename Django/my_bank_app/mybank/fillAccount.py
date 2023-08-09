#Fill the database with random account details

import mysql.connector
import random

firstnames = ["Steve","Mathew","Stuart","Lee","Leonard","Aston","Nord","Bradd","Lina","Robert","Jack","John"]
lastnames = ["Bennet","Cooper","Broad","Softer","Long","Debby","Santos","Jolly","Smith","Label","Hunter","Bober"]

address = "To be Updated"

accountnum = 14382

try:
    mydb = mysql.connector.connect(
        host="localhost",
        port=3306,
        user="root",
        password="root",
        database="banking"
    )

    cursor = mydb.cursor()

    for i in range(0,len(firstnames)):

        account = accountnum + i
        firstname = firstnames[i]
        lastname = lastnames[i]
        email = firstname+"."+lastname[:3]+"@hotmail.com"

        #Adding Account details
        query = "INSERT INTO mybank_accountdetails(AccountNumber,firstname,lastname,address,email) VALUES (%s,%s,%s,%s,%s)"
        val = (str(account),firstname,lastname,address,email)

        cursor.execute(query,val)

        #Associate UserID with each account number
        uid = (account/99) + (account%99) + 555
        query = "INSERT INTO mybank_uid(userID,AccountNumber_id) VALUES (%s,%s)"
        val = (str(uid),str(account))

        cursor.execute(query,val)

        #Add random balance
        x = random.randrange(1,9)
        y = random.randrange(100,999)

        balance = x*1000 + y
        query = "INSERT INTO mybank_balance(balance,AccountNumber_id) VALUES (%s,%s)"
        val = (balance,account)

        cursor.execute(query,val)

    mydb.commit()



except Exception as e:
    print(e)
