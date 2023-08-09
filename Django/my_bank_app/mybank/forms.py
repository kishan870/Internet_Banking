from django import forms
from .models import *

#This file is used to create form data

class RegistrationForm(forms.ModelForm):
    userID = forms.IntegerField()
    token = forms.CharField(max_length=255)

    class Meta:
        model = UID
        fields = ['userID']

class LoginForm(forms.ModelForm):
    userID = forms.IntegerField()
    password = forms.CharField(max_length=255, widget=forms.PasswordInput)

    class Meta:
        model = UID
        fields = ['userID']
