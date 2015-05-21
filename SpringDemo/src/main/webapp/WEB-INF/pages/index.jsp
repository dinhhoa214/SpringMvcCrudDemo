
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Spring MVC Demo</title>

<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
<script type="text/javascript"
	src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		$('#myTable').dataTable();
	});
</script>
</head>
<body>
	<center>
	<h1>Account List | Bootstrap Paging</h1>
	<div class="table-responsive">
		<table id="myTable" class="table table-striped table-bordered"
			width="100%" cellspacing="0">
			<thead>
				<tr>
					<th>User Id</th>
					<th>Name</th>
					<th>Time</th>
					<th>Status</th>
					<th>Is Public</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="acc" items="${map.Accounts}">
					<tr>
						<td>${acc.id}</td>
						<td>${acc.name}</td>
						<td>${acc.time}</td>
						<td>${acc.status}</td>
						<td>${acc.isPublic}</td>
						<td><a href="edit?id=${acc.id}">Edit</a></td>
						<td><a href="delete?id=${acc.id}">Delete</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	 <div class="row">
  <div class="col-sm-4"> 
  		<a href="register" class="btn btn-info" >Add new Account</a>
  		</div>
  <div class="col-sm-4">
  	<form:form method="post" action="/SpringDemo/saveAccount"
		modelAttribute="account">
		<table>
			<tr>
				<td>ID :</td>
				<td><form:input path="id" value="${map.account.id}"
						readonly="true" /></td>
			</tr>
			<tr>
				<td>First Name :</td>
				<td><form:input path="name" value="${map.account.name}" /></td>
			</tr>
			<tr>
				<td>Time :</td>
				<td><form:input path="time" value="${map.account.time}" /></td>
			</tr>
			<tr>
				<td>Status :</td>
				<td><form:select path="status">
						<form:option value="${map.account.status}" />
						<form:option value="Dang su dung" />
						<form:option value="Tam khoa" />
						<form:option value="Het han" />

					</form:select></td>
			</tr>
			<tr>
				<td>Is public :</td>
				<td><form:input path="isPublic" value="${map.account.isPublic}" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Save" class="btn btn-success"/></td>
			</tr>
		</table>
	</form:form> 
  </div>
  <div class="col-sm-4"><div class="alert alert-success">
  <strong>Console:</strong>   ${map.mess }.
</div>
   </div>
</div>
	
	</center>
</body>
</html>
