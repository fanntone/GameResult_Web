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
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.dao.EnumAllGamesList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<style>
  article,aside,figure,figcaption,footer,header,hgroup,menu,nav,section {display:block;}
  body {font: 62.5% "Trebuchet MS", sans-serif; margin: 50px;}
</style>
<title>賽果資訊</title>
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
	userid = "1001001";

String date = request.getParameter("datepicker1");
if(date == null) {
	java.util.Date c_date = new java.util.Date();
	SimpleDateFormat trans = new SimpleDateFormat("YYYY/MM/dd");
	date = trans.format(c_date);
}

String gameid = request.getParameter("gameid");
if(gameid == null)
	gameid = EnumAllGamesList.GAME_1.getValue();
%>
<form name="selection" action="GameResultRecords.jsp" method="get"> 請選擇筆數
<select name="select" size="1" id="select" onChange="change()">
<option value="5"  <%if (sel == null || sel.equals("5"))  {%> selected <%}%>>5</option>
<option value="10" <%if (sel != null && sel.equals("10")) {%> selected <%}%>>10</option>
<option value="25" <%if (sel != null && sel.equals("25")) {%> selected <%}%>>25</option> 
<option value="50" <%if (sel != null && sel.equals("50")) {%> selected <%}%>>50</option> 
<option value="100"<%if (sel != null && sel.equals("100")){%> selected <%}%>>100</option>
</select><br>
Date:<input name = "datepicker1" id= "datepicker1" type= "text" value = <%=date%>><br>
UerID:<input name = "userid" id= "userid" type= "text" value = <%=userid%>>
GameID:<input name = "gameid" id = "gameid" type= "text" value = <%=gameid%>>
<input type="submit" value="送出查詢" >
</form>
<br>

<script language="JavaScript">
  $(document).ready(function(){ 
    $("#datepicker1").datepicker({appendText: "點一下顯示日曆", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>

<%
int pageSize = 5;
pageSize = Integer.parseInt(sel);

GameResultRecords ed = new GameResultRecords();
int totalPages = ed.getTotalPage(pageSize, userid, date, gameid);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalPages){  
    pageIndex = totalPages;  
}

List<Map<String, String>> list = ed.getAllRecordsByPage(pageSize, pageIndex, userid, date, gameid);
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
	    <th>下注後  玩家持有點數</th>
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

<p style="color:red">當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="GameResultRecords.jsp?select=<%=sel%>&datepicker1=<%=date%>&userid=<%=userid%>&pageIndex=1">&nbsp;首頁</a>
<a href="GameResultRecords.jsp?select=<%=sel%>&datepicker1=<%=date%>&userid=<%=userid%>&gameid=<%=gameid%>&pageIndex=<%=upPage%>">&nbsp;上一頁</a>  
<a href="GameResultRecords.jsp?select=<%=sel%>&datepicker1=<%=date%>&userid=<%=userid%>&gameid=<%=gameid%>&pageIndex=<%=nextPage%>">&nbsp;下一頁</a>
<a href="GameResultRecords.jsp?select=<%=sel%>&datepicker1=<%=date%>&userid=<%=userid%>&gameid=<%=gameid%>&pageIndex=<%=totalPages%>">&nbsp;末頁</a>

</body>
</html>