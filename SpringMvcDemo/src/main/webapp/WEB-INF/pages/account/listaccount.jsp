
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Spring MVC Demo</title>
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrapValidator.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/jquery-ui.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/resources/jquery/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery/bootstrapValidator.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery-ui.js"></script>
<script>
function doAjaxPostDelete(id){
	var idNo = id;
	var page = ${numOfPage};
	var $dialog = $('<div></div>').html('Are you sure delete ID = '+idNo).dialog({
    	title: "Delete Account ?",
    	height: 200,
    	width: 350,
    	modal: true, 
    	buttons: [
    	          {
    	            text: "No",
    	            icons: {
    	              primary: "ui-icon-heart"
    	            },
    	            click: function() {
    	            	$( this ).dialog( "close" );
    	            	
    	            } 
    	          },
    	          {
      	            text: "Yes",
      	            icons: {
      	              primary: "ui-icon-heart"
      	            },
      	            click: function() {
      	            	$.ajax({
	    	      			  type: "POST",
	    	      			  url: "delete",
	    	      			  data: "id="+idNo, 
	    	      			  success: function(response){   
	    	      				  alert(response );  
	    	      	 		  }, 
	    	      	 		  error: function(e){ 
	    	      	 				alert('Error: ' + e); 
	    	      	 		  } 
	    	      			}); 
      	            	$( this ).dialog( "close" );
      	            	location.reload(); 
      	            } 
      	          }
    	        ]
    	}); 
}  
function getListOfRow(){
	var e = document.getElementById("maxRow");
	var numOfRow = e.options[e.selectedIndex].value; 
	window.location.replace("${pageContext.request.contextPath}/account/getList?record=1&maxRows="+numOfRow);
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
					<p />
					<label>Show: <select id="maxRow" onchange="getListOfRow()">
							<option value="">${maxRow}</option>
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
					</select> rows in table.
					</label>
				</div>
			</div>
			<div class="col-sm-4">
				<center>
					<ul class="pagination pagination-sm">
						<c:forEach var="i" begin="1" end="${numPages}">
							<c:choose>
								<c:when test="${numOfPage eq i}">
									<li class="active"><a
										href="getList?record=${i}&maxRows=${maxRow}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="getList?record=${i}&maxRows=${maxRow}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</center>
			</div>
			<div class="col-sm-4">
				<p class="text-right">
					<a href="getList?record=${numPages}&maxRows=${maxRow}"
						class="btn btn-info">Add new Account</a>
				</p>
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
							<td><a
								href="edit?id=${acc.id}&record=${numOfPage}&maxRows=${maxRow}">Edit
							</a></td>
							<td>
								<button class="btn btn-default"
									onclick="doAjaxPostDelete(${acc.id})">Delete</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<form:form method="POST"
					action="saveAccount?record=${numOfPage}&maxRows=${maxRow}"
					id="accountForm" modelAttribute="account">
					<table class="table table-condensed">
						<tr>
							<td>ID:</td>
							<td><form:input path="id" /></td>
						</tr>
						<tr>
							<td>Name:</td>
							<td><form:input path="name" /></td>
						</tr>
						<tr>
							<td>Modifer Time:</td>
							<td><div class="form-group">
									<form:input path="time" placeholder="YYYY/MM/DD" />
								</div></td>
						</tr>
						<tr>
							<td>Status:</td>
							<td><form:select path="status">
									<form:option value="">Select Status</form:option>
									<form:option value="Dang su dung">Dang su dung</form:option>
									<form:option value="Tam khoa">Tam khoa</form:option>
									<form:option value="Het han">Het han</form:option>
								</form:select></td>
						</tr>
						<tr>
							<td>Public:</td>
							<td><form:radiobutton path="isPublic" value="true" />true <form:radiobutton
									path="isPublic" value="false" />false</td>
						</tr>
						<tr>
							<td><input type="submit" value="Save"
								class="btn btn-success" /></td>
						</tr>
					</table>
				</form:form>
			</div>
			<div class="col-sm-6">
				<div class="alert alert-success">
					<strong>Console:</strong> message.



				</div>
			</div>
		</div>

	</div>
	<script>
$( "#dialog" ).dialog({ autoOpen: false });
$( "#opener" ).click(function() {
  $( "#dialog" ).dialog( "open" );
});
</script>
	<script>
$(document).ready(function() {
    $('#accountForm').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            time: {
                validators: {
                    date: {
                        format: 'YYYY/MM/DD',
                        message: 'The value is not a valid date'
                    }
                }
            }
        }
    });
});
</script>
</body>
</html>
