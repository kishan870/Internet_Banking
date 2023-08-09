=====================================
Internet Banking Project using Django
=====================================

This project implements internet banking functionalities such as creating a new user, logging in existing user, fund transfer to a different account, viewing account statement using Django Web application framework.

Libraries and frameworks used:

Web:

* HTML
* Javascript
* JQuery

Frontend:

* CSS
* Bootstrap-5

Server and Backend:

* Python-Django (version=4.2.4)
* Jquery-Ajax

Database:

* MySQL

To Run the Project:

* Activate the virtual environment for the Django Project

  - Run ``Django\myproject\Scripts\activate.bat``
  
  
  
* Create banking database in mysql and complete the migrations

Please visit ``Django\my_bank_app\my_bank_app\settings.py`` to view Database settings.

  - Run ``Django\my_bank_app\python manage.py makemigrations mybank``
  
  - Run ``Django\my_bank_app\python manage.py migrate``
  
  
  
* Start Django server:

  - Run ``Django\my_bank_app\python manage.py runserver``
  
  
  
Adding Accounts
===============

Please create and add new accounts to ``mybank_accountdetails`` table to simulate net banking operations.


Register Tokens
===============

Please viisit ``http://.../admin/`` to create registration tokens for new users. New users can sign up only using these tokens.

