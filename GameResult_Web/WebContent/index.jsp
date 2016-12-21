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
     <h3>Please insert data then press submit button</h3>
     <p>Search Emp_ID >= <input type="text" name="id" value="0"/><input type="submit" value="submit"/></p>
 </form>
<% 
String submit= request.getParameter("id");
%>

<table border="11" width="100%">
<tr>
   <th>Emp ID</th>
   <th>First Name</th>
   <th>Last Name</th>
   <th>Age</th>
</tr>

<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
String url = "jdbc:mysql://10.36.1.102:3306/TEST";
String user = "root";
String pwd = "3edc2wsx!QAZ";
Connection conn= DriverManager.getConnection(url,user,pwd); 
Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
String sql;
if(submit != null && submit != "")
	sql = "select * from Employees where id >= " + submit;
else
	sql = "select * from Employees";
ResultSet rs = stmt.executeQuery(sql);
while(rs.next()) {%> 
<tr>
	<td><%=rs.getString(1)%></td>
	<td><%=rs.getString(3)%></td>
	<td><%=rs.getString(4)%></td>
	<td><%=rs.getString(2)%></td>
</tr>
<%}%>
</table>

<%rs.close(); 
stmt.close(); 
conn.close(); 
%>
 
</body>
</html>