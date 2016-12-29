<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.AllGamesOnlinePlayers" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>遊戲在線人數清單</title>
</head>
<body>

<%
AllGamesOnlinePlayers data = new AllGamesOnlinePlayers();
List<Map<String, String>> list = data.getAllData();
%>


<table style="text-align:center;" border="1" width="auto">
	<tr>
	   <th>遊戲(Game)</th>
	   <th>遊戲人數(Online Players)</th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr> 
       <td><%=map.get("GameID")%></td>
       <td>
	       <a href="GameOnlinePlayers.jsp?GameID=<%=map.get("GameID")%>" target = "_blank">
	       		<%=map.get("OnlinePlayers")%>
	       </a>
       </td>
    </tr>  
	<%}%>
</table>

</body>
</html>