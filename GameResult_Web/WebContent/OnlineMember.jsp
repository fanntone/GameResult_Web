<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlineMember" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>玩家在線清單</title>
</head>
<body>

<script>
function change(){
document.selection.submit();
}
</script>

<% String sel = request.getParameter("select");%>
<form name="selection" action="OnlineMember.jsp" method="post"> 請選擇筆數
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

OnlineMember data = new OnlineMember();
int totalpages = data.getTotalPage(pageSize);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalpages){  
    pageIndex = totalpages;  
} 

List<Map<String, String>> list = data.getAllempByPage(pageSize, pageIndex);
%>

<table border="1" width="auto">
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
       <td><%=map.get("userID")%></td>
       <td><%=map.get("blance")%></td>
       <td><%=map.get("gameID")%></td>
    </tr>  
	<%}%>
</table>

<p style="color:red">當前頁數:<%=pageIndex%>/<%=totalpages%>
<a href="OnlineMember.jsp?pageIndex=1">&nbsp;首頁</a>   
<a href="OnlineMember.jsp?pageIndex=<%=pageIndex-1 %>">&nbsp;上一頁</a>  
<a href="OnlineMember.jsp?pageIndex=<%=pageIndex+1 %>">&nbsp;下一頁</a>  
<a href="OnlineMember.jsp?pageIndex=<%=totalpages%>">&nbsp;末頁</a>

</body>
</html>