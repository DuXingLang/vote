<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加电影选项</title>
<link style="text/css" rel="stylesheet" href="css/style.css">    	
</head>
<body bgcolor="#F0F0F0">
	<center>
      <form action="doAdd.jsp" method="post">
        <table border="0" width="760" height="620" background="images/bg.jpg">
            <tr>
               <td style="padding-top:152;padding-left:150px;">
                   <p>电影名称：<input type="text" name="movieName" placeholder="请输入电影名称" style="width:200px;height:30px;"></p>
                   <p>
                      <input type="submit" value="提交" style="margin:0 80px;">
                      <a href="vote.jsp">返回>></a>
                   </p>
               </td> 
            </tr>
        </table> 
      </form>               
    </center>
</body>
</html>