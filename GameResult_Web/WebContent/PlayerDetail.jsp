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
		<th>���a�ߤ@�X</th>
	    <th>���O�N�X</th>
	    <th>���a�n�J�b��</th>
	    <th>���a�n�J�K�X</th>
	    <th>���a�ʺ�</th>
	    <th>���a�{���I��(BG)</th>
	    <th>���a���A</th>
	    <th>���P���a���A</th>
	    <th>���U����</th>
	    <th>�b���O�_���޲z��(0:���O, 1:�O)</th>
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