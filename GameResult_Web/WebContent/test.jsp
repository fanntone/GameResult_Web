<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlinePeopleCountsReportYear"%>
<%@ page import="com.dao.CommonString"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>遊戲在線人數年報表</title>
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

<%String sel_game = request.getParameter("games");%>
<%String sel_month = request.getParameter("months");%>
<%String sel_year = request.getParameter("years");%>
<form name="selection" action="test.jsp" method="post">
&nbsp;請選擇遊戲&nbsp;<select name="games" size="1" id="games" onChange="change()">
<option value = "0"  <%if (sel_game == null || sel_game.equals("0"))  {%> selected <%}%>>ALL</option>
<option value = "1"  <%if (sel_game != null && sel_game.equals("1"))  {%> selected <%}%>>game01</option>
<option value = "2"  <%if (sel_game != null && sel_game.equals("2"))  {%> selected <%}%>>game02</option>
<option value = "3"  <%if (sel_game != null && sel_game.equals("3"))  {%> selected <%}%>>game03</option>
<option value = "4"  <%if (sel_game != null && sel_game.equals("4"))  {%> selected <%}%>>game04</option>
<option value = "5"  <%if (sel_game != null && sel_game.equals("5"))  {%> selected <%}%>>game05</option>
<option value = "5"  <%if (sel_game != null && sel_game.equals("6"))  {%> selected <%}%>>game06</option>
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
<br>
&nbsp;請選擇年份&nbsp;<select name="years" size="1" id="years" onChange="change()">
<option value = "2017"  <%if (sel_year == null || sel_year.equals("2017"))  {%> selected <%}%>>2017</option>
<option value = "2018"  <%if (sel_year != null && sel_year.equals("2018"))  {%> selected <%}%>>2018</option>
</select>

</form>

<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>時間\(月份)</th>
	<%
		if(sel_game == null)
			sel_game = "0";
		if(sel_month == null)
			sel_month = "1";
		if(sel_year == null)
			sel_year = "2017";
		int month = Integer.valueOf(sel_month).intValue();
		OnlinePeopleCountsReportYear data = new OnlinePeopleCountsReportYear();
		int[] max_array = new int[] {0,0,0, 0,0,0, 0,0,0, 0,0,0};
		int[] sum_array = new int[] {0,0,0, 0,0,0, 0,0,0, 0,0,0};
		int day = 1;
		int sum_count = 0;
		for(month = 1; month <= 12; month++){ 
	%><th><%=month%></th><%}%>
</tr>

<tr><%
	List<Map<String, String>> time_list = data.getAllTimeList();
	Map<String, String> maps = null;
	for(int times = 0; times < time_list.size(); times++,sum_count++) {  
	    maps = (Map<String, String>)time_list.get(times);
	    String times_ = maps.get("Times");
%><th><%=times_%></th><%
	List<Map<String, String>> list = data.getAllData(sel_year + "/"+ Integer.parseInt(sel_month) +"/01 " + times_,
													 Integer.parseInt(sel_month),
													 Integer.parseInt(sel_year),
													 Integer.parseInt(sel_game),
													 times_);
	Map<String, String> map = null;
	for(int ii = 0; ii < list.size(); ii++) {  
	    map = (Map<String, String>)list.get(ii);
	    String counts = map.get("Counts_1");
		if(counts == null)
			counts = "0";
		if(Integer.valueOf(counts) > max_array[ii])
			max_array[ii] = Integer.valueOf(counts);
		sum_array[ii] = sum_array[ii] + Integer.valueOf(counts);
%><th><%=counts%></th><%}%></tr><%}%>

<tr><th>MAX</th><%
		for(int j = 0; j < (month-1) ; j++){
			String max_people = String.valueOf(max_array[j]);
%><th><%=max_people%></th><%}%></tr>

<tr><th>AVG</th><%
		for(int avg = 0; avg < (month-1) ; avg++){
			String max_people = String.valueOf(sum_array[avg]/(float)time_list.size());
%><th><%=max_people%></th><%}%></tr>
</table>
</body>
</html>