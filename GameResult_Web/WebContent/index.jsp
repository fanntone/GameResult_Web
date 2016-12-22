<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "com.dao.GameResultRecordsDao" %>

<html>
<head>	
<title>SELECT Operation</title>
</head>
<body>

<script>
function change(){
document.selection.submit();
}
</script>

<% String sel = request.getParameter("select");%>

<form name="selection" action="index.jsp" method="post"> 請選擇筆數
<select name="select" size="1" id="select" onChange="change()">
<option value="5"  <%if (sel == null || sel.equals("5")){%> selected <%}%>>5</option>
<option value="10" <%if (sel != null && sel.equals("10")){%> selected <%}%>>10</option>
<option value="25" <%if (sel != null && sel.equals("25")){%> selected <%}%>>25</option> 
<option value="50" <%if (sel != null && sel.equals("50")){%> selected <%}%>>50</option> 
<option value="100"<%if (sel != null && sel.equals("100")){%> selected <%}%>>100</option> 
</select>
</form>
<br>
  
<%
int pageSize = 5;
if(sel != null)
	pageSize = Integer.parseInt(sel);

GameResultRecordsDao ed = new GameResultRecordsDao();
int totalpages = ed.getTotalPage(pageSize);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null){  
    currentPage="1";  
}  
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalpages){  
    pageIndex = totalpages;  
}  
List<Map<String, String>> list = ed.getAllempByPage(pageSize,pageIndex);
%>

<table border="1" width="100%">
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
         <td><%=map.get("roundUUID") %></td>  
         <td><%=map.get("userID") %></td>  
         <td><%=map.get("gameID")%></td>
         <td><%=map.get("betting") %></td>  
         <td><%=map.get("lines") %></td>  
         <td><%=map.get("results")%></td>
         <td><%=map.get("roundStatus") %></td>  
         <td><%=map.get("prizeREsults") %></td>  
         <td><%=map.get("beforeBalance")%></td> 
         <td><%=map.get("afterBalance") %></td>  
         <td><%=map.get("specialNumber") %></td>  
         <td><%=map.get("resultsDate")%></td>
         <td><%=map.get("resultsParams")%></td> 
      </tr>  
	<%}%>  

</table>

<p style="color:red">當前頁數:<%=pageIndex%>/<%=totalpages%>
<a href="index.jsp?pageIndex=1">&nbsp;首頁</a>   
<a href="index.jsp?pageIndex=<%=pageIndex-1 %>">&nbsp;上一頁</a>  
<a href="index.jsp?pageIndex=<%=pageIndex+1 %>">&nbsp;下一頁</a>  
<a href="index.jsp?pageIndex=<%=totalpages%>">&nbsp;末頁</a>
 
</body>
</html>