<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>	
<title>SELECT Operation</title>
</head>
<body>
 <form name="form1" onsubmit="checkBoxValidation()">
     <h3>Please insert data then press submit button</h3>
     <p>Search 玩家唯一碼 :  <input type="text" name="id" value="0"/><input type="submit" value="submit"/></p>
 </form>
<% 
String submit= request.getParameter("id");
%>

<table border="11" width="100%">
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
Class.forName("com.mysql.jdbc.Driver").newInstance();
String url = "jdbc:mysql://10.36.1.102:3306/TEST";
String user = "root";
String pwd = "3edc2wsx!QAZ";
Connection conn= DriverManager.getConnection(url, user, pwd); 
Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 

String sql = "";
ResultSet rs = null;
if(submit != null && submit.length() != 0)
	sql = "select * from resultsRecords where userID = " + submit;
else
	sql = "select * from resultsRecords";
rs = stmt.executeQuery(sql);

while(rs.next()){%>
<tr>
	<%for(int i = 1 ; i < 14; i ++) {%>
		<td><%=rs.getString(i)%></td>
	<%}%>
</tr>
<%}%>
</table>

<%

if(stmt != null)
	stmt.close();
if(conn != null)
	conn.close(); 
%>
 
</body>
</html>