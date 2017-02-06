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
<form name="selection" action="AllGamesOnlinePlayers.jsp" method="get">
<% String gameID = request.getParameter(CommonString.PARAMETER_GAMEID);
if(gameID == null || gameID == "")
	gameID = "ALL";	
AllGamesOnlinePlayers data = new AllGamesOnlinePlayers();
List<Map<String, String>> list = data.getAllData(gameID);
%>
&nbsp;輸入遊戲編號&nbsp;<input name=<%=CommonString.PARAMETER_GAMEID%>
						    id=<%=CommonString.PARAMETER_GAMEID%>
						    type= "text" value = <%=gameID%>>
<input type="submit" value="送出查詢" >
<br><br>
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
       	<th><%=map.get(CommonString.PARAMETER_GAMEID)%></th>
       	<th>
	       	<a href="GameOnlinePlayers.jsp?<%=CommonString.PAREMETER_USERID%>=<%=map.get(CommonString.PAREMETER_USERID)%>" target = "_blank">
	       	<%=map.get(CommonString.ONLINEPLAYERS)%>
	       	</a>
	    </th>
    </tr>  
	<%}%>
</table>
</form>
</body>
</html>