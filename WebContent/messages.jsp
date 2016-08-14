<%@ page contentType="text/html; charset=UTF-8"%>
<%
  String message=(String)session.getAttribute("mess");
  if(message==null)
	  message="";
  session.invalidate();
%>
<html>
	<head>
    	<title>友情提示</title>
    	<link style="text/css" rel="stylesheet" href="css/style.css">    	
	</head>
	<body bgcolor="#F0F0F0">
	  <center>
        <table border="0" width="760" height="620" background="images/bg.jpg">
            <tr>
            	<td>
            		<table border="0" cellspacing="0" cellpadding="0" width="333" style="margin-top:200;margin-left:118">
            			<tr height="74"><td background="images/messT.jpg"></td></tr>
			            <tr height="100">
            			    <td align="center" bgcolor="#7688AD">
			                	<font color="white"><%=message%></font>
            			    </td>
			            </tr>
            			<tr height="114">
            				<td background="images/messE.jpg" align="center" valign="top">
			                    <a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a>
            			        &nbsp;&nbsp;&nbsp;
			                    <a href="vote.jsp"><img src="images/backB.jpg" style="border:0"></a>
            			        &nbsp;&nbsp;&nbsp;
			                    <a href="showChart.jsp"><img src="images/showB.jpg" style="border:0"></a>
            				</td>
            			</tr>
            		</table>
            	</td>
            </tr>
        </table>
      </center>
	</body>
</html>
