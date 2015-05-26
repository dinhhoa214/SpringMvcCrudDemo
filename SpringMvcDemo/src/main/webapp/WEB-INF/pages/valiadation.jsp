
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
<script>
function doAjaxPostDelete(id){
	var idNo = id;
	var page = ${numOfPage}; 
	$.ajax({
		  type: "POST",
		  url: "delete",
		  data: "id="+idNo + "&record=" + page, 
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
						<th>Account Id</th>
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

								<button class="btn btn-default" type="button"
									onclick="doAjaxPostDelete(${acc.id})">Delete</button></td>
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
			<div class="col-sm-8">
				<form:form method="POST" action="saveAccount?record=${numOfPage}" id="defaultForm"
					class="form-horizontal" modelAttribute="account">

					<div class="form-group">
                            <label class="col-lg-3 control-label">Account ID:</label>
                            <div class="col-lg-5"> 
                                <form:input path="id" class="form-control" name="idInput" />
                            </div>
                        </div> 


					<div class="form-group">
                            <label class="col-lg-3 control-label">NAME:</label>
                            <div class="col-lg-5"> 
                                <form:input path="name" class="form-control" name="username"/>
                            </div>
                        </div>  
                    <div class="form-group">
                            <label class="col-lg-3 control-label">Modifer Time:</label>
                            <div class="col-lg-5"> 
                                <form:input path="time" class="form-control" name="timeInput" />
                                (YYYY/MM/DD)
                            </div>
                        </div>     
					<div class="form-group">
                            <label class="col-lg-3 control-label">Status:</label>
                            <div class="col-lg-5"> 
                                <form:select path="status" class="form-control" name="statusOptions">
									<form:option value="">Select Status</form:option>
									<form:option value="Dang su dung">Dang su dung</form:option>
									<form:option value="Tam khoa">Tam khoa</form:option>
									<form:option value="Het han">Het han</form:option>
								</form:select>
                            </div>
                        </div> 	  
                    <div class="form-group">
                            <label class="col-lg-3 control-label">PUBLIC:</label>
                            <div class="col-lg-5"> 
                                <form:radiobutton path="isPublic" value="true" />true 
                                <form:radiobutton path="isPublic" value="false" />false
                            </div>
                        </div> 	    
					<div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                                <input type="submit" class="btn btn-success" name="signup" value="Save"/>
                                 
                            </div>
                        </div>	 
				</form:form>
			</div> 
 		</div>

	</div>
<script type="text/javascript">
$(document).ready(function() {
    $('#defaultForm')
        .bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The username is required and can\'t be empty'
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: 'The username must be more than 6 and less than 30 characters long'
                        },
                        /*remote: {
                            url: 'remote.php',
                            message: 'The username is not available'
                        },*/
                        regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: 'The username can only consist of alphabetical, number, dot and underscore'
                        }
                    }
                },  
            }
        })
        .on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data
            $.post($form.attr('action'), $form.serialize(), function(result) {
                console.log(result);
            }, 'json');
        });
});
</script>
</body>
</html>