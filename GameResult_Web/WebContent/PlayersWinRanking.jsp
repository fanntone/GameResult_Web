<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.PlayersWinRanking"%>
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
<title>���a�`��Ĺ�Ʀ�(�C��)</title>
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
	String userID = request.getParameter(CommonString.PAREMETER_USERID);
	if(userID == null || userID == "" || userID.replaceAll("\\s","").isEmpty())
		userID = "ALL";
	String orderby = request.getParameter(CommonString.PARAMETER_ORDERBY);
	if(orderby == null || orderby == "" || orderby.replaceAll("\\s","").isEmpty())
		orderby = "1";
	String asc = request.getParameter(CommonString.PARAMETER_ASC);
	if(asc == null || asc == "" || asc.replaceAll("\\s","").isEmpty())
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
	String sel_page = request.getParameter(CommonString.PARAMETER_SELPAGESIZE);
	if(sel_page == null || sel_page == "" || sel_page.replaceAll("\\s","").isEmpty())
		sel_page = "5";
%>
<form name="selection" action="PlayersWinRanking.jsp" method="post">
&nbsp;�п�ܵ���&nbsp;
<select name=<%=CommonString.PARAMETER_SELPAGESIZE%> size="1" id=<%=CommonString.PARAMETER_SELPAGESIZE%> onChange="change()">
<option value=<%=EnumSelectionList.SELECT_5.getValue()%>
	<%if (sel_page == null || sel_page.equals(EnumSelectionList.SELECT_5.getValue()))  {%>
		selected <%}%>><%=EnumSelectionList.SELECT_5.getValue()%></option>
<option value=<%=EnumSelectionList.SELECT_10.getValue()%>
	<%if (sel_page != null && sel_page.equals(EnumSelectionList.SELECT_10.getValue())) {%>
		selected <%}%>><%=EnumSelectionList.SELECT_10.getValue()%></option>
<option value=<%=EnumSelectionList.SELECT_25.getValue()%>
	<%if (sel_page != null && sel_page.equals(EnumSelectionList.SELECT_25.getValue())) {%>
		selected <%}%>><%=EnumSelectionList.SELECT_25.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_50.getValue()%>
	<%if (sel_page != null && sel_page.equals(EnumSelectionList.SELECT_50.getValue())) {%>
		selected <%}%>><%=EnumSelectionList.SELECT_50.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_100.getValue()%>
	<%if (sel_page != null && sel_page.equals(EnumSelectionList.SELECT_100.getValue())){%>
		selected <%}%>><%=EnumSelectionList.SELECT_100.getValue()%></option> 
</select>
<br>
&nbsp;<input name=<%=CommonString.PARAMETER_DATE%> id=<%=CommonString.PARAMETER_DATE%> type="text" value=<%=date%>><br>
&nbsp;��J���a�s��&nbsp;<input name=<%=CommonString.PAREMETER_USERID%>
						    id=<%=CommonString.PAREMETER_USERID%>
						    type="text" value=<%=userID%>>
&nbsp;<input type="submit" value="�e�X�d��" >
<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "  �I�@�U��ܤ��", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>
<br>
<%
	int pageSize = 5;
	pageSize = Integer.parseInt(sel_page);
	PlayersWinRanking data = new PlayersWinRanking();
	String currentPage = request.getParameter(CommonString.PARAMETER_PAGEINDEX);
	if(currentPage == null || currentPage == "" || currentPage.replaceAll("\\s","").isEmpty())  
	    currentPage = "1";
	int pageIndex = Integer.parseInt(currentPage);  
	int totalPages = data.getTotalPage(pageSize, date, userID);		
	if(pageIndex < 1) {  
	    pageIndex = 1;  
	} else if(pageIndex > totalPages){  
	    pageIndex = totalPages;
	}
	List<Map<String, String>> list = data.getAllRecords(date,
														orderby,
														asc,
														userID,
														pageSize,
														pageIndex);
	int nextPage = pageIndex + 1;
	if(nextPage > totalPages)
		nextPage = totalPages;
	int upPage = pageIndex - 1;
	if(upPage < 1)
		upPage = 1;
%>
<p style="color:red">&nbsp;��e����:<%=pageIndex%>/<%=totalPages%>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;����</a>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;�W�@��</a>  
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;�U�@��</a>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;����</a>
���&nbsp;<input name=<%=CommonString.PARAMETER_PAGEINDEX%> id=<%=CommonString.PARAMETER_PAGEINDEX%> type="text" value=<%=pageIndex%>>��

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th><a href="PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=2
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Players(���a�s��)</a></th>
	<th><a href="PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=4
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Rounds(��`����)</a></th>
	<th><a href="PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=5
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Bet(���a��`��)</a></th>
	<th><a href="PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=6
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Win(���aĹ��)</a></th>
	<th><a href="PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=7
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Profit(�x��Q��)</a></th>
	<th><a href="PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=8
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Pay Rate�X���v(%)</a></th>
</tr>
<tr>
	<%
		Map<String, String> map = null;
		String games = "0";
		String players = "0";
		String rounds = "0";
		String bet = "0";
		String win = "0";
		String profit = "0";
		String rayrate = "0";
	  	for(int i = 0; i < list.size(); i++) {  
	      	map = (Map<String, String>)list.get(i);
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
	      		rayrate = map.get(CommonString.PAYRATE);
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
<p style="color:red">&nbsp;��e����:<%=pageIndex%>/<%=totalPages%>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;����</a>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;�W�@��</a>  
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;�U�@��</a>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;����</a>
���&nbsp;<input name=<%=CommonString.PARAMETER_PAGEINDEX%> id=<%=CommonString.PARAMETER_PAGEINDEX%> type="text" value=<%=pageIndex%>>��
</form>	
</body>
</html>