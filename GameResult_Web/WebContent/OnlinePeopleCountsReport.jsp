<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "com.dao.OnlinePeopleCountsReport" %>
<%@ page import = "com.dao.EnumAllGamesList" %>
<%@ page import="java.text.SimpleDateFormat"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<style>
  article,aside,figure,figcaption,footer,header,hgroup,menu,nav,section {display:block;}
  body {font: 62.5% "Trebuchet MS", sans-serif; margin: 50px;}
</style>
<title>�b�u�H�Ƭd��</title>
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

<script>
function change(){
document.selection.submit();
}

function test() {
document.pickers.submit();
}
</script>

<% 
String sel = request.getParameter("select");
String date = request.getParameter("datepicker1");
if(date == null) {
	java.util.Date c_date = new java.util.Date();
	SimpleDateFormat trans = new SimpleDateFormat("YYYY/MM/dd");
	date = trans.format(c_date);
}
%>

<form name="selection" action="OnlinePeopleCountsReport.jsp" method="post"> �п�ܹC��ID
<select name="select" size="ALL" id="select" onChange="change()">
<option value="0" <%if (sel == null || sel.equals("0")) {%> selected <%}%>>ALL</option>
<option value="1" <%if (sel != null && sel.equals("1")) {%> selected <%}%>><%=EnumAllGamesList.GAME_1.getValue()%></option>
<option value="2" <%if (sel != null && sel.equals("2")) {%> selected <%}%>><%=EnumAllGamesList.GAME_2.getValue()%></option>
<option value="3" <%if (sel != null && sel.equals("3")) {%> selected <%}%>><%=EnumAllGamesList.GAME_3.getValue()%></option> 
<option value="4" <%if (sel != null && sel.equals("4")) {%> selected <%}%>><%=EnumAllGamesList.GAME_4.getValue()%></option> 
<option value="5" <%if (sel != null && sel.equals("5")) {%> selected <%}%>><%=EnumAllGamesList.GAME_5.getValue()%></option> 
<option value="6" <%if (sel != null && sel.equals("6")) {%> selected <%}%>><%=EnumAllGamesList.GAME_6.getValue()%></option> 
</select>

<input name = "datepicker1" id= "datepicker1" type= "text" value = <%=date%>>
<input type="submit" value="Submit">
</form>

<br>
<script language="JavaScript">
  $(document).ready(function(){ 
    $("#datepicker1").datepicker({appendText: "�I�@�U��ܤ��", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>

<br>
<%
OnlinePeopleCountsReport data = new OnlinePeopleCountsReport();
List<Map<String, String>> list = data.getAllData(date);
int size = 0;
if(sel == null) {
	sel = "0";
	size = list.size();
}
else
	size = Integer.parseInt(sel);
%>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
	<tr>
	   <th>�ɶ�</th>
	   <% if(sel == null || sel.equals("0")) {%>
	   		<th>ALL</th>
	   <%}%>
	   <% if(sel == null || sel.equals("0") || sel.equals("1") ) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_1.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals("0") || sel.equals("2")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_2.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals("0") || sel.equals("3")) {%>	
	   		<th>Game <%=EnumAllGamesList.GAME_3.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals("0") || sel.equals("4")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_4.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals("0") || sel.equals("5")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_5.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals("0") || sel.equals("6")) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_6.getValue()%></th>
	   <%}%>
	</tr>
	<%  
	  Map<String, String> map = null;
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr>  
       <th><%=map.get("time") %></th>
       <% if(sel == null || sel.equals("0")) { %>
       		<th>
       			<%
       				int all = 0;
       			 	all = Integer.parseInt(map.get("Game1"))
       					+ Integer.parseInt(map.get("Game2"))
       					+ Integer.parseInt(map.get("Game3"))
       					+ Integer.parseInt(map.get("Game4"))
       					+ Integer.parseInt(map.get("Game5"))
       					+ Integer.parseInt(map.get("Game6"));%>
       		    <%=all%>
       		</th>
       <%}%>
       <% if(size == 1 || sel == null || sel.equals("0")){ %>
       		<th><%=map.get("Game1")%></th><%}%>
       <% if(size == 2 || sel == null || sel.equals("0")){ %>
       		<th><%=map.get("Game2")%></th><%}%>
       <% if(size == 3 || sel == null || sel.equals("0")){ %>
       		<th><%=map.get("Game3")%></th><%}%>
       <% if(size == 4 || sel == null || sel.equals("0")){ %>
       		<th><%=map.get("Game4")%></th><%}%>
       <% if(size == 5 || sel == null || sel.equals("0")){ %>
       		<th><%=map.get("Game5")%></th><%}%>
       <% if(size == 6 || sel == null || sel.equals("0")){ %>
       		<th><%=map.get("Game6")%></th><%}%>
    </tr>

<%}%>
</table>

</body>
</html>