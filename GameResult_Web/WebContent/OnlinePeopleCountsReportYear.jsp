<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
<%
	String sel_gameID = request.getParameter(CommonString.PARAMETER_GAMEID);
	String sel_month = request.getParameter(CommonString.PARAMETER_MONTH);
	String sel_year = request.getParameter(CommonString.PARAMETER_YEAR);
%>
<form name="selection" action="OnlinePeopleCountsReportYear.jsp" method="post">
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
&nbsp;請選擇年份&nbsp;<select name=<%=CommonString.PARAMETER_YEAR%> size="1" id=<%=CommonString.PARAMETER_YEAR%> onChange="change()">
<option value="2017"  <%if (sel_year == null || sel_year.equals("2017"))  {%> selected <%}%>>2017</option>
<option value="2018"  <%if (sel_year != null && sel_year.equals("2018"))  {%> selected <%}%>>2018</option>
</select>
</form>
<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>時間\(月份)</th>
	<%
		if(sel_gameID == null)
			sel_gameID = "0";
		if(sel_month == null)
			sel_month = CommonString.DEFAULTMONTH;
		if(sel_year == null)
			sel_year = CommonString.DEFAULTYEAR;
		int month = Integer.valueOf(sel_month).intValue();
		OnlinePeopleCountsReportYear data = new OnlinePeopleCountsReportYear();
		int[] max_array = new int[] {0,0,0, 0,0,0, 0,0,0, 0,0,0};
		int[] sum_array = new int[] {0,0,0, 0,0,0, 0,0,0, 0,0,0};
		int day = 1;
		int sum_count = 0;
		for(month = 1; month <= 12; month++){ 
	%><th><%=month%></th><%}%><th><%=sel_year%>年平均</th>
</tr>
<tr><%
	List<Map<String, String>> time_list = data.getAllTimeList();
	Map<String, String> maps = null;
	for(int times = 0; times < time_list.size(); times++,sum_count++) {  
	    maps = (Map<String, String>)time_list.get(times);
	    String times_ = maps.get(CommonString.TIMES);
%><th><%=times_%></th><%
	int[] list = data.getAllData(sel_year + "/"+ Integer.parseInt(sel_month) +"/01 " + times_,
								 Integer.parseInt(sel_month),
								 Integer.parseInt(sel_year),
								 Integer.parseInt(sel_gameID),
								 times_);
	Map<String, String> map = null;
	int row_sum = 0;

	for(int ii = 0; ii < 12; ii++) {  
	    int counts = list[ii];
		if(counts > max_array[ii])
			max_array[ii] = counts;
		sum_array[ii] = sum_array[ii] + counts;
		row_sum += counts;		
%><th><%=counts%></th><%}%><th><%=row_sum/(float)12%></th></tr><%}%>

<tr style="background-color:#00BBFF"><th>MAX</th><%
		float row_max = 0;
		for(int j = 0; j < (month-1) ; j++){
			String max_people = String.valueOf(max_array[j]);
			row_max += max_array[j];
%><th><%=max_people%></th><%}%><th><%=row_max/12%></th></tr>

<tr style="background-color:#00BBFF"><th>AVG</th><%
		float row_avg = 0;
		for(int avg = 0; avg < (month-1) ; avg++){
			String max_people = String.valueOf(sum_array[avg]/(float)time_list.size());
			row_avg += Float.parseFloat(max_people);
%><th><%=max_people%></th><%}%><th><%=row_avg/12%></th></tr>
</table>
</body>
</html>