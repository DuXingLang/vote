<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="valuebean.VoteSingle" %>
<jsp:useBean id="myDb" class="toolbean.DB"/>
<%
  response.addHeader("Pragma","No-cache");
  response.addHeader("Cache-Control","no-cache");
  response.addDateHeader("Expires",1L);
  
  String sql="select * from tb_vote order by vote_order";
  List votelist=myDb.selectVote(sql);  
%>
<html>
	<head>
    	<title>在线投票</title>
    	<link style="text/css" rel="stylesheet" href="css/style.css">    	
    </head>
	<body bgcolor="#F0F0F0">
	  <center>
        <form action="doVote.jsp" method="post">
        <table border="0" width="760" height="620" background="images/bg.jpg">
            <tr height="20">
                <!-- 显示投票选项 -->
                <td valign="top" width="420">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:240;margin-left:51" bgcolor="#7688AE">
                        <tr height="75"><td align="center" colspan="2" background="images/voteT.jpg"></td></tr>
                    <!-- 如果集合为空 -->
                    <% if(votelist==null||votelist.size()==0){ %>
                        <tr height="200"><td align="center" colspan="2">没有选项可显示！</td></tr>
                    <!-- 如果集合不为空 -->
                    <% 
                       }
                       else{
                    %>
                    	<tr>
                    		<td align="center" width="60%">
                    			<table border="0" width="100%">
                    <%
                    	   int i=0;
                    	   while(i<votelist.size()){
                    		   VoteSingle single=(VoteSingle)votelist.get(i);                    	   
                    %>
                               		<tr height="27">
                                    	<td style="text-indent:7"><%=single.getTitle() %></td>
	                                    <td width="30%" align="center"><input type="radio" name="ilike" value="<%=single.getId() %>"></td> 
    		                        </tr>                        
                    <% 
                               i++;
                    	   }
                    %>
                       				<tr>
                       					<td>&nbsp;</td>
                       					<td>&nbsp;</td>
                       				</tr>
                       			</table>
                    		</td>
                    		<td valign="top">
                    			<img src="images/note.jpg"> <b><font color="white">注意事项：</font></b>
                    			<p><font color="#FDE401"><li>1小时内只能投一次票！</li></font>
                    			<p><a href="addOption.jsp"><font color="#FDE401"><li>添加电影选项>></li></font></a></p>
                    		</td>
                    	</tr>
                    <%
                       } 
                    %>
                        <!-- 显示操作按钮 -->
                        <tr height="97">
                            <td align="center" valign="top" colspan="2" background="images/voteE.jpg">
                                <input type="submit" value="" style="background-image:url(images/submitB.jpg);width:68;height:26;border:0">
                                <input type="reset" value="" style="background-image:url(images/resetB.jpg);width:68;height:26;border:0">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="showChart.jsp"><img src="images/showB.jpg" style="border:0"></a>
                                <a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a>
                            </td>                            
                        </tr>
                    </table>
                </td>
            </tr>
        </table> 
        </form>               
      </center>
	</body>
</html>