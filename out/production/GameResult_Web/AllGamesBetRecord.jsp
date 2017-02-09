<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.AllGamesBetRecord"%>
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
<title>�U�C����`�έp</title>
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
	String orderby = request.getParameter(CommonString.PARAMETER_ORDERBY);
	if(orderby == null)
		orderby = "1";
	String asc = request.getParameter(CommonString.PARAMETER_ASC);
	if(asc == null)
		asc = "1";
	String reorder;
	if(asc.equalsIgnoreCase("1"))
		reorder = "0";
	else
		reorder = "1";
	String date = request.getParameter(CommonString.PARAMETER_DATE);
	if(date == null || date == "") {
		java.util.Date c_date = new java.util.Date();
		SimpleDateFormat trans = new SimpleDateFormat(CommonString.YYYYMMDD);
		date = trans.format(c_date);
}
%>
<form name="selection" action="AllGamesBetRecord.jsp" method="post">
&nbsp;Date:&nbsp;<input name=<%=CommonString.PARAMETER_DATE%> id=<%=CommonString.PARAMETER_DATE%> type="text" value=<%=date%>>
<input type="submit" value="�e�X�d��">
</form>
<script language="JavaScript">
	$(document).ready(function() {
		$("#date").datepicker({appendText: "�I�@�U��ܤ��", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  	});
</script>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Game(�C���W��)</a></th>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=2
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Players(���a�ƶq)</a></th>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=3
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Rounds(��`����)</a></th>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=4
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Bet(���a��`��)</a></th>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=5
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Win(���aĹ��)</a></th>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=6
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Profit(�x��Q��)</a></th>
	<th><a href="AllGamesBetRecord.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=7
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Pay Rate�X���v(%)</a></th>
</tr>
<%
	AllGamesBetRecord data = new AllGamesBetRecord();
	List<Map<String, String>> list = data.getAllRecords(date, orderby, asc);
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
	      	if(map.get(CommonString.PARAMETER_GAMEID) != null)
	      		games = Integer.parseInt(map.get(CommonString.PARAMETER_GAMEID));
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
	<th><a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_GAMEID%>=<%=games%>
				&<%=CommonString.PARAMETER_DATE%>=<%=date%>" target="_blank"><%=games%></a></th>
	<th><a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_DATE%>=<%=date%>" target="_blank"><%=players%></a></th>
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