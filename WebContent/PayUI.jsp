

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<jsp:directive.page import="com.Payment" />
<html>
<head>
<meta charset="ISO-8859-1">
<title>HEALTHCARE SYSTEM-PAYMENT</title>
<link rel="stylesheet" href="Views/bootstrap.min.css">
<script src="Components/jquery-3.2.1.min.js"></script>
<script src="Components/main.js"></script>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-6">
				<h1>PAYMENT</h1>
				<form id="formPayment" name="formPayment">
					Patient ID: <input id="patientID" name="patientID" type="text"
						class="form-control form-control-sm"> <br>Doctor ID:
					<input id="docID" name="docID" type="text"
						class="form-control form-control-sm"> <br> Card No: <input
						id="card_no" name="card_no" type="text"
						class="form-control form-control-sm"> <br> CVV: <input
						id="cvv" name="cvv" type="text"
						class="form-control form-control-sm"> <br> Card Type:
					<input id="card_type" name="card_type" type="text"
						class="form-control form-control-sm"> <br> Expiry
					date: <input id="exp_date" name="exp_date" type="text"
						class="form-control form-control-sm"> <br>Amount : <input
						id="amount" name="amount" type="text"
						class="form-control form-control-sm"> <br> <input
						id="btnSave" name="btnSave" type="button" value="Save"
						class="btn btn-primary"> <input type="hidden"
						id="hidPayIDSave" name="hidPayIDSave" value="">

				</form>
				<div id="alertSuccess" class="alert alert-success"></div>
				<div id="alertError" class="alert alert-danger"></div>
				<br>
				<div id="divPaymentsGrid">
					<%
						Payment payObj = new Payment();
					out.print(payObj.readPayment());
					%>
				</div>

			</div>
		</div>
	</div>

</body>
</html>
