<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>	
<title>後端查詢首頁</title>
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

<table>
	<tr>
		<th><a href = "OnlineMember.jsp" target = "_blank">玩家在線清單</a></th>
		<th><a href = "AllGamesOnlinePlayers.jsp" target = "_blank">遊戲在線人數清單</a></th>
		<th><a href = "OnlinePeopleCountsReport.jsp" target = "_blank">遊戲在線人數日報表</a></th>
		<th><a href = "OnlinePeopleCountsReportMonth.jsp" target = "_blank">遊戲在線人數月報表</a></th>
		<th><a href = "OnlinePeopleCountsReportYear.jsp" target = "_blank">遊戲在線人數年報表</a></th>
		<th><a href = "GameResultRecords.jsp" target = "_blank">賽果查詢</a></th>
	</tr>
</table>

</body>
</html>