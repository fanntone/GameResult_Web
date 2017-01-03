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
<title>會員資料</title>
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
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
	<tr>
		<th>玩家唯一碼</th>
	    <th>幣別代碼</th>
	    <th>玩家登入帳號</th>
	    <th>玩家登入密碼</th>
	    <th>玩家暱稱</th>
	    <th>玩家現有點數(BG)</th>
	    <th>玩家狀態</th>
	    <th>等同玩家狀態</th>
	    <th>註冊類型</th>
	    <th>帳號是否為管理者(0:不是, 1:是)</th>
	</tr>
	<%  
	  Map<String, String> map = null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr>
    	<th><%=map.get("userID")%></th>
        <th><%=map.get("currency")%></th>
        <th><%=map.get("loginID")%></th>
        <th><%=map.get("passWord")%></th>
        <th><%=map.get("nickName")%></th>
        <th><%=map.get("balance")%></th>
        <th><%=map.get("userStatus")%></th>
        <th><%=map.get("status")%></th>
        <th><%=map.get("regType")%></th>
        <th><%=map.get("gm")%></th>
    </tr>  
	<%}%>  
</table>

</body>
</html>