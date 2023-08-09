from django.shortcuts import render, redirect, reverse
from .forms import *
from .models import *
from pprint import pprint
from .work import *
import json

from django.http import JsonResponse,HttpResponse,HttpResponseRedirect
from django.core.exceptions import BadRequest

from django.middleware.csrf import get_token
from django.views.decorators.cache import cache_control, patch_cache_control
from django.contrib.auth import logout

# Create your views here.

def Main(request):
    init_session(request)
    return render(request,'main.html')

def register(request):
    if 'redirect' not in request.session or request.session['redirect'] == "False":
        init_session(request)
    context = {}
    context['invalid_token'] = request.session.get('invalid_token')
    context['userID_exists'] = request.session.get('userID_exists')
    print(context)
    return render(request,"register.html",context)


def signup(request):

    if 'redirect' not in request.session or request.session['redirect'] == "False":
        init_session(request)

    if request.method == "GET":
        if 'signup_fail' not in request.session or request.session['signup_fail'] == "False":
            init_session(request)
            request.session['redirect'] = "True"
            return redirect(register)
        else:
            password_req_failed = request.session['password_req_failed']
            password_mismatch = request.session['password_mismatch']
            request.session['signup_fail'] = "False"
            userID = request.session['UID']
            acc_num = request.session['accountno']
            name = request.session['name']
            return render(request,'signup.html',{'accountno':acc_num,'name':name,'uid':userID,'password_req_failed':password_req_failed,'password_mismatch':password_mismatch})

    init_session(request)
    password_req_failed = request.session['password_req_failed']
    password_mismatch = request.session['password_mismatch']

    userID = request.POST['userID']
    token = request.POST['token']

    if Authentication.objects.filter(userID=userID).exists():
        request.session['userID_exists'] = "True"
        request.session['redirect'] = "True"
        return redirect(register)

    if Tokens.objects.filter(userID=userID).exists():
        init_session(request)
        obj = Tokens.objects.get(userID=userID)
        if token == obj.token:
            userID_obj = UID.objects.get(userID=userID)
            acc_num = userID_obj.AccountNumber.AccountNumber
            acc_obj = AccountDetails.objects.get(AccountNumber=acc_num)
            name = acc_obj.firstname + " " + acc_obj.lastname
            request.session['UID'] = userID
            request.session['accountno'] = acc_num
            request.session['name'] = name
            return render(request,'signup.html',{'accountno':acc_num,'name':name,'uid':userID,'password_req_failed':password_req_failed,'password_mismatch':password_mismatch})
        else:
            init_session(request)
            request.session['invalid_token'] = "True"
            request.session['redirect'] = "True"
            return redirect(register)

    else:
        init_session(request)
        request.session['invalid_token'] = "True"
        request.session['redirect'] = "True"
        return redirect(register)

def signupSuccessful(request):

    init_session(request)

    if request.method == "GET":
        return redirect(register)

    password = request.POST['password']
    re_password = request.POST['re_password']

    if password != re_password:
        request.session['signup_fail'] = "True"
        request.session['password_mismatch'] = "True"
        return redirect(signup)

    if not passwordValidate(password):
        request.session['signup_fail'] = "True"
        request.session['password_req_failed'] = "True"
        return redirect(signup)

    userID = request.session['UID']

    userID_obj = UID.objects.get(userID=userID)
    auth = Authentication(userID=userID_obj, password=getPasswordHash(password))
    auth.save()

    return render(request,'signupSuccess.html')

def login(request):
    context = {}
    if 'redirect' not in request.session or request.session['redirect'] == "False":
        request.session['invalid_login'] = "False"
        init_session(request)

    if 'invalid_login' not in request.session:
        context['invalid_login'] = "False"
    else:
        context['invalid_login'] = request.session['invalid_login']

    init_session(request)
    return render(request,"login.html",context)

def account(request):

    if 'refresh' in request.session and request.session['refresh'] == "True":
        request.session['redirect'] = "True"
        return redirect(login)

    init_session(request)
    request.session['refresh'] = "True"
    request.session['logout'] = "False"

    if request.method == "GET":
        return redirect(login)

    userID = request.POST['userID']
    password = getPasswordHash(request.POST['password'])

    if not UID.objects.filter(userID=userID).exists():
        request.session['invalid_login'] = "True"
        request.session['redirect'] = "True"
        return redirect(login)

    userID_obj = UID.objects.get(userID=userID)

    if not Authentication.objects.filter(userID=userID_obj).exists():
        request.session['invalid_login'] = "True"
        request.session['redirect'] = "True"
        return redirect(login)

    password_stored = Authentication.objects.get(userID=userID_obj).password

    if password != password_stored:
        request.session['invalid_login'] = "True"
        request.session['redirect'] = "True"
        return redirect(login)

    request.session['redirect'] = "False"
    acc_num = userID_obj.AccountNumber.AccountNumber
    acc_obj = AccountDetails.objects.get(AccountNumber=acc_num)
    name = acc_obj.firstname + " " + acc_obj.lastname
    balance = Balance.objects.get(AccountNumber=acc_obj).balance

    return render(request,"account.html",{'name':name,'accountno':acc_num,'balance':balance})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def transferAmount(request):

    if request.method == "GET":
        context = {'status': '400', 'reason': 'Bad Request'}
        response = HttpResponse(json.dumps(context), content_type='application/json')
        response.status_code = 400
        return response

    if request.session['logout'] == "True":
        return JsonResponse({'response':'login again'})

    sender = int(request.POST['sender'])
    reciever = int(request.POST['reciever'])
    confirmReciever = int(request.POST['confirmReciever'])
    name = request.POST['name']
    amount = int(request.POST['amount'])
    transPassword = request.POST['password']

    if amount <=0:
        return JsonResponse({'response':'error'})

    if sender == reciever:
        return JsonResponse({'response':'error'})

    if reciever != confirmReciever:
        return JsonResponse({'response':'error'})

    response = transactMoney(sender, reciever, name, amount, transPassword)

    return JsonResponse(response)


def transactPassword(request):

    if request.method == "GET":
        context = {'status': '400', 'reason': 'Bad Request'}
        response = HttpResponse(json.dumps(context), content_type='application/json')
        response.status_code = 400
        return response

    if request.session['logout'] == "True":
        return JsonResponse({'response':'login again'})

    accountno = int(request.POST['account'])
    response = {'response':'None'}

    try:
        userID = UID.objects.get(AccountNumber=accountno).userID
        passExist = AuthenticateTransaction.objects.filter(userID=userID).exists()

        userID_obj = UID.objects.get(userID=userID)

        #If password is not passed in the request, it just checks if password exists for the account
        if 'password' not in request.POST:

            if passExist:
                response = {'response':'PasswordExists'}
            else:
                response = {'response':'PasswordNotExists'}

        else:
            currPassword = getPasswordHash(request.POST['currPassword'])
            newPassword = request.POST['password']
            confNewPassword = request.POST['confNewPassword']

            if newPassword == "" or confNewPassword == "" or newPassword != confNewPassword:
                return JsonResponse({'response':'server error'})

            if not passwordValidate(newPassword):
                return JsonResponse({'response':'validate'})

            if passExist:
                existPassword = AuthenticateTransaction.objects.get(userID=userID_obj).trans_password
                if currPassword != existPassword:
                    return JsonResponse({'response':'invalid password'})

                auth = AuthenticateTransaction.objects.get(userID=userID_obj)
                auth.trans_password = getPasswordHash(newPassword)

            else:
                auth = AuthenticateTransaction(userID=userID_obj, trans_password=getPasswordHash(newPassword))
            auth.save()
            return JsonResponse({'response':'success'})

    except Exception as e:
        print(e)
        return JsonResponse({'response':'server error'})
    return JsonResponse(response)

def getAccStatement(request):
    if request.method == "GET":
        context = {'status': '400', 'reason': 'Bad Request'}
        response = HttpResponse(json.dumps(context), content_type='application/json')
        response.status_code = 400
        return response

    if request.session['logout'] == "True":
        return JsonResponse({'response':'login again'})

    accountno = request.POST['account']
    choice = request.POST['choice']
    fromDate = request.POST['fromDate']
    toDate = request.POST['toDate']

    response = getTransactionData(accountno,choice,fromDate,toDate)

    return JsonResponse(response)

def logout(request):
    init_session(request)
    request.session['refresh'] = "True"
    request.session['logout'] = "True"
    return render(request,'logout.html')
