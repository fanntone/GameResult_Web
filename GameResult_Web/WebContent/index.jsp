<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>	
<title>SELECT Operation</title>
</head>
<body>
 <form name="form1" onsubmit="checkBoxValidation()">
     <h3>Please insert data</h3>
     <p><input type="text" name="game" value="0"/>Emp_ID</p>
     <p><input type="submit" value="submit"/>
 </form>


<br>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://10.36.1.102:3306/TEST"
     user="root"  password="3edc2wsx!QAZ"/>

 <%String game= request.getParameter("game");
	if(game != null){%>
	<h4>Your select Emp_ID > <%=game%></h4>
	<%}%>
	
<sql:query dataSource="${snapshot}" var="result">
SELECT * from Employees Where id > <%=game%>;
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Emp ID</th>
   <th>First Name</th>
   <th>Last Name</th>
   <th>Age</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
	<td><c:out value="${row.id}"/></td>
	<td><c:out value="${row.first}"/></td>
	<td><c:out value="${row.last}"/></td>
	<td><c:out value="${row.age}"/></td>
</tr>
</c:forEach>
</table>
</body>
</html>