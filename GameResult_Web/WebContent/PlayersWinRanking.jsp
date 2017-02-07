<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
<title>玩家總輸贏排行(每日)</title>
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
if(sel_page == null)
	sel_page = "5";
int pageSize;
pageSize = Integer.parseInt(sel_page);
%>
<form name="selection" action="PlayersWinRanking.jsp" method="post">
&nbsp;請選擇筆數&nbsp;
<select name="sel_page" size="1" id="sel_page" onChange="change()">
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
&nbsp;<input name = "date" id= "date" type= "text" value = <%=date%>><br>
&nbsp;輸入玩家編號&nbsp;<input name=<%=CommonString.PAREMETER_USERID%>
						    id=<%=CommonString.PAREMETER_USERID%>
						    type= "text" value = <%=userID%>>
&nbsp;<input type="submit" value="送出查詢" >
<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "  點一下顯示日曆", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th><a href = "PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Players(玩家數量)</a></th>
	<th><a href = "PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Rounds(投注次數)</a></th>
	<th><a href = "PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Bet(玩家投注金)</a></th>
	<th><a href = "PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Win(玩家贏金)</a></th>
	<th><a href = "PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Profit(官方利潤)</a></th>
	<th><a href = "PlayersWinRanking.jsp
			?<%=CommonString.PARAMETER_DATE%>=<%=date%>
			&<%=CommonString.PARAMETER_ORDERBY%>=1
			&<%=CommonString.PARAMETER_ASC%>=<%=reorder%>">Pay Rate出獎率(%)</a></th>
</tr>
<%
	PlayersWinRanking data = new PlayersWinRanking();
	String currentPage = request.getParameter(CommonString.PARAMETER_PAGEINDEX);
	if(currentPage==null)  
	    currentPage="1";
	int pageIndex = Integer.parseInt(currentPage);  
	List<Map<String, String>> list = data.getAllRecords(date,
														orderby,
														asc,
														userID,
														pageSize,
														pageIndex);
	int totalPages = data.getTotalPage(pageSize, date, userID);
		
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
<p style="color:red">當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&pageIndex=1">&nbsp;首頁</a>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&pageIndex=<%=upPage%>">&nbsp;上一頁</a>  
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&pageIndex=<%=nextPage%>">&nbsp;下一頁</a>
<a href="PlayersWinRanking.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel_page%>
		&<%=CommonString.PARAMETER_DATE%>=<%=date%>
		&<%=CommonString.PARAMETER_ORDERBY%>=1
		&<%=CommonString.PARAMETER_ASC%>=<%=asc%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>
		&pageIndex=<%=totalPages%>">&nbsp;末頁</a>
到第&nbsp;<input name= "pageIndex" id= "pageIndex" type= "text" value=<%=pageIndex%>>頁
</form>	
</body>
</html>