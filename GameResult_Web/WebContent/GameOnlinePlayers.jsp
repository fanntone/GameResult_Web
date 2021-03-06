<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.dao.GameOnlinePlayers"%>
<%@ page import="com.dao.EnumAllGamesList"%>
<%@ page import="com.dao.CommonString"%>
<%@ page import="com.dao.EnumSelectionList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	function change() {
		document.selection.submit();
	}
</script>
<%	String sel = request.getParameter(CommonString.PARAMETER_SELPAGESIZE);
	if(sel == null || sel == "" || sel.replaceAll("\\s","").isEmpty())
		sel = "5";
	String userID = request.getParameter(CommonString.PAREMETER_USERID);
	if(userID == null || userID == "" || userID.replaceAll("\\s","").isEmpty())
		userID = CommonString.ALL;
	String gameID = request.getParameter(CommonString.PARAMETER_SELPAGESIZE);
	if(gameID == null || gameID == "" || gameID.replaceAll("\\s","").isEmpty())
		gameID = CommonString.ALL;
%>
<form name="selection" action="GameOnlinePlayers.jsp" method="post">
&nbsp;請選擇筆數&nbsp;<select name=<%=CommonString.PARAMETER_SELPAGESIZE%> size="1" id=<%=CommonString.PARAMETER_SELPAGESIZE%> onChange="change()">
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
&nbsp;輸入玩家編號&nbsp;<input name=<%=CommonString.PAREMETER_USERID%>
						    id=<%=CommonString.PAREMETER_USERID%>
						    type="text" value=<%=userID%>><br>
&nbsp;輸入遊戲編號&nbsp;<input name=<%=CommonString.PARAMETER_GAMEID%>
							id=<%=CommonString.PARAMETER_GAMEID%>
							type="text" value=<%=gameID%>>
<input type="submit" value="送出查詢" >
<br>
<%
	int pageSize = 5;
	if(sel != null)
		pageSize = Integer.parseInt(sel);
	
	GameOnlinePlayers data = new GameOnlinePlayers();
	int totalPages = data.getTotalPage(pageSize, gameID, userID);
	
	String currentPage = request.getParameter(CommonString.PARAMETER_PAGEINDEX);
	if(currentPage == null || currentPage == "" || currentPage.replaceAll("\\s","").isEmpty())  
	    currentPage = "1";  
	
	int pageIndex = Integer.parseInt(currentPage);  
	if(pageIndex < 1) {  
	    pageIndex = 1;  
	} else if(pageIndex > totalPages){  
	    pageIndex = totalPages;  
	}
	List<Map<String, String>> list = data.getAllByPage(pageSize, pageIndex, gameID, userID);

	int nextPage = pageIndex + 1;
	if(nextPage > totalPages)
		nextPage = totalPages;
	
	int upPage = pageIndex - 1;
	if(upPage < 1)
		upPage = 1;
%>
<p style="color:red">&nbsp;當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=1
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;首頁</a>
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;上一頁</a>  
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;下一頁</a>
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;末頁</a>
到第&nbsp;<input name=<%=CommonString.PARAMETER_PAGEINDEX%> id=<%=CommonString.PARAMETER_PAGEINDEX%> type="text" value=<%=pageIndex%>>頁
<table style="border:1px #FFAC55 solid; padding:1px; text-align:center;" rules="all" cellpadding='5'>
	<tr>
	    <th>玩家編號(useID)</th>
	    <th>帳號餘額(Money)</th>
	    <th>所在遊戲(Game)</th>
	</tr>
	<%  
	  Map<String, String> map = null;  
	  for(int i = 0; i < list.size(); i++) {  
	      map = (Map<String, String>)list.get(i);
	%>
    <tr> 
        <th>
            <a href="PlayerDetail.jsp?<%=CommonString.PAREMETER_USERID%>=<%=map.get(CommonString.PAREMETER_USERID)%>" target="_blank">
               <%=map.get(CommonString.PAREMETER_USERID)%>
            </a>
        </th>
        <th><%=map.get(CommonString.BALANCE)%></th>
        <th><%=map.get(CommonString.PARAMETER_GAMEID)%></th>
    </tr>  
	<%}%>
</table>

<p style="color:red">&nbsp;當前頁數:<%=pageIndex%>/<%=totalPages%>
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=1
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;首頁</a>
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=upPage%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;上一頁</a>  
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=nextPage%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;下一頁</a>
<a href="GameOnlinePlayers.jsp?<%=CommonString.PARAMETER_SELPAGESIZE%>=<%=sel%>
		&<%=CommonString.PARAMETER_PAGEINDEX%>=<%=totalPages%>
		&<%=CommonString.PARAMETER_GAMEID%>=<%=gameID%>
		&<%=CommonString.PAREMETER_USERID%>=<%=userID%>">&nbsp;末頁</a>
到第&nbsp;<input name=<%=CommonString.PARAMETER_PAGEINDEX%> id=<%=CommonString.PARAMETER_PAGEINDEX%> type="text" value=<%=pageIndex%>>頁
</form>	
</body>
</html>