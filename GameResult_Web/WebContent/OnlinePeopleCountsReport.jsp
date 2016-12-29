<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "com.dao.OnlinePeopleCountsReport" %>
<%@ page import = "com.dao.EnumAllGamesList" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>在線人數查詢</title>
</head>
<body>

<script>
function change(){
document.selection.submit();
}
</script>

<% String sel = request.getParameter("select");%>
<form name="selection" action="OnlinePeopleCountsReport.jsp" method="post"> 請選擇遊戲ID
<select name="select" size="ALL" id="select" onChange="change()">
<option value="0"<%if (sel == null || sel.equals("0")) {%> selected <%}%>>ALL</option>
<option value="1"<%if (sel != null && sel.equals("1")) {%> selected <%}%>>1001</option>
<option value="2"<%if (sel != null && sel.equals("2")) {%> selected <%}%>>1002</option>
<option value="3"<%if (sel != null && sel.equals("3")) {%> selected <%}%>>1003</option> 
<option value="4"<%if (sel != null && sel.equals("4")) {%> selected <%}%>>1004</option> 
<option value="5"<%if (sel != null && sel.equals("5")) {%> selected <%}%>>1005</option> 
<option value="6"<%if (sel != null && sel.equals("6")) {%> selected <%}%>>1006</option> 
</select> 
</form>
<br>
<%
OnlinePeopleCountsReport data = new OnlinePeopleCountsReport();
List<Map<String, String>> list = data.getAllData();
int size = 0;
if(sel == null)
	size = list.size();
else
	size = Integer.parseInt(sel);

%>
<table style="text-align:center;" border="1">
	<tr>
	   <th>時間</th>
	   <% if(size == 1 || sel == null || sel.equals("0")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_1.getValue()%></th>
	   <%}%>
	   <% if(size == 2 || sel == null || sel.equals("0")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_2.getValue()%></th>
	   <%}%>
	   <% if(size == 3 || sel == null || sel.equals("0")) {%>	
	   		<th>Game <%=EnumAllGamesList.GAME_3.getValue()%></th>
	   <%}%>
	   <% if(size == 4 || sel == null || sel.equals("0")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_4.getValue()%></th>
	   <%}%>
	   <% if(size == 5 || sel == null || sel.equals("0")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_5.getValue()%></th>
	   <%}%>
	   <% if(size == 6 || sel == null || sel.equals("0")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_6.getValue()%></th>
	   <%}%>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr>  
       <td><%=map.get("time") %></td>
       <% if(size ==1 || sel == null || sel.equals("0")){ %>
       		<td><%=map.get("Game1")%></td><%}%>
       <% if(size ==2 || sel == null || sel.equals("0")){ %>
       		<td><%=map.get("Game2")%></td><%}%>
       <% if(size ==3 || sel == null || sel.equals("0")){ %>
       		<td><%=map.get("Game3")%></td><%}%>
       <% if(size ==4 || sel == null || sel.equals("0")){ %>
       		<td><%=map.get("Game4")%></td><%}%>
       <% if(size ==5 || sel == null || sel.equals("0")){ %>
       		<td><%=map.get("Game5")%></td><%}%>
       <% if(size ==6 || sel == null || sel.equals("0")){ %>
       		<td><%=map.get("Game6")%></td><%}%>
    </tr>
<%}%>  

</table>

</body>
</html>