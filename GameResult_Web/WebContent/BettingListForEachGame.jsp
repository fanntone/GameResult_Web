<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
<title>單一遊戲投注清單</title>
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
		userID = CommonString.ALL;
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
	String sel_gameID = request.getParameter(CommonString.PARAMETER_GAMEID);
	if(sel_gameID == null || sel_gameID == "")
		sel_gameID = EnumAllGamesList.GAME_0.getValue();
	String date = request.getParameter(CommonString.PARAMETER_DATE);
	if(date == null || date == "") {
		java.util.Date c_date = new java.util.Date();
		SimpleDateFormat trans = new SimpleDateFormat(CommonString.YYYYMMDD);
		date = trans.format(c_date);
	}
	String sel_page = request.getParameter(CommonString.PARAMETER_SELPAGESIZE);
	if(sel_page == null || sel_page == "" || sel_page.replaceAll("\\s","").isEmpty())
		sel_page = "5";
	int pageSize;
	pageSize = Integer.parseInt(sel_page);
%>
<form name="selection" action="BettingListForEachGame.jsp" method="post">
&nbsp;請選擇遊戲&nbsp;
<select name=<%=CommonString.PARAMETER_GAMEID%> size="1" id=<%=CommonString.PARAMETER_GAMEID%> onChange="change()">
<option value=<%=EnumAllGamesList.GAME_0.getValue()%>
	<%if (sel_gameID == null || sel_gameID.equals(EnumAllGamesList.GAME_0.getValue())) {%>
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
&nbsp;請選擇筆數&nbsp;
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
&nbsp;輸入玩家編號&nbsp;<input name=<%=CommonString.PAREMETER_USERID%>
						    id=<%=CommonString.PAREMETER_USERID%>
						    type="text" value=<%=userID%>>
&nbsp;<input type="submit" value="送出查詢">
<br>
<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "  點一下顯示日曆", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>
<br>
<%
	BettingListForEachGame data = new BettingListForEachGame();
	String currentPage = request.getParameter(CommonString.PARAMETER_PAGEINDEX);
	if(currentPage == null || currentPage == "" ||currentPage.replaceAll("\\s","").isEmpty())  
	    currentPage = "1";
	int pageIndex = Integer.parseInt(currentPage);  
	List<Map<String, String>> list = data.getAllRecords(date,
														sel_gameID,
														orderby,
														asc,
														userID,
														pageSize,
														pageIndex);
	int totalPages = data.getTotalPage(pageSize, date, sel_gameID, userID);	 	
	if(pageIndex < 1) {  
	    pageIndex = 1;  
	} else if(pageIndex > totalPages){  
	    pageIndex = totalPages;  
	}
	int nextPage = pageIndex + 1;
	if(nextPage > totalPages)
		nextPage = totalPages;
	int upPage = pageIndex - 1;
	if(upPage < 1)
		upPage = 1;

%>
<p style="color:red">&nbsp;當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;首頁</a>
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;上一頁</a>  
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;下一頁</a>
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;末頁</a>
到第&nbsp;<input name=<%=CommonString.PARAMETER_PAGEINDEX%> id=<%=CommonString.PARAMETER_PAGEINDEX%> type="text" value=<%=pageIndex%>>頁
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th><a href="BettingListForEachGame.jsp
			?<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
			&<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
			&<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=2
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Player ID(玩家編號)</a></th>
	<th><a href="BettingListForEachGame.jsp
			?<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
			&<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
			&<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=4
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Rounds(投注次數)</a></th>
	<th><a href="BettingListForEachGame.jsp
			?<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
			&<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
			&<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=5
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Bet(玩家投注金)</a></th>
	<th><a href="BettingListForEachGame.jsp
			?<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
			&<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
			&<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=6
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Win(玩家贏金)</a></th>
	<th><a href="BettingListForEachGame.jsp
			?<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
			&<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
			&<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=7
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Profit(官方利潤)</a></th>
	<th><a href="BettingListForEachGame.jsp
			?<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
			&<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
			&<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=8
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Pay Rate出獎率(%)</a></th>
</tr>
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
	<th><%=players%></th>
	<th><%=rounds%></th>
	<th><%=bet%></th>
	<th><%=win%></th>
	<th><%=profit%></th>
	<th><%=rayrate%>%</th>
</tr>
<%}%>
</table>
<p style="color:red">&nbsp;當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;首頁</a>
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;上一頁</a>  
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;下一頁</a>
<a href="BettingListForEachGame.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;末頁</a>
到第&nbsp;<input name=<%=CommonString.PARAMETER_PAGEINDEX%> id=<%=CommonString.PARAMETER_PAGEINDEX%> type="text" value=<%=pageIndex%>>頁
</form>	
</body>
</html>