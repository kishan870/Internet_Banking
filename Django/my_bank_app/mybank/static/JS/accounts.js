$(document).ready(function(){
  $("#insufBalance").hide();
  $("#transactionSuccess").hide();
  $(".validate").hide();
  $(".message").hide();
  $("#confAccNum").prop('disabled',true);
  $("#accountSelected").prop("checked",false);
  $("#accTable").hide();
  $("#datePicker").hide();
});

$("#accNum").keyup(function(e) {
  var val = $("#accNum").val();
  if(val == "") {
    $("#confAccNum").val('');
    $("#confAccNum").prop('disabled',true);
  }
  else {
    $("#confAccNum").prop('disabled',false);
  }
});

$("#transferFund").click(function() {
    var accNum = $("#accNum").val();
    var confAccNum = $("#confAccNum").val();
    var accName = $("#accName").val();
    var transferAmount = $("#transferAmount").val();

    if(accNum == "") {
      $("#accNumValidate").show();
      return false;
    }

    if(confAccNum == "") {
      $("#confaccNumValidate").show();
      return false;
    }

    if(accName == "") {
      $("#accNumValidate").show();
      return false;
    }

    if(transferAmount == "") {
      $("#amountValidate").show();
      return false;
    }

    if(parseInt(transferAmount) <=0) {
      $("#zeroAmount").show();
      return false;
    }

    if($("input:radio[name='radioCheck0']").is(":checked") == false) {
      $("#accCheckValidate").show();
      return false;
    }

    if(accNum != confAccNum) {
      $("#mismatchAccNum").show();
      return false;
    }

    var senderAcc = parseInt($("#accountSelected").val());
    console.log("SENDER")
    console.log(senderAcc);
    if(accNum == senderAcc) {
      $("#sameAccount").show();
      return false;
    }

    $(".validate").hide();
    $("#myModal1").modal('show');
    return true;

});

//This will intiate transaction at the server
$("#authenticate").click(function() {

  var transPassword = $("#transPassword").val();

  if(transPassword == "") {
    $("#transPasswdValidate").show();
    return false;
  }

  var senderAcc = parseInt($("#accountSelected").val());
  var receieverAcc = $("#accNum").val();
  var confreceieverAcc = $("#confAccNum").val();
  var senderName = $("#accName").val();
  var amount = $("#transferAmount").val();

  const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

  $.ajax({
    url : 'transferAmount/',
    method : 'POST',
    data : {
      'csrfmiddlewaretoken': csrftoken,
      'sender' : senderAcc,
      'reciever' : receieverAcc,
      'confirmReciever' : confreceieverAcc,
      'name' : senderName,
      'amount' : amount,
      'password':transPassword
    },
    success:function(response) {

      if(response['response'] == 'success') {
        balance = response['balance'];
        $("#transactionSuccess").show();
        $("#accountBalance").text("Balance : $"+balance);
      }

      else if(response['response'] == 'no balance') {
        $("#insufBalance").show();
      }

      else if(response['response'] == 'incorrect password') {
        $("#incorrectTransPassword").show();
      }

      else if(response['response'] == 'no receiever') {
        $("#invalidAccount").show();
      }

      else if(response['response'] == 'no name') {
        $("#invalidName").show();
      }

      else if(response['response'] == 'login again') {
        $("#invalidSession").show();
      }

      else {
        $("#serverError").show();
      }
    },
    error: function(error) {
      $("#serverError").show();
      console.log(error);
    }
  });
});

function closeModal() {
  $("#insufBalance").hide();
  $(".validate").hide();
  $('.form-control').each(function() {
    this.value = "";
  });
  $("#confAccNum").prop('disabled',true);
  $("#accountSelected").prop("checked",false);
  $(".message").hide();
}

$(".btn btn-danger").click(function() {
  closeModal();
});

$('#myModal').on('hidden.bs.modal', function () {
  closeModal();
});

//This will direct to setting new password or changing old password
$("#next").click(function() {

  $(".validate").hide();

  if($("input:radio[name='radioCheck1']").is(":checked") == false) {
    $("#accCheckValidate1").show();
    return false;
  }

  $("#accCheckValidate1").hide();
  $("#myModal2").modal('hide');

  const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;
  var accNum = parseInt($("#accountSelectedPass").val());

  $.ajax({
    url : 'transactPassword/',
    method : 'POST',
    data : {
      'csrfmiddlewaretoken': csrftoken,
      'account' : accNum,
    },
    success : function(response) {
      console.log(response['response']);
      if(response['response'] == 'login again') {
        $("#invalidSessionPassword").show();
      }
      else {
      if(response["response"] == "PasswordNotExists") {
        $("#currPasswordDisplay").hide();
      }
      else {
        $("#currPasswordDisplay").show();
      }
      if(response['response'] == 'server error') {
        $("#serverError").show();
        return false;
      }}
    },
    error : function(error) {
      console.log(error);
      alert("Error");
    }
  });

  $("#myModal3").modal('show');
  return true;
});

$("#submitPassword").click(function() {

    $(".validate").hide();

    var currPassword = $("#currPassword").val();
    var newPassword = $("#newPassword").val();
    var confNewPassword = $("#newPasswordConfirm").val();

    if(newPassword == "") {
      $("#newPasswordValidate").show();
      return false;
    }

    if(confNewPassword == "") {
      $("#newPasswordConfirmValidate").show();
      return false;
    }

    if($("#currPasswordDisplay").is(":visible")) {
      if(currPassword == "") {
        $("#currPasswordValidate").show();
        return false;
      }
    }

    else {
      currPassword = "default";
    }

    if(newPassword != confNewPassword) {
      $("#mismatchPassword").show();
      return false;
    }

    var account = parseInt($("#accountSelectedPass").val());
    const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

    $.ajax({
      url : 'transactPassword/',
      method : 'POST',
      data : {
        'csrfmiddlewaretoken': csrftoken,
        'account' : account,
        'password' : newPassword,
        'confNewPassword':confNewPassword,
        'currPassword':currPassword
      },
      success: function(response) {
        console.log(response);
        if(response['response'] == 'login again') {
          $("#invalidSessionPassword").show();
          return false;
        }
        if(response['response'] == 'validate') {
          $("#passwordRequirement").show();
          return false;
        }
        if(response['response'] == "invalid password") {
          $("#incorrectPassword").show();
          return false;
        }
        if(response['response'] == 'success') {
          $("#passwordChangeSuccess").show();
        }
        else {
          $("#serverError").show();
        }
        return true;
      },
      error: function(error) {
        console.log(error);
        alert("Error");
      }
    });
  });


  $("input:radio[name='radioDateCheck']").click(function(){
      var checkedVal = $('input[name="radioDateCheck"]:checked').val();
      if(checkedVal == "lastMonth") {
        $("#datePicker").hide();
      }
      if(checkedVal == "customRange") {
        $("#datePicker").show();
      }
  });


  $("#submitRange").click(function() {

    if($("input:radio[name='radioCheck2']").is(":checked") == false) {
      $("#accStatementCheckValidate").show();
      return false;
    }

    const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;
    var account = parseInt($("#accountStatementSelected").val());
    var choice = $('input[name="radioDateCheck"]:checked').val();
    var fromDate = "";
    var toDate = "";

    if(choice == "customRange") {
      fromDate = $("#fromDate").val();
      toDate = $("#toDate").val();
    }

    $.ajax({
      url: 'getAccStatement/',
      method: 'POST',
      data: {
        'csrfmiddlewaretoken': csrftoken,
        'account':account,
        'choice':choice,
        'fromDate':fromDate,
        'toDate':toDate
      },
      success: function(response) {
        if(response['response'] == 'success') {
          response_data = response['Data'];
          $.each(response_data, function(i, item) {

            var trHTML = '';
            trHTML += '<tr class="table-info"><td>' + item['Date'] + '</td><td>' + item['referenceID'] + '</td><td>' + item['Description'] + '</td><td>' + item['Credit'];
            trHTML += '</td><td>' + item['Debit'] + '</td><td>' + item['Balance'] + '</td></tr>';
            $("#accStatementTable").append(trHTML);
          });

          $("#accDetails").hide();
          $("#accTable").show();
          $("#myModal4").modal('hide');
          return true;
        }

        else if(response['response'] == 'login again') {
          $("#invalidSessionAccStatement").show();
          return false;
        }

        else {
          $("#serverErrorAccStatement").show();
          return false;
        }
      },
      error: function(error) {
        console.log(error);
        $("#serverErrorAccStatement").show();
        return false;
      }

    });

  });

$("#accsummary").click(function() {
  $("#accDetails").show();
  $("#accTable").hide();
});
