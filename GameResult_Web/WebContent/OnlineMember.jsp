<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.OnlineMember" %>
<%@ page import="com.dao.CommonString" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>���a�b�u�M��</title>
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
<form name="selection" action="OnlineMember.jsp" method="post"> �п�ܵ���
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
int totalPages = data.getTotalPage(pageSize);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalPages){  
    pageIndex = totalPages;  
} 

List<Map<String, String>> list = data.getAllempByPage(pageSize, pageIndex);
%>

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
	<tr>
	    <th>���a�s��(useID)</th>
	    <th>�b���l�B(Money)</th>
	    <th>�Ҧb�C��(Game)</th>
	</tr>
	<%
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr>
        <th>
        	<a href="PlayerDetail.jsp?<%=CommonString.PAREMETER_USERID%>=<%=map.get(CommonString.PAREMETER_USERID)%>" target = "_blank">
               <%=map.get("userID")%>
           	</a>
        </th>
        <th><%=map.get("blance")%></th>
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

<p style="color:red">��e����:<%=pageIndex%>/<%=totalPages%>
<a href="OnlineMember.jsp?<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;����</a>
<a href="OnlineMember.jsp?<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;�W�@��</a>  
<a href="OnlineMember.jsp?<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;�U�@��</a>
<a href="OnlineMember.jsp?<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;����</a>

</body>
</html>