<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "com.dao.GameResultRecords" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>賽果資訊</title>
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

<% String sel = request.getParameter("select");%>
<form name="selection" action="GameResultRecords.jsp" method="post"> 請選擇筆數
<select name="select" size="1" id="select" onChange="change()">
<option value="5"  <%if (sel == null || sel.equals("5"))  {%> selected <%}%>>5</option>
<option value="10" <%if (sel != null && sel.equals("10")) {%> selected <%}%>>10</option>
<option value="25" <%if (sel != null && sel.equals("25")) {%> selected <%}%>>25</option> 
<option value="50" <%if (sel != null && sel.equals("50")) {%> selected <%}%>>50</option> 
<option value="100"<%if (sel != null && sel.equals("100")){%> selected <%}%>>100</option> 
</select>
</form>
<br>
  
<%
int pageSize = 5;
if(sel != null)
	pageSize = Integer.parseInt(sel);

GameResultRecords ed = new GameResultRecords();
int totalpages = ed.getTotalPage(pageSize);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalpages){  
    pageIndex = totalpages;  
}  
List<Map<String, String>> list = ed.getAllempByPage(pageSize,pageIndex);
%>

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
	<tr>
	    <th>局號 UUID</th>
	    <th>玩家唯一碼</th>
	    <th>遊戲編號</th>
	    <th>下注點數</th>
	    <th>下注線數</th>
	    <th>輸贏點數</th>
	    <th>特殊獎項狀態</th>
	    <th>特殊獎金點數</th>
	    <th>下注前  玩家持有點數</th>
	    <th>下注前  玩家持有點數</th>
	    <th>特殊局號 </th>
	    <th>賽果建立時間</th>
	    <th>詳細下注記錄 </th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
      <tr>  
          <th><%=map.get("roundUUID") %></th>  
          <th>
	          <a href="PlayerDetail.jsp?userID=<%=map.get("userID")%>" target = "_blank">
	            <%=map.get("userID") %>
	          </a>
 		  </th> 
          <th><%=map.get("gameID")%></th>
          <th><%=map.get("betting") %></th>  
          <th><%=map.get("lines") %></th>  
          <th><%=map.get("results")%></th>
          <th><%=map.get("roundStatus") %></th>  
          <th><%=map.get("prizeResults") %></th>  
          <th><%=map.get("beforeBalance")%></th> 
          <th><%=map.get("afterBalance") %></th>  
          <th><%=map.get("specialNumber") %></th>  
          <th><%=map.get("resultsDate")%></th>
          <th><%=map.get("resultsParams")%></th> 
      </tr>  
	<%}%>
</table>

<p style="color:red">當前頁數:<%=pageIndex%>/<%=totalpages%>
<a href="GameResultRecords.jsp?pageIndex=1">&nbsp;首頁</a>   
<a href="GameResultRecords.jsp?pageIndex=<%=pageIndex-1 %>">&nbsp;上一頁</a>  
<a href="GameResultRecords.jsp?pageIndex=<%=pageIndex+1 %>">&nbsp;下一頁</a>  
<a href="GameResultRecords.jsp?pageIndex=<%=totalpages%>">&nbsp;末頁</a>

</body>
</html>