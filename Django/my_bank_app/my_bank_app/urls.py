"""
URL configuration for my_bank_app project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from mybank import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path("",views.Main, name="Main"),
    path("register/",views.register,name="register"),
    path("signup/",views.signup,name="signup"),
    path("signupSuccessful/",views.signupSuccessful,name="signupSuccessful"),
    path("login/",views.login,name="login"),
    path("account/",views.account,name="account"),
    path("account/transferAmount/",views.transferAmount,name="transferAmount"),
    path("account/transactPassword/",views.transactPassword, name="transactPassword"),
    path("account/getAccStatement/",views.getAccStatement,name="getAccStatement"),
    path("logout/",views.logout,name="logout")
]
