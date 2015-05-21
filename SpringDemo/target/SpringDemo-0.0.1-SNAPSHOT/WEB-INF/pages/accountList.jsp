    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
     pageEncoding="ISO-8859-1"%>  
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>  
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
    <html>  
    <head>  
    <title>Being Java Guys | Spring DI Hello World</title>  
    <style>  
    body {  
     font-size: 20px;  
     color: teal;  
     font-family: Calibri;  
    }  
      
    td {  
     font-size: 15px;  
     color: black;  
     width: 100px;  
     height: 22px;  
     text-align: center;  
    }  
    .heading {  
     font-size: 18px;  
     color: white;  
     font: bold;  
     background-color: orange;  
     border: thick;  
    }  
    </style>  
    </head>  
    <body>  
     <center>  
        
       
       
     <b>User  
       List | Being Java Guys </b>  
       
      
         
        
      
      <table border="1">  
       <tr>  
        <td class="heading">User Id</td>  
        <td class="heading"> Name</td>     
        <td class="heading">Time</td>  
        <td class="heading">Status</td>
        <td class="heading">Is Public</td>  
        <td class="heading">Edit</td>  
        <td class="heading">Delete</td>  
       </tr>  
       <c:forEach var="acc" items="${accountList}">  
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
       <tr><td colspan="7"><a href="register">Add New User</a></td></tr>  
      </table>  
      
     </center>  
    </body>  
    </html>  