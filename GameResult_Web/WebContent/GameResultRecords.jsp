<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.dao.GameResultRecords" %>
<%@ page import="com.dao.GameResultJsonParser" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.dao.EnumAllGamesList"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="com.dao.EnumSelectionList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

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
    text-align: center;
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
String sel = request.getParameter(CommonString.PARAMETER_SELECT);
if(sel == null)
	sel = "5";

String userid = request.getParameter(CommonString.PAREMETER_USERID);
if(userid == null)
	userid = CommonString.TEST_UESRID;

String date = request.getParameter(CommonString.PARAMETER_DATE);
if(date == null) {
	java.util.Date c_date = new java.util.Date();
	SimpleDateFormat trans = new SimpleDateFormat(CommonString.YYYYMMDD);
	date = trans.format(c_date);
}

String sel_gameID = request.getParameter(CommonString.PARAMETER_GAMEID);
if(sel_gameID == null)
	sel_gameID = EnumAllGamesList.GAME_0.getValue();
%>
<form name="selection" action="GameResultRecords.jsp" method="post">
&nbsp;請選擇筆數&nbsp;
<select name=<%=CommonString.PARAMETER_SELECT%> size="1" id=<%=CommonString.PARAMETER_SELECT%> onChange="change()">
<option value=<%=EnumSelectionList.SELECT_5.getValue()%>
	<%if (sel == null || sel.equals(EnumSelectionList.SELECT_5.getValue()))  {%>
		selected <%}%>><%=EnumSelectionList.SELECT_5.getValue()%></option>
<option value=<%=EnumSelectionList.SELECT_10.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_10.getValue())) {%>
		selected <%}%>><%=EnumSelectionList.SELECT_10.getValue()%></option>
<option value=<%=EnumSelectionList.SELECT_25.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_25.getValue())) {%>
		selected <%}%>><%=EnumSelectionList.SELECT_25.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_50.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_50.getValue())) {%>
		selected <%}%>><%=EnumSelectionList.SELECT_50.getValue()%></option> 
<option value=<%=EnumSelectionList.SELECT_100.getValue()%>
	<%if (sel != null && sel.equals(EnumSelectionList.SELECT_100.getValue())){%>
		selected <%}%>><%=EnumSelectionList.SELECT_100.getValue()%></option> 
</select>
<br>
&nbsp;賽果建立時間&nbsp;<input name = <%=CommonString.PARAMETER_DATE%> 
							id= <%=CommonString.PARAMETER_DATE%>
							type= "text" value = <%=date%>><br>
&nbsp;請選擇遊戲&nbsp;
<select name="gameID" size="ALL" id="gameID" onChange="change()">
<option value=<%=EnumAllGamesList.GAME_0.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_0.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_0.getValue()%></option>
<option value=<%=EnumAllGamesList.GAME_1.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_1.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_1.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_2.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_2.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_2.getValue()%></option>		
<option value=<%=EnumAllGamesList.GAME_3.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_3.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_3.getValue()%></option> 		
<option value=<%=EnumAllGamesList.GAME_4.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_4.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_4.getValue()%></option> 
<option value=<%=EnumAllGamesList.GAME_5.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_5.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_5.getValue()%></option> 
<option value=<%=EnumAllGamesList.GAME_6.getValue()%>
	<%if (sel_gameID != null && sel_gameID.equals(EnumAllGamesList.GAME_6.getValue())) {%>
		selected <%}%>><%=EnumAllGamesList.GAME_6.getValue()%></option> 
</select><br>
&nbsp;玩家唯一碼&nbsp;<input name=<%=CommonString.PAREMETER_USERID%>
						   id=<%=CommonString.PAREMETER_USERID%>
						   type= "text" value = <%=userid%>>
<input type="submit" value="送出查詢" >

<br>

<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "點一下顯示日曆", firstDay: 1,  dateFormat: 'yy/mm/dd'});
  });
</script>

<%
int pageSize = 5;
pageSize = Integer.parseInt(sel);

GameResultRecords ed = new GameResultRecords();
int totalPages = ed.getTotalPage(pageSize, userid, date, sel_gameID);

String currentPage = request.getParameter("pageIndex");
if(currentPage==null)  
    currentPage="1";  
 
int pageIndex = Integer.parseInt(currentPage);  
if(pageIndex < 1){  
    pageIndex = 1;  
}else if(pageIndex > totalPages){  
    pageIndex = totalPages;  
}

List<Map<String, String>> list = ed.getAllRecordsByPage(pageSize, pageIndex, userid, date, sel_gameID);
%>

<table style="border:1px #FFAC55 solid; padding:1px; text-align:center; font-size:18px;" rules="all" cellpadding='5' width = "1280">
	<tr>
		<th>時間</th>
	    <th>押注編號</th>
	    <th>玩家編碼</th>
	    <th>押金</th>
	    <th>線數</th>
	    <th>贏金</th>
	    <th>代理商 </th>
	    <th>注單號碼(BG)</th>
	    <th>轉輪結果</th>
	</tr>
	<%  
	  Map<String, String> map=null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
      <tr>

      	  <th><%=map.get(CommonString.RESULTSDATE)%></th>
          <th><%=map.get(CommonString.ROUNDUUID)%></th>  
          <th>
	          <a href="PlayerDetail.jsp?
	          	<%=CommonString.PAREMETER_USERID%>=<%=map.get(CommonString.PAREMETER_USERID)%>" target = "_blank">
	            <%=map.get(CommonString.PAREMETER_USERID)%>
	          </a>
 		  </th>
          <th><%=map.get(CommonString.BETTING)%></th>  
          <th><%=map.get(CommonString.LINE)%></th>
          <th><%=map.get(CommonString.RESULTS)%></th>
          <th><%=map.get(CommonString.AGENT)%></th>
          <th><%=map.get(CommonString.ORDERID)%></th>
          <th width = "30%">
          <%
          	String jsonstring = map.get(CommonString.RESULTSPARAMS);
          	GameResultJsonParser ps = JSON.parseObject(jsonstring, GameResultJsonParser.class);
          	for(int j = 0; j < 15; j++) {
				String text = "<img src=\"images/i"+ ps.Wheel[j] + ".png\" height=56 width=56 />";
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
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;首頁</a>
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;上一頁</a>  
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;下一頁</a>
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=sel_gameID%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;末頁</a>
到第&nbsp;<input name= "pageIndex" id= "pageIndex" type= "text" value=<%=pageIndex%>>頁
</form>						   
</body>
</html>