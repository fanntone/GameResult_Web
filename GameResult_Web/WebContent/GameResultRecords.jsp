<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "com.dao.GameResultRecords" %>
<%@ page import = "com.dao.GameResultJsonParser" %>
<%@ page import = "com.alibaba.fastjson.JSON" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>�ɪG��T</title>
<style>
table, td, th {
    border: 3px solid #FFAC55;
    text-align: left;
}

table {
    border-collapse: collapse;
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
String sel = request.getParameter("select");
if(sel == null)
	sel = "5";
String userid = request.getParameter("userid");
if(userid == null)
	userid = "0";
%>
<form name="selection" action="GameResultRecords.jsp" method="post"> �п�ܵ���
<select name="select" size="1" id="select" onChange="change()">
<option value="5"  <%if (sel == null || sel.equals("5"))  {%> selected <%}%>>5</option>
<option value="10" <%if (sel != null && sel.equals("10")) {%> selected <%}%>>10</option>
<option value="25" <%if (sel != null && sel.equals("25")) {%> selected <%}%>>25</option> 
<option value="50" <%if (sel != null && sel.equals("50")) {%> selected <%}%>>50</option> 
<option value="100"<%if (sel != null && sel.equals("100")){%> selected <%}%>>100</option>
</select>
<input name = "userid" id= "userid" type= "text" value = <%=userid%>>
<input type="submit" value="Submit">
</form>
<br>  
<%
int pageSize = 5;
pageSize = Integer.parseInt(sel);

GameResultRecords ed = new GameResultRecords();
int totalPages = ed.getTotalPage(pageSize, userid);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalPages){  
    pageIndex = totalPages;  
}

List<Map<String, String>> list = ed.getAllRecordsByPage(pageSize, pageIndex, userid);
%>

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
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
	    <th>�U�`��  ���a�����I��</th>
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
          <th>
          <%
          	String jsonstring = map.get("resultsParams");
          	GameResultJsonParser ps = JSON.parseObject(jsonstring, GameResultJsonParser.class);
          	for(int j = 0; j< 15 ; j++) {
				String text = "<img src=\"images/"+ ps.slot1[j] + ".png\" />";
				if((j+1)%5==0)
					text += "<br>";
				out.println(text);
			}
          %>
          </th>      
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
<a href="GameResultRecords.jsp?select=<%=sel%>&userid=<%=userid%>&pageIndex=1">&nbsp;����</a>
<a href="GameResultRecords.jsp?select=<%=sel%>&userid=<%=userid%>&pageIndex=<%=upPage%>">&nbsp;�W�@��</a>  
<a href="GameResultRecords.jsp?select=<%=sel%>&userid=<%=userid%>&pageIndex=<%=nextPage%>">&nbsp;�U�@��</a>
<a href="GameResultRecords.jsp?select=<%=sel%>&userid=<%=userid%>&pageIndex=<%=totalPages%>">&nbsp;����</a>

</body>
</html>