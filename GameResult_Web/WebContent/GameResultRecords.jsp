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

String gameid = request.getParameter(CommonString.PARAMETER_GAMEID);
if(gameid == null)
	gameid = EnumAllGamesList.GAME_1.getValue();
%>
<form name="selection" action="GameResultRecords.jsp" method="get"> �п�ܵ���
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
Date:<input name = <%=CommonString.PARAMETER_DATE%> id= <%=CommonString.PARAMETER_DATE%> type= "text" value = <%=date%>><br>
UerID:<input name = <%=CommonString.PAREMETER_USERID%> id= <%=CommonString.PAREMETER_USERID%> type= "text" value = <%=userid%>>
GameID:<input name = <%=CommonString.PARAMETER_GAMEID%> id = <%=CommonString.PARAMETER_GAMEID%> type= "text" value = <%=gameid%>>
<input type="submit" value="�e�X�d��" >
</form>
<br>

<script language="JavaScript">
  $(document).ready(function(){ 
    $("#date").datepicker({appendText: "�I�@�U��ܤ��", firstDay: 1,  dateFormat: 'yy/mm/dd'});
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
	          <a href="PlayerDetail.jsp?<%=CommonString.PAREMETER_USERID%>=<%=map.get(CommonString.PAREMETER_USERID)%>" target = "_blank">
	            <%=map.get(CommonString.PAREMETER_USERID)%>
	          </a>
 		  </th> 
          <th><%=map.get(CommonString.PARAMETER_GAMEID)%></th>
          <th><%=map.get(CommonString.BETTING)%></th>  
          <th><%=map.get(CommonString.LINE)%></th>  
          <th><%=map.get(CommonString.RESULTS)%></th>
          <th><%=map.get(CommonString.ROUNDSTATUS)%></th>  
          <th><%=map.get(CommonString.PRIZERESULTS)%></th>  
          <th><%=map.get(CommonString.BEFOREBALANCE)%></th> 
          <th><%=map.get(CommonString.AFTERBALANCE)%></th>  
          <th><%=map.get(CommonString.SPECIALNUMBER)%></th>  
          <th><%=map.get(CommonString.RESULTSDATE)%></th>
          <th>
          <%
          	String jsonstring = map.get(CommonString.RESULTSPARAMS);
          	GameResultJsonParser ps = JSON.parseObject(jsonstring, GameResultJsonParser.class);
          	for(int j = 0; j < 15; j++) {
				String text = "<img src=\"images/i"+ ps.slot1[j] + ".png\" />";
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
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=gameid%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=1">&nbsp;����</a>
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=gameid%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>">&nbsp;�W�@��</a>  
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=gameid%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>">&nbsp;�U�@��</a>
<a href="GameResultRecords.jsp?<%=CommonString.PARAMETER_SELECT%>=<%=sel%>
	&<%=CommonString.PARAMETER_DATE%>=<%=date%>
	&<%=CommonString.PAREMETER_USERID%>=<%=userid%>
	&<%=CommonString.PARAMETER_GAMEID%>=<%=gameid%>
	&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>">&nbsp;����</a>

</body>
</html>