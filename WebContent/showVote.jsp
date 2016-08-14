<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="valuebean.VoteSingle" %>
<jsp:useBean id="myDb" class="toolbean.DB"/>
<%
  float numAll=0;
  String sql="select * from tb_vote order by vote_order";
  List showlist=myDb.selectVote(sql);
%>
<html>
	<head>
    	<title>在线投票</title>
    	<link style="text/css" rel="stylesheet" href="css/style.css">    	
	</head>
	<body bgcolor="#F0F0F0">
	  <center>
        <table border="0" cellspacing="0" cellpadding="0" width="760" height="620" background="images/showbg.jpg">
            <tr height="20">
                <td valign="top" width="40%">
                    <table border="0" width="75%" cellspacing="0" cellpadding="0" style="margin-top:310;margin-left:45">
                    <% if(showlist==null||showlist.size()==0){ %>
                        <tr height="200"><td align="center" colspan="2">没有选项可显示！</td></tr>
                    <% 
                       }
                       else{
                    	   int i=0;
                    	   while(i<showlist.size()){
                    		   VoteSingle single=(VoteSingle)showlist.get(i);
                    		   numAll+=Integer.parseInt(single.getNum());
                    %>
                               <tr height="25">
                                     <td><%=single.getTitle() %></td>
                                     <td width="25%" align="right"><%=single.getNum() %> 票&nbsp;&nbsp;</td> 
                               </tr>                        
                    <% 
                               i++;
                    	   }
                       } 
                    %>
                        <tr height="25">
				           <td colspan="2"><a href="vote.jsp"><img src="images/backB.jpg" style="border:0"></a></td>
            			</tr>
                    </table>
                </td>
                <!-- 通过图片显示投票结果 -->
                <td valign="top" width="60%">
                    <table border="0" width="40%" cellspacing="0" cellpadding="0" style="margin-top:310;margin-left:20">
                    <% if(showlist==null||showlist.equals("")){ %>
                        <tr height="200"><td align="center" colspan="2">没有选项可显示！</td></tr>                    
                    <% 
                       }
                       else{
                    	   int i=0;
                    	   while(i<showlist.size()){
                    		   VoteSingle single=(VoteSingle)showlist.get(i);
                    		   int numOne=Integer.parseInt(single.getNum());
                    		   float picLen=numOne*145/numAll;						//计算图片长度
                    		   float per=numOne*100/numAll;							//计算票数所占的百分比
                    		   float doPer=((int)((per+0.05f)*10))/10f;				//保留百分比后的一位小数，并进行四舍五入
                    %>
                        <tr height="25">
                            <td><img src="images/count.jpg" width="<%=picLen%>" height="15" alt="影片：<%=single.getTitle()%>"></td>
                            <td width="15%" align="right"><%=doPer%>%</td>
                        </tr>
                    <%
                               i++;
                    	   }
                       } 
                    %>
                        <tr height="25">
				           <td colspan="2" align="right"><a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a></td>
            			</tr>
                    </table>                
                </td>
            </tr>
        </table>
      </center>
	</body>
</html>