<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth"%>
<%@ page import="com.dao.CommonString"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>遊戲在線人數月報表</title>
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
	String sel_gameID = request.getParameter(CommonString.PARAMETER_GAMEID);
	String sel_month = request.getParameter(CommonString.PARAMETER_MONTH);
	String sel_year = request.getParameter(CommonString.PARAMETER_YEAR);
%>
<form name="selection" action="OnlinePeopleCountsReportMonth.jsp" method="post">
&nbsp;請選擇遊戲&nbsp;<select name=<%=CommonString.PARAMETER_GAMEID%> size="1" id=<%=CommonString.PARAMETER_GAMEID%> onChange="change()">
<option value="0"  <%if (sel_gameID == null || sel_gameID.equals("0"))  {%> selected <%}%>>ALL</option>
<option value="1"  <%if (sel_gameID != null && sel_gameID.equals("1"))  {%> selected <%}%>>game01</option>
<option value="2"  <%if (sel_gameID != null && sel_gameID.equals("2"))  {%> selected <%}%>>game02</option>
<option value="3"  <%if (sel_gameID != null && sel_gameID.equals("3"))  {%> selected <%}%>>game03</option>
<option value="4"  <%if (sel_gameID != null && sel_gameID.equals("4"))  {%> selected <%}%>>game04</option>
<option value="5"  <%if (sel_gameID != null && sel_gameID.equals("5"))  {%> selected <%}%>>game05</option>
<option value="6"  <%if (sel_gameID != null && sel_gameID.equals("6"))  {%> selected <%}%>>game06</option>
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
<br>
&nbsp;請選擇年份&nbsp;<select name=<%=CommonString.PARAMETER_YEAR%> size="1" id=<%=CommonString.PARAMETER_YEAR%> onChange="change()">
<option value="2017"  <%if (sel_year == null || sel_year.equals("2017"))  {%> selected <%}%>>2017</option>
<option value="2018"  <%if (sel_year != null && sel_year.equals("2018"))  {%> selected <%}%>>2018</option>
</select>
</form>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>時間\(月/日)</th>
	<%
		if(sel_gameID == null)
			sel_gameID = "0";
		if(sel_month == null)
			sel_month = CommonString.DEFAULTMONTH;
		if(sel_year == null)
			sel_year = CommonString.DEFAULTYEAR;
		int month = Integer.valueOf(sel_month).intValue();		
		int day = 1;
		int max_day = 31;
		for(day = 1; day < 32; day++) { 
			if(month == 2 && day == 29) {
				if(Integer.parseInt(sel_year)%4 == 0)
					max_day = 29;
				else
					max_day = 28;
				break;
			}
			if((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
				max_day = 30;
				break;
			}			
	%><th><%=month%>/<%=day%></th><%}%><th><%=sel_month%>月平均</th>
</tr>
<tr><%
	OnlinePeopleCountsReportMonth data = new OnlinePeopleCountsReportMonth();
	List<Map<String, String>> time_list = data.getAllTimeList();
	Map<String, String> maps = null;
	for(int times = 0; times < time_list.size(); times++) {  
	    maps = (Map<String, String>)time_list.get(times);
	    String times_ = maps.get(CommonString.TIMES);
%><th><%=times_%></th><%
	int[] list = data.getAllData(sel_year + "/"+ Integer.parseInt(sel_month) +"/01 " + times_,
								 Integer.parseInt(sel_month),
								 Integer.parseInt(sel_year),
								 Integer.parseInt(sel_gameID),
								 times_);
	int row_sum = 0;
	for(int ii = 0; ii < max_day; ii++) {  
	    int counts = list[ii];
	    row_sum += counts;
%><th><%=counts%></th><%}%><th><%=row_sum/(float)max_day%></tr><%}%>
<tr style="background-color:#00BBFF"><th>MAX</th><%
		float row_max = 0;
		for(int j = 0; j < (day-1) ; j++){
			String max_people = data.getMaxGamePeopleByGameID(sel_year + "/" + sel_month + "/" + CommonString.days_array[j],
															  Integer.parseInt(sel_gameID));
			row_max += Integer.parseInt(max_people);
			
%><th><%=max_people%></th><%}%><th><%=row_max/max_day%></th></tr>
<tr style="background-color:#00BBFF"><th>AVG</th><%
		float row_avg = 0;
		for(int avg = 0; avg < (day-1) ; avg++){
			String avg_people = data.getAvgGamePeopleByGameID(sel_year + "/" + sel_month + "/" + CommonString.days_array[avg],
															  Integer.parseInt(sel_gameID));
			row_avg += Float.parseFloat(avg_people);
%><th><%=avg_people%></th><%}%><th><%=row_avg/max_day%></th></tr>
</table>
</body>
</html>