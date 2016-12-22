<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.PlayerDetail" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>

<%

String parameter = "userID=";
String users = request.getQueryString().substring(parameter.length());
PlayerDetail data = new PlayerDetail();
if(users == null)
	users = "1";
int id = Integer.parseInt(users);
if(id < 0)
	id = 1;
List<Map<String, String>> list = data.getAllData(id);
%>
<table border="1" width="100%">
	<tr>
	   <th>玩家唯一碼</th>
	   <th>年齡</th>
	   <th>姓</th>
	   <th>名</th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
      <tr> 
         <td><%=map.get("id")%></td>
         <td><%=map.get("age") %></td>  
         <td><%=map.get("first") %></td>  
         <td><%=map.get("last")%></td>
      </tr>  
	<%}%>  

</table>

</body>
</html>