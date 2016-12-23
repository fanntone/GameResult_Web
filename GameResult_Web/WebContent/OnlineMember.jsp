<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlineMember" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>

<%
OnlineMember data = new OnlineMember();
List<Map<String, String>> list = data.getAllData();
%>

<table border="1" width="auto">
	<tr>
	   <th>遊戲(GameID)</th>
	   <th>線上遊戲人數(Online Players)</th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr> 
       <td><%=map.get("userID")%></td>
       <td><%=map.get("gameID")%></td>
    </tr>  
	<%}%>  
</table>

</body>
</html>