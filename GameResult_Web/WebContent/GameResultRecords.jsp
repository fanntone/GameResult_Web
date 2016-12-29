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
<title>Insert title here</title>
</head>
<body>

<script>
function change(){
document.selection.submit();
}
</script>

<% String sel = request.getParameter("select");%>
<form name="selection" action="GameResultRecords.jsp" method="post"> �п�ܵ���
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

<table style="text-align:center;" border="1" width="100%">
	<tr>
	   <th>���� UUID</th>
	   <th>���a�ߤ@�X</th>
	   <th>�C���s��</th>
	   <th>�U�`�I��</th>
	   <th>�U�`�u��</th>
	   <th>��Ĺ�I��</th>
	   <th>�S��������A</th>
	   <th>�S������I��</th>
	   <th>�U�`�e  ���a�����I��</th>
	   <th>�U�`�e  ���a�����I��</th>
	   <th>�S���� </th>
	   <th>�ɪG�إ߮ɶ�</th>
	   <th>�ԲӤU�`�O�� </th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
      <tr>  
         <td><%=map.get("roundUUID") %></td>  
         <td>
	         <a href="PlayerDetail.jsp?userID=<%=map.get("userID")%>" target = "_blank">
	            <%=map.get("userID") %>
	         </a>
 		 </td> 
         <td><%=map.get("gameID")%></td>
         <td><%=map.get("betting") %></td>  
         <td><%=map.get("lines") %></td>  
         <td><%=map.get("results")%></td>
         <td><%=map.get("roundStatus") %></td>  
         <td><%=map.get("prizeResults") %></td>  
         <td><%=map.get("beforeBalance")%></td> 
         <td><%=map.get("afterBalance") %></td>  
         <td><%=map.get("specialNumber") %></td>  
         <td><%=map.get("resultsDate")%></td>
         <td><%=map.get("resultsParams")%></td> 
      </tr>  
	<%}%>  

</table>

<p style="color:red">��e����:<%=pageIndex%>/<%=totalpages%>
<a href="GameResultRecords.jsp?pageIndex=1">&nbsp;����</a>   
<a href="GameResultRecords.jsp?pageIndex=<%=pageIndex-1 %>">&nbsp;�W�@��</a>  
<a href="GameResultRecords.jsp?pageIndex=<%=pageIndex+1 %>">&nbsp;�U�@��</a>  
<a href="GameResultRecords.jsp?pageIndex=<%=totalpages%>">&nbsp;����</a>

</body>
</html>