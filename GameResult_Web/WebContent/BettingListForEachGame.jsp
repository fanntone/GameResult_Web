<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.BettingListForEachGame"%>
<%@ page import="com.dao.EnumSelectionList"%>
<%@ page import="com.dao.EnumAllGamesList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<title>�C�饭�x��`�d��</title>
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
</script>
<%
String sel = request.getParameter(CommonString.PARAMETER_GAMEID);
String date = request.getParameter(CommonString.PARAMETER_DATE);
if(date == null) {
	java.util.Date c_date = new java.util.Date();
	SimpleDateFormat trans = new SimpleDateFormat(CommonString.YYYYMMDD);
	date = trans.format(c_date);
}
%>
<form name="selection" action="BettingListForEachGame.jsp" method="get"> �п�ܵ���
<select name="gameID" size="ALL" id="gameID" onChange="change()">
<option value=<%=EnumAllGamesList.GAME_1.getValue()%>
	<%if (sel != null && sel.equals(EnumAllGamesList.GAME_1.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_1.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_2.getValue()%>
	<%if (sel != null && sel.equals(EnumAllGamesList.GAME_2.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_2.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_3.getValue()%>
	<%if (sel != null && sel.equals(EnumAllGamesList.GAME_3.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_3.getValue()%></option> 		
<option value=<%=EnumAllGamesList.GAME_4.getValue()%>
	<%if (sel != null && sel.equals(EnumAllGamesList.GAME_4.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_4.getValue()%></option> 
<option value=<%=EnumAllGamesList.GAME_5.getValue()%>
	<%if (sel != null && sel.equals(EnumAllGamesList.GAME_5.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_5.getValue()%></option> 
<option value=<%=EnumAllGamesList.GAME_6.getValue()%>
	<%if (sel != null && sel.equals(EnumAllGamesList.GAME_6.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_6.getValue()%></option> 
</select>

<br>
Date:<input name = "date" id= "date" type= "text" value = <%=date%>><br>
<input type="submit" value="�e�X�d��" >
</form>
<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "�I�@�U��ܤ��", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>Players(���a�ƶq)</th>
	<th>Rounds(��`����)</th>
	<th>Bet(���a��`��)</th>
	<th>Win(���aĹ��)</th>
	<th>Profit(�x��Q��)</th>
	<th>Pay Rate�X���v(%)</th>
</tr>
<%
	BettingListForEachGame data = new BettingListForEachGame();
	List<Map<String, String>> list = data.getAllRecords(date, sel);
%>
<tr>
	<%
		Map<String, String> map = null;
		int games = 0;
		int players = 0;
		int rounds = 0;
		int bet = 0;
		int win = 0;
		int profit = 0;
		float rayrate = 0;
	  	for(int i = 0; i < list.size(); i++) {  
	      	map = (Map<String, String>)list.get(i);
	      	if(map.get("Players") != null)
	      		players = Integer.parseInt(map.get("Players"));
	      	if(map.get("Rounds") != null)
	      		rounds = Integer.parseInt(map.get("Rounds"));
	      	if(map.get("Bet") != null)
	      		bet = Integer.parseInt(map.get("Bet"));
	      	if(map.get("Win") != null)
	      		win = Integer.parseInt(map.get("Win"));
	      	if(map.get("Profit") != null)
	      		profit = Integer.parseInt(map.get("Profit"));
	      	if(map.get("PayRate") != null)
	      		rayrate = Float.parseFloat(map.get("PayRate"));
	%>
	<th><%=players%></th>
	<th><%=rounds%></th>
	<th><%=bet%></th>
	<th><%=win%></th>
	<th><%=profit%></th>
	<th><%=rayrate%>%</th>
</tr>
<%}%>

</table>
</body>
</html>