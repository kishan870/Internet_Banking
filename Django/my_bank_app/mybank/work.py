import hashlib
from .models import *
from datetime import datetime,timedelta

def passwordValidate(password):
    if len(password) <8:
        return False
    if not any(chr.isdigit() for chr in password):
        return False
    if not any(chr.isupper() for chr in password):
        return False
    return True

def init_session(request):
    request.session['invalid_token'] = "False"
    request.session['userID_exists'] = "False"
    request.session['password_req_failed'] = "False"
    request.session['password_mismatch'] = "False"
    request.session['redirect'] = "False"
    request.session['refresh'] = "False"

def getPasswordHash(password):
    sha256 = str(hashlib.sha256(password.encode("utf-8")).hexdigest())
    return sha256

def transactMoney(sender,reciever,receiever_name,amount,password):
    try:
        enteredName = receiever_name.replace(" ","").upper()
        if not AccountDetails.objects.filter(AccountNumber=sender).exists():
            return {'response':'no sender'}
        if not AccountDetails.objects.filter(AccountNumber=reciever).exists():
            return {'response':'no receiever'}

        senderAcc = AccountDetails.objects.get(AccountNumber=sender)
        receieverAcc = AccountDetails.objects.get(AccountNumber=reciever)
        receieverName = (receieverAcc.firstname + receieverAcc.lastname).upper()

        if enteredName != receieverName:
            return {'response':'no name'}

        senderInstance = Balance.objects.get(AccountNumber=senderAcc)
        recieverInstance = Balance.objects.get(AccountNumber=receieverAcc)

        senderBalance = senderInstance.balance
        receieverBalance = recieverInstance.balance

        sender_userID_obj = UID.objects.get(AccountNumber=senderAcc)
        transPassword = Authentication.objects.get(userID=sender_userID_obj).password

        if getPasswordHash(password) != transPassword:
            return {'response':'incorrect password'}

        if senderBalance < amount:
            return {'response':'no balance'}

        senderBalance = senderBalance - amount
        receieverBalance = receieverBalance + amount

        timestamp = datetime.now()
        timeStr = timestamp.strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]

        hashInput = str(sender) + str(reciever) + str(amount) + timeStr
        referenceID = getPasswordHash(hashInput).upper()[:12]

        auth = Transaction(ReferenceNum=referenceID, sender=senderAcc, reciever=receieverAcc, timestamp=timestamp, transactionAmount=amount, senderBalance=senderBalance, recieverBalance=receieverBalance)
        auth.save()

        senderInstance.balance = senderBalance
        recieverInstance.balance = receieverBalance

        senderInstance.save()
        recieverInstance.save()

        return {'response':'success','balance':senderBalance}

    except Exception as e:
        print(e)
        return {'response':'error'}

def getTransactionData(accountno,choice,fromDate,toDate):
    try:
        accountno = int(accountno)
        if not AccountDetails.objects.filter(AccountNumber=accountno).exists():
            return {'response':'no account'}

        if choice == "lastMonth":
            toDate = datetime.now()
            fromDate = toDate - timedelta(days=30)

        elif choice == "customRange":
            fromDate = datetime.strptime(fromDate,'%Y-%m-%d')
            toDate = datetime.strptime(toDate,'%Y-%m-%d')

        accountObj = AccountDetails.objects.get(AccountNumber=accountno)

        transactions = []
        transactions.extend(Transaction.objects.filter(sender=accountObj).values())
        transactions.extend(Transaction.objects.filter(reciever=accountObj).values())

        sorted_transactions = sorted(transactions, key=lambda x: x['timestamp'])
        transactionsData = []

        for x in sorted_transactions:
            item = {}
            item['Date'] = str(x['timestamp'])
            item['referenceID'] = x['ReferenceNum']
            if accountno == x['sender_id']:
                item['Debit'] = x['transactionAmount']
                item['Credit'] = ""
                item['Description'] = "To: " + str(x['reciever_id'])
                item['Balance'] = x['senderBalance']
            else:
                item['Credit'] = x['transactionAmount']
                item['Debit'] = ""
                item['Description'] = "From: " + str(x['reciever_id'])
                item['Balance'] = x['recieverBalance']

            transactionsData.append(item)

        return {'response':'success','Data':transactionsData}
    except Exception as e:
        print(e)
        return {'response':'error'}
