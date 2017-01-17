<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlinePeopleCountsReportMonth" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
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

<%String sel = request.getParameter("select");%>
<form name="selection" action="test.jsp" method="post"> 請選擇月份
<select name="select" size="1" id="select" onChange="change()">
<option value = "1"  <%if (sel == null || sel.equals("1"))  {%> selected <%}%>>1</option>
<option value = "2"  <%if (sel != null && sel.equals("2"))  {%> selected <%}%>>2</option>
<option value = "3"  <%if (sel != null && sel.equals("3"))  {%> selected <%}%>>3</option>
<option value = "4"  <%if (sel != null && sel.equals("4"))  {%> selected <%}%>>4</option>
<option value = "5"  <%if (sel != null && sel.equals("5"))  {%> selected <%}%>>5</option>
<option value = "6"  <%if (sel != null && sel.equals("6"))  {%> selected <%}%>>6</option>
<option value = "7"  <%if (sel != null && sel.equals("7"))  {%> selected <%}%>>7</option>
<option value = "8"  <%if (sel != null && sel.equals("8"))  {%> selected <%}%>>8</option>
<option value = "9"  <%if (sel != null && sel.equals("9"))  {%> selected <%}%>>9</option>
<option value = "10" <%if (sel != null && sel.equals("10")) {%> selected <%}%>>10</option>
<option value = "11" <%if (sel != null && sel.equals("11")) {%> selected <%}%>>11</option>
<option value = "12" <%if (sel != null && sel.equals("12")) {%> selected <%}%>>12</option>
</select>
</form>

<br>
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
<tr>
	<th>時間(月/日)</th>
	<%
		if(sel== null)
			sel = "1";
		int month = Integer.valueOf(sel).intValue();		
		int day = 1;
		for(day = 1; day <= 31; day++) { 
			if(month == 2 && day == 29)
				break;
			if((month == 4 || month == 6 || month == 9 || month == 11) && day == 31)
				break;
			
	%>
	<th>
	<%=month%>/<%=day%>
	</th>
	<%}%>
</tr>

<tr>
<th>00:00:00</th>
	<%
		OnlinePeopleCountsReportMonth data = new OnlinePeopleCountsReportMonth();
		List<Map<String, String>> list = data.getAllData("2017/01/01 00:00:00");
		Map<String, String> map = null;
		for(int ii = 0; ii < list.size(); ii++) {  
		    map = (Map<String, String>)list.get(ii);
	%>
	<%String counts = map.get("Counts_1");
	if(counts == null)
		counts = "0";
	%>
	<th><%=counts%></th>

	<%}%>
</tr>

<tr>
<th>00:05:00</th>
	<%
		data = new OnlinePeopleCountsReportMonth();
		list = data.getAllData("2017/01/01 00:05:00");
		map = null;
		for(int ii = 0; ii < list.size(); ii++) {  
		    map = (Map<String, String>)list.get(ii);
	%>
	<%String counts = map.get("Counts_1");
	if(counts == null)
		counts = "0";
	%>
	<th><%=counts%></th>

	<%}%>
</tr>


</table>
</body>
</html>