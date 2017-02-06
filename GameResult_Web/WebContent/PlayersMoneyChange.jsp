<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.PlayersMoneyChange"%>
<%@ page import="com.dao.EnumAllGamesList" %>

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

<title>玩家金幣異動查詢</title>
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
String sel_month = request.getParameter("months");
if(sel_month == null)
	sel_month = "01";
String sel_year = request.getParameter("years");
if(sel_year == null)
	sel_year = "2017";
String userID = request.getParameter("userID");
if(userID == null || userID == "" || userID.replaceAll("\\s","").isEmpty())
	userID = "ALL";
%>
<form name="selection" action="PlayersMoneyChange.jsp" method="post">
&nbsp;玩家唯一碼&nbsp;<input name=<%=CommonString.PAREMETER_USERID%>
						   id=<%=CommonString.PAREMETER_USERID%>
						   type= "text" value = <%=userID%>>
<br>
&nbsp;請選擇年份&nbsp;<select name="years" size="1" id="years" onChange="change()">
<option value = "2016"  <%if (sel_year == null || sel_year.equals("2016"))  {%> selected <%}%>>2016</option>
<option value = "2017"  <%if (sel_year != null && sel_year.equals("2017"))  {%> selected <%}%>>2017</option>
<option value = "2018"  <%if (sel_year != null && sel_year.equals("2018"))  {%> selected <%}%>>2018</option>
</select>
<br>
&nbsp;請選擇月份&nbsp;<select name="months" size="1" id="months" onChange="change()">
<option value = "1"  <%if (sel_month == null || sel_month.equals("1"))  {%> selected <%}%>>1</option>
<option value = "2"  <%if (sel_month != null && sel_month.equals("2"))  {%> selected <%}%>>2</option>
<option value = "3"  <%if (sel_month != null && sel_month.equals("3"))  {%> selected <%}%>>3</option>
<option value = "4"  <%if (sel_month != null && sel_month.equals("4"))  {%> selected <%}%>>4</option>
<option value = "5"  <%if (sel_month != null && sel_month.equals("5"))  {%> selected <%}%>>5</option>
<option value = "6"  <%if (sel_month != null && sel_month.equals("6"))  {%> selected <%}%>>6</option>
<option value = "7"  <%if (sel_month != null && sel_month.equals("7"))  {%> selected <%}%>>7</option>
<option value = "8"  <%if (sel_month != null && sel_month.equals("8"))  {%> selected <%}%>>8</option>
<option value = "9"  <%if (sel_month != null && sel_month.equals("9"))  {%> selected <%}%>>9</option>
<option value = "10" <%if (sel_month != null && sel_month.equals("10")) {%> selected <%}%>>10</option>
<option value = "11" <%if (sel_month != null && sel_month.equals("11")) {%> selected <%}%>>11</option>
<option value = "12" <%if (sel_month != null && sel_month.equals("12")) {%> selected <%}%>>12</option>
</select>
</form>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>日期</th>
	<th>遊戲</th>
	<th>Game<%=EnumAllGamesList.GAME_1.getValue()%></th>
	<th>Game<%=EnumAllGamesList.GAME_2.getValue()%></th>
	<th>Game<%=EnumAllGamesList.GAME_3.getValue()%></th>
	<th>Game<%=EnumAllGamesList.GAME_4.getValue()%></th>
	<th>Game<%=EnumAllGamesList.GAME_5.getValue()%></th>
	<th>Game<%=EnumAllGamesList.GAME_6.getValue()%></th>
</tr>
<%
	PlayersMoneyChange data = new PlayersMoneyChange();
	int max_day = 31;
	int month = Integer.parseInt(sel_month);
	if(month == 2) {
		if(Integer.parseInt(sel_year)%4 == 0)
			max_day = 29;
		else
			max_day = 28;
	}
	if(month == 4 || month == 6 || month == 9 || month == 11)
		max_day = 30;
		
	for(int day = 1; day <= max_day ; day++) {
		int[] list = data.getAllRecords(sel_year, sel_month, day, userID);
		if(list == null)
			list = new int[] {0,0,0, 0,0,0, 0};
%>

<tr>
	<th><%=sel_month%>/<%=day%></th>
	<th><%=list[0]%></th>
	<th><%=list[1]%></th>
	<th><%=list[2]%></th>
	<th><%=list[3]%></th>
	<th><%=list[4]%></th>
	<th><%=list[5]%></th>
	<th><%=list[6]%></th>
</tr>
<%}%>
</table>
</body>
</html>