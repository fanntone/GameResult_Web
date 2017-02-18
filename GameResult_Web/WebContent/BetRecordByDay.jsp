<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.BetRecordByDay"%>
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
<title>每日平台投注查詢</title>
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
	String date = request.getParameter(CommonString.PARAMETER_DATE);
	if(date == null || date == "") {
		java.util.Date c_date = new java.util.Date();
		SimpleDateFormat trans = new SimpleDateFormat(CommonString.YYYYMMDD);
		date = trans.format(c_date);
	}
%>
<form name="selection" action="BetRecordByDay.jsp" method="post">
&nbsp;<input name=<%=CommonString.PARAMETER_DATE%> id=<%=CommonString.PARAMETER_DATE%> type="text" value=<%=date%>>&nbsp;
<input type="submit" value="送出查詢" >
</form>
<script language="JavaScript">
	$(document).ready(function() {
		$("#date").datepicker({appendText: "點一下顯示日曆", firstDay: 1,  dateFormat: 'yy/mm/dd'});
	});
</script>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>Games(遊戲數量)</th>
	<th>Players(玩家數量)</th>
	<th>Rounds(投注次數)</th>
	<th>Bet(玩家投注金)</th>
	<th>Win(玩家贏金)</th>
	<th>Profit(官方利潤)</th>
	<th>Pay Rate出獎率(%)</th>
</tr>
<%
	BetRecordByDay data = new BetRecordByDay();
	List<Map<String, String>> list = data.getAllRecords(date);
%>
<tr>
	<%
		Map<String, String> map = null;
		String games = "0";
		String players = "0";
		String rounds = "0";
		String bet = "0";
		String win = "0";
		String profit = "0";
		float rayrate = 0;
	  	for(int i = 0; i < list.size(); i++) {  
	      	map = (Map<String, String>)list.get(i);
	      	if(map.get(CommonString.GAMES) != null)
	      		games = map.get(CommonString.GAMES);
	      	if(map.get(CommonString.PLAYERS) != null)
	      		players = map.get(CommonString.PLAYERS);
	      	if(map.get(CommonString.ROUNDS) != null)
	      		rounds = map.get(CommonString.ROUNDS);
	      	if(map.get(CommonString.BET) != null)
	      		bet = map.get(CommonString.BET);
	      	if(map.get(CommonString.WIN) != null)
	      		win = map.get(CommonString.WIN);
	      	if(map.get(CommonString.PROFIT) != null)
	      		profit = map.get(CommonString.PROFIT);
	      	if(map.get(CommonString.PAYRATE) != null)
	      		rayrate = Float.parseFloat(map.get(CommonString.PAYRATE));
	%>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>" target="_blank"><%=games%></a></th>
	<th><%=players%></th>
	<th><%=rounds%></th>
	<th><%=bet%></th>
	<th><%=win%></th>
	<th><%=profit%></th>
	<th><%=rayrate%>%</th>
	<%}%>
</tr>
</table>
</body>
</html>