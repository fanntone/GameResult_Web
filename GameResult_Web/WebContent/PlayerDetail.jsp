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
<table border="1" width="auto">
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
    	<td><%=map.get("userID")%></td>
        <td><%=map.get("currency")%></td>
        <td><%=map.get("loginID")%></td>
        <td><%=map.get("passWord")%></td>
        <td><%=map.get("nickName")%></td>
        <td><%=map.get("balance")%></td>
        <td><%=map.get("userStatus")%></td>
        <td><%=map.get("status")%></td>
        <td><%=map.get("regType")%></td>
        <td><%=map.get("gm")%></td>
    </tr>  
	<%}%>  
</table>

</body>
</html>