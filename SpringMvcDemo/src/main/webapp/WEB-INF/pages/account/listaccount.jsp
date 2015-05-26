
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Spring MVC Demo</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" /> 
<link href="${pageContext.request.contextPath}/resources/css/bootstrapValidator.css" rel="stylesheet" /> 
<script src="${pageContext.request.contextPath}/resources/jquery/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/jquery/bootstrapValidator.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script>
$( "#dialog" ).dialog({ autoOpen: false });
 
function doAjaxPostDelete(id){
	var idNo = id;
	var page = ${numOfPage}; 
	$( "#dialog" ).dialog( "open" );
	$.ajax({
		  type: "POST",
		  url: "delete",
		  data: "id1="+idNo + "&record=" + page, 
		  success: function(response){   
			  alert(response ); 
			  
 		  }, 
 		  error: function(e){ 
 				alert('Error: ' + e); 
 		  } 
	}); 
} 
			  	        </script>
</head>
<body>
	<div class="container">
		<div class="row">
			<center>
				<h1>Account List | Bootstrap Paging</h1>
			</center>
		</div>

		<div class="row">
			<div class="col-sm-4">
				<div class="form-group">
					<label>Total: ${numCountRows} records. </label>
				</div>
			</div>
			<div class="col-sm-4">
				<center>
					<ul class="pagination pagination-sm">
						<c:forEach var="i" begin="1" end="${numPages }">
							<c:choose>
								<c:when test="${numOfPage eq  i}">
									<li class="active"><a href="getList?record=${ i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="getList?record=${ i}">${i}</a></li>
								</c:otherwise>
							</c:choose>


						</c:forEach>
					</ul>
				</center>
			</div>
			<div class="col-sm-4">
				<div class="col-sm-4"></div>
				<div class="input-group">
					<p class="text-right">
						<input type="text" class="form-control"> <span
							class="input-group-btn">
							<button class="btn btn-default" type="button">Go!</button>
						</span>
					</p>
				</div>
				<!-- /input-group -->


			</div>
		</div>

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
					<c:forEach var="acc" items="${Accounts}">
						<tr>
							<td>${acc.id}</td>
							<td>${acc.name}</td>
							<td>${acc.time}</td>
							<td>${acc.status}</td>
							<td>${acc.isPublic}</td>
							<td><a href="edit?id=${acc.id}&record=${numOfPage}">Edit
							</a></td>
							<td><a href="delete?id=${acc.id}&record=${numOfPage}">Delete</a>

								<button class="btn btn-default" onclick="doAjaxPostDelete(${acc.id})">
									Delete</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<a href="getList?record=${numPages }" class="btn btn-info">Add
					new Account</a>
			</div>
			<div class="col-sm-4">
				<form:form  method="POST" action="saveAccount?record=${numOfPage}" modelAttribute="account"> 
		 		
				<table class="table table-condensed">
     
     
      <tr>
        <td>ID:</td>
        <td><form:input path="id" id="idInput" /></td> 
      </tr>
      <tr>
        <td>Name:</td>
        <td><form:input path="name" id="nameInput" /></td> 
      </tr>
      <tr>
        <td>Modifer Time:</td>
        <td><form:input path="time" id="timeInput" /></td> 
      </tr>
      <tr>
        <td>Status:</td>
        <td><form:select path="status" id="satusOptions">
							<form:option value="">Select Status</form:option>
							<form:option value="Dang su dung">Dang su dung</form:option>
							<form:option value="Tam khoa">Tam khoa</form:option>
							<form:option value="Het han">Het han</form:option>
						</form:select>
						</td> 
      </tr>
      <tr>
        <td>Public:</td>
        <td>
        <form:radiobutton path="isPublic" value="true" />true
        <form:radiobutton path="isPublic" value="false" />false  
						</td> 
      </tr>
      <tr><td><input type="submit" value="Save" class="btn btn-success"/></td></tr>
      </table>
       
				   
						
		</form:form>
			</div>
			<div class="col-sm-4">
				<div class="alert alert-success">
					<strong>Console:</strong> message.
				<div id="dialog" title="Dialog Title">I'm a dialog</div>


				</div>
			</div>
		</div>

	</div>
</body>
</html>
