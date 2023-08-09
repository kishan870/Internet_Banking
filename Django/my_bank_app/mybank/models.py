from django.db import models

# Create your models here.

class AccountDetails(models.Model):
    AccountNumber = models.IntegerField(primary_key=True)
    firstname = models.CharField(max_length=255)
    lastname = models.CharField(max_length=255)
    address = models.CharField(max_length=1048)
    email = models.EmailField(max_length=254, null=True)

class UID(models.Model):
    userID = models.IntegerField(primary_key=True)
    AccountNumber = models.ForeignKey(AccountDetails, to_field='AccountNumber', on_delete = models.CASCADE)

class Balance(models.Model):
    AccountNumber = models.ForeignKey(AccountDetails, to_field='AccountNumber', on_delete = models.CASCADE)
    balance = models.IntegerField()

class Tokens(models.Model):
    userID = models.ForeignKey(UID, to_field='userID', on_delete = models.CASCADE)
    token = models.CharField(max_length = 255)

class Authentication(models.Model):
    userID = models.ForeignKey(UID, to_field='userID', on_delete = models.CASCADE)
    password = models.CharField(max_length=128)

class Transaction(models.Model):
    ReferenceNum = models.CharField(max_length=255, primary_key=True)
    sender = models.ForeignKey(AccountDetails, to_field='AccountNumber', related_name="account_sender", on_delete = models.PROTECT)
    reciever = models.ForeignKey(AccountDetails, to_field='AccountNumber', related_name="account_reciever", on_delete = models.PROTECT)
    timestamp = models.DateTimeField(auto_now_add=True)
    transactionAmount = models.IntegerField(default=0)
    senderBalance = models.IntegerField()
    recieverBalance = models.IntegerField()

class AuthenticateTransaction(models.Model):
    userID = models.ForeignKey(UID, to_field='userID', on_delete = models.CASCADE)
    trans_password = models.CharField(max_length=128)

class PasswordReset(models.Model):
    userID = models.ForeignKey(UID, to_field='userID', on_delete = models.CASCADE)
    resetToken = models.CharField(max_length = 255)
