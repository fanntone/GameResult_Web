<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="com.dao.PlayerDetail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>


<img src="images/1.png" />
<img src="images/2.png" />
<img src="images/3.png" />
<img src="images/4.png" />
<img src="images/5.png" />
<br>
<img src="images/6.png" />
<img src="images/7.png" />
<img src="images/8.png" />
<img src="images/9.png" />
<img src="images/10.png" />
<br>
<img src="images/11.png" />
<img src="images/12.png" />
<img src="images/13.png" />
<img src="images/14.png" />
<img src="images/1.png" />

<br>
<%String  ssss = "'{\"slot1\":[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 1]}'"; %>
<p id="demo"></p>
<script>
var text = "";
var jsontext = '{"slot1":[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 1]}';
var contact = JSON.parse(<%=ssss%>);
var i;
for(i = 0; i< 15 ; i++) {
	var str;
	str = contact.slot1[i];
	text += "<img src=\"images/"+ contact.slot1[i] + ".png\" />";
	var j = i+1;
	if(j%5==0)
		text += "<br>";
}
document.getElementById("demo").innerHTML = text;
</script>

<br>

</body>
</html>