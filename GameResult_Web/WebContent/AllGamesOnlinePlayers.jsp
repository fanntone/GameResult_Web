<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.dao.AllGamesOnlinePlayers"%>
<%@ page import="com.dao.CommonString"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>遊戲在線人數清單</title>
<style>

table, td, th {
    border: 3px solid #FFAC55;
    text-align: left;
}

table {
    border-collapse: collapse;
    width: auto;
}

th, td {
    padding: 15px;
}
</style>
</head>
<body>

<%
AllGamesOnlinePlayers data = new AllGamesOnlinePlayers();
List<Map<String, String>> list = data.getAllData();
%>

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
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
       	<th><%=map.get("GameID")%></th>
       	<th>
	       	<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_GAMEID%>=<%=map.get(CommonString.PARAMETER_GAMEID)%>" target = "_blank">
	       	<%=map.get("OnlinePlayers")%>
	       	</a>
	    </th>
    </tr>  
	<%}%>
</table>
</body>
</html>