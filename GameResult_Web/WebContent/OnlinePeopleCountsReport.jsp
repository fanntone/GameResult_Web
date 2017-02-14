<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="com.dao.OnlinePeopleCountsReport"%>
<%@ page import="com.dao.EnumAllGamesList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="com.dao.EnumSelectionList"%>
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
<title>在線人數查詢</title>
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
	String sel = request.getParameter(CommonString.PARAMETER_SELECT);
	String date = request.getParameter(CommonString.PARAMETER_DATE);
	if(date == null) {
		java.util.Date c_date = new java.util.Date();
		SimpleDateFormat trans = new SimpleDateFormat(CommonString.YYYYMMDD);
		date = trans.format(c_date);
	}
%>
<form name="selection" action="OnlinePeopleCountsReport.jsp" method="post">請選擇遊戲:&nbsp;
<select name=<%=CommonString.PARAMETER_SELECT%> size="1" id=<%=CommonString.PARAMETER_SELECT %> onChange="change()">
<option value=<%=EnumSelectionList.SELECT_0.getValue()%>
	<%if (sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())) {%>
		selected <%}%>>ALL</option>
<option value=<%=EnumSelectionList.SELECT_1.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_1.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_1.getValue()%></option>
<option value=<%=EnumSelectionList.SELECT_2.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_2.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_2.getValue()%></option>
<option value=<%=EnumSelectionList.SELECT_3.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_3.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_3.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_4.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_4.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_4.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_5.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_5.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_5.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_6.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_6.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_6.getValue()%></option> 
</select>
<br>
點一下顯示日曆:&nbsp;<input name =<%=CommonString.PARAMETER_DATE%> id=<%=CommonString.PARAMETER_DATE%> type="text" value=<%=date%>>
<input type="submit" value="送出查詢">
</form>

<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({firstDay: 1, dateFormat: "yy/mm/dd"});
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
	   <th>時間</th>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())) {%>
	   		<th>ALL</th>
	   <%}%>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue()) || sel.equals(EnumSelectionList.SELECT_1.getValue())) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_1.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue()) || sel.equals(EnumSelectionList.SELECT_2.getValue())) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_2.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue()) || sel.equals(EnumSelectionList.SELECT_3.getValue())) {%>	
	   		<th>Game <%=EnumAllGamesList.GAME_3.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue()) || sel.equals(EnumSelectionList.SELECT_4.getValue())) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_4.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue()) || sel.equals(EnumSelectionList.SELECT_5.getValue())) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_5.getValue()%></th>
	   <%}%>
	   <% if(sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue()) || sel.equals(EnumSelectionList.SELECT_6.getValue())) {%>
	   		<th>Game <%=EnumAllGamesList.GAME_6.getValue()%></th>
	   <%}%>
	</tr>
	<%
		Map<String, String> map = null;
	  	int max_all = 0;
	  	int totals = 0;
	  	float avg = 0;
	  	for(int i = 0; i < list.size(); i++) {  
	      	map = (Map<String, String>)list.get(i);
	%>
    <tr>
    	<th><%=map.get(CommonString.TIME) %></th>
        <% if(sel == null || sel.equals("0")) { %>
        <th>
	    <%
			int all = 0;
			all = Integer.parseInt(map.get(CommonString.gameid_array[1]))
				+ Integer.parseInt(map.get(CommonString.gameid_array[2]))
				+ Integer.parseInt(map.get(CommonString.gameid_array[3]))
				+ Integer.parseInt(map.get(CommonString.gameid_array[4]))
				+ Integer.parseInt(map.get(CommonString.gameid_array[5]))
				+ Integer.parseInt(map.get(CommonString.gameid_array[6]));
			if(all > max_all)
				max_all = all;
			totals += all;
			if(i+1 == list.size())
				avg = totals/(float)(i+1);
	    %>
	    <%=all%>
	    </th>
        <%}%>
        <% if(size == 1 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
        <th><%=map.get(CommonString.gameid_array[1])%></th><%}%>
        <% if(size == 2 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
        <th><%=map.get(CommonString.gameid_array[2])%></th><%}%>
        <% if(size == 3 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
        <th><%=map.get(CommonString.gameid_array[3])%></th><%}%>
        <% if(size == 4 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
        <th><%=map.get(CommonString.gameid_array[4])%></th><%}%>
        <% if(size == 5 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
        <th><%=map.get(CommonString.gameid_array[5])%></th><%}%>
        <% if(size == 6 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
        <th><%=map.get(CommonString.gameid_array[6])%></th><%}%>
    </tr>
    <%if(i+1 == list.size()){ %>
    <tr style="background-color:#00BBFF">
    	<th>MAX</th>
   		<% if(sel == null || sel.equals("0")){ %>
        <th><%=max_all%></th><%}%>
   		<% if(size == 1 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getMaxGamePeopleByGameID(EnumAllGamesList.GAME_1.getValue(),
   												date, CommonString.gameid_array[1])%></th><%}%>
   		<% if(size == 2 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getMaxGamePeopleByGameID(EnumAllGamesList.GAME_2.getValue(),
   												date, CommonString.gameid_array[2])%></th><%}%>
   		<% if(size == 3 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getMaxGamePeopleByGameID(EnumAllGamesList.GAME_3.getValue(),
   												date, CommonString.gameid_array[3])%></th><%}%>
   		<% if(size == 4 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getMaxGamePeopleByGameID(EnumAllGamesList.GAME_4.getValue(),
   												date, CommonString.gameid_array[4])%></th><%}%>
   		<% if(size == 5 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getMaxGamePeopleByGameID(EnumAllGamesList.GAME_5.getValue(),
   												date, CommonString.gameid_array[5])%></th><%}%>
   		<% if(size == 6 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getMaxGamePeopleByGameID(EnumAllGamesList.GAME_6.getValue(),
   												date, CommonString.gameid_array[6])%></th><%}%>
    </tr>
    <tr style="background-color:#00BBFF">
	 	<th>AVG</th>
   		<% if(sel == null || sel.equals("0")){ %>
        <th><%=avg%></th><%}%>
   		<% if(size == 1 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getAvgGamePeopleByGameID(EnumAllGamesList.GAME_1.getValue(),
   												date, "game01")%></th><%}%>
   		<% if(size == 2 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getAvgGamePeopleByGameID(EnumAllGamesList.GAME_2.getValue(),
   												date, CommonString.gameid_array[2])%></th><%}%>
   		<% if(size == 3 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getAvgGamePeopleByGameID(EnumAllGamesList.GAME_3.getValue(),
   												date, CommonString.gameid_array[3])%></th><%}%>
   		<% if(size == 4 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getAvgGamePeopleByGameID(EnumAllGamesList.GAME_4.getValue(),
   												date, CommonString.gameid_array[4])%></th><%}%>
   		<% if(size == 5 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getAvgGamePeopleByGameID(EnumAllGamesList.GAME_5.getValue(),
   												date, CommonString.gameid_array[5])%></th><%}%>
   		<% if(size == 6 || sel == null || sel.equals(EnumSelectionList.SELECT_0.getValue())){ %>
   		<th><%=data.getAvgGamePeopleByGameID(EnumAllGamesList.GAME_6.getValue(),
   												date, CommonString.gameid_array[6])%></th><%}%>
	</tr>
    <%}%>
<%}%>
</table>
</body>
</html>