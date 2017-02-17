<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.BetRecordReportMonth"%>
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
<title>投注金額月報表</title>
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
	function change() {
		document.selection.submit();
	}
</script>
<%
	String sel_month = request.getParameter(CommonString.PARAMETER_MONTH);
	if(sel_month == null)
		sel_month = CommonString.DEFAULTMONTH;
	String sel_year = request.getParameter(CommonString.PARAMETER_YEAR);
	if(sel_year == null)
		sel_year = CommonString.DEFAULTYEAR;
	String sel_gameID = request.getParameter(CommonString.PARAMETER_GAMEID);
	if(sel_gameID == null)
		sel_gameID = CommonString.ALL;
%>
<form name="selection" action="BetRecordReportMonth.jsp" method="post">
&nbsp;請選擇遊戲&nbsp;<select name=<%=CommonString.PARAMETER_GAMEID%> size="ALL" id=<%=CommonString.PARAMETER_GAMEID%> onChange="change()">
<option value=<%=EnumAllGamesList.GAME_0.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_0.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_0.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_1.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_1.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_1.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_2.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_2.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_2.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_3.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_3.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_3.getValue()%></option> 		
<option value=<%=EnumAllGamesList.GAME_4.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_4.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_4.getValue()%></option> 
<option value=<%=EnumAllGamesList.GAME_5.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_5.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_5.getValue()%></option> 
<option value=<%=EnumAllGamesList.GAME_6.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_6.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_6.getValue()%></option> 
</select>
<br>
&nbsp;請選擇年份&nbsp;<select name=<%=CommonString.PARAMETER_YEAR%> size="1" id=<%=CommonString.PARAMETER_YEAR%> onChange="change()">
<option value="2016"  <%if (sel_year == null || sel_year.equals("2016"))  {%> selected <%}%>>2016</option>
<option value="2017"  <%if (sel_year != null && sel_year.equals("2017"))  {%> selected <%}%>>2017</option>
<option value="2018"  <%if (sel_year != null && sel_year.equals("2018"))  {%> selected <%}%>>2018</option>
</select>
<br>
&nbsp;請選擇月份&nbsp;<select name=<%=CommonString.PARAMETER_MONTH%> size="1" id=<%=CommonString.PARAMETER_MONTH%> onChange="change()">
<option value="1"  <%if (sel_month == null || sel_month.equals("1"))  {%> selected <%}%>>1</option>
<option value="2"  <%if (sel_month != null && sel_month.equals("2"))  {%> selected <%}%>>2</option>
<option value="3"  <%if (sel_month != null && sel_month.equals("3"))  {%> selected <%}%>>3</option>
<option value="4"  <%if (sel_month != null && sel_month.equals("4"))  {%> selected <%}%>>4</option>
<option value="5"  <%if (sel_month != null && sel_month.equals("5"))  {%> selected <%}%>>5</option>
<option value="6"  <%if (sel_month != null && sel_month.equals("6"))  {%> selected <%}%>>6</option>
<option value="7"  <%if (sel_month != null && sel_month.equals("7"))  {%> selected <%}%>>7</option>
<option value="8"  <%if (sel_month != null && sel_month.equals("8"))  {%> selected <%}%>>8</option>
<option value="9"  <%if (sel_month != null && sel_month.equals("9"))  {%> selected <%}%>>9</option>
<option value="10" <%if (sel_month != null && sel_month.equals("10")) {%> selected <%}%>>10</option>
<option value="11" <%if (sel_month != null && sel_month.equals("11")) {%> selected <%}%>>11</option>
<option value="12" <%if (sel_month != null && sel_month.equals("12")) {%> selected <%}%>>12</option>
</select>
</form>
<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "點一下顯示日曆", firstDay: 1, dateFormat: 'yy/mm/dd'});
  });
</script>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>Date(日期)</th>
<%if(sel_gameID.equalsIgnoreCase(CommonString.ALL)){%>
	<th>Games(遊戲數量)</th>
<%}%>
	<th>Players(玩家數量)</th>
	<th>Rounds(投注次數)</th>
	<th>Bet(玩家投注金)</th>
	<th>Win(玩家贏金)</th>
	<th>Profit(官方利潤)</th>
	<th>Pay Rate出獎率(%)</th>
</tr>
<%
	BetRecordReportMonth data = new BetRecordReportMonth();
	List<Map<String, String>> list = data.getAllRecords(sel_year, sel_month, sel_gameID);
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
	      	if(map.get(CommonString.GAMES) != null)
	      		games = Integer.parseInt(map.get(CommonString.GAMES));
	      	if(map.get(CommonString.PLAYERS) != null)
	      		players = Integer.parseInt(map.get(CommonString.PLAYERS));
	      	if(map.get(CommonString.ROUNDS) != null)
	      		rounds = Integer.parseInt(map.get(CommonString.ROUNDS));
	      	if(map.get(CommonString.BET) != null)
	      		bet = Integer.parseInt(map.get(CommonString.BET));
	      	if(map.get(CommonString.WIN) != null)
	      		win = Integer.parseInt(map.get(CommonString.WIN));
	      	if(map.get(CommonString.PROFIT) != null)
	      		profit = Integer.parseInt(map.get(CommonString.PROFIT));
	      	if(map.get(CommonString.PAYRATE) != null)
	      		rayrate = Float.parseFloat(map.get(CommonString.PAYRATE));	      	
	%>
	<th><%=map.get(CommonString.TIMES)%></th>
<%if(sel_gameID.equalsIgnoreCase(CommonString.ALL)){ %>
	<th><%=games%></th>
<%}%>
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