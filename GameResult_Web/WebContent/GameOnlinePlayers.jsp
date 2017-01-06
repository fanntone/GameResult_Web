<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.dao.GameOnlinePlayers" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>各遊戲在線玩家清單</title>
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
<form name="selection" action="GameOnlinePlayers.jsp" method="post"> 請選擇筆數
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
String parameter = "gameID=";
String gameid = request.getParameter("gameID");
if(gameid == null)
	gameid = "1001";

int pageSize = 5;
if(sel != null)
	pageSize = Integer.parseInt(sel);

GameOnlinePlayers data = new GameOnlinePlayers();
int totalPages = data.getTotalPage(pageSize, gameid);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1) {  
    pageIndex = 1;  
} else if(pageIndex > totalPages){  
    pageIndex = totalPages;  
} 



List<Map<String, String>> list = data.getAllByPage(pageSize, pageIndex, gameid);
%>

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
	<tr>
	    <th>玩家編號(useID)</th>
	    <th>帳號餘額(Money)</th>
	    <th>所在遊戲(Game)</th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr> 
        <th>
            <a href="PlayerDetail.jsp?userID=<%=map.get("userID")%>" target = "_blank">
               <%=map.get("userID")%>
            </a>
        </th>
        <th><%=map.get("balance")%></th>
        <th><%=map.get("gameID")%></th>
    </tr>  
	<%}%>
</table>

<%
int nextPage = pageIndex + 1;
if(nextPage > totalPages)
	nextPage = totalPages;

int upPage = pageIndex - 1;
if(upPage < 1)
	upPage = 1;
%>

<p style="color:red">當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="GameOnlinePlayers.jsp?pageIndex=1&gameID=<%=gameid%>">&nbsp;首頁</a>
<a href="GameOnlinePlayers.jsp?pageIndex=<%=upPage %>&gameID=<%=gameid%>">&nbsp;上一頁</a>  
<a href="GameOnlinePlayers.jsp?pageIndex=<%=nextPage %>&gameID=<%=gameid%>">&nbsp;下一頁</a>
<a href="GameOnlinePlayers.jsp?pageIndex=<%=totalPages%>&gameID=<%=gameid%>">&nbsp;末頁</a>

</body>
</html>