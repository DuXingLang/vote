<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="valuebean.TempSingle" %>
<%@ page import="toolbean.MyTools" %>
<%@ page import="java.util.Date" %>

<jsp:useBean id="myDb" class="toolbean.DB"/>
<%
  String mess="";
  String selectId=request.getParameter("ilike");			//获取用户选择
  if(selectId==null||selectId.equals("")){					//没有选择
	  mess="请选择投票！";
  }
  else{	  													//选择了
	  boolean mark=false;											//是否允许投票的标志
	  long today=(new Date()).getTime();							//new Date()获取当前时间，通过调用Date类的getTime()方法获取从1970年1月1日00:00:00起到当前时间的毫秒数
	  long last=0;													//上次投票的时间(以毫秒显示)
	  String ip=request.getRemoteAddr();							//获取用户IP地址
	  String sql="SELECT * FROM tb_temp WHERE voteMSEL = (SELECT MAX(voteMSEL) FROM tb_temp WHERE voteIp='"+ip+"')";	//SQL语句，功能：从数据表中获取当前用户上次投票时的记录
	  TempSingle single=myDb.selectTemp(sql);
	  if(single==null)											//在tb_temp表中不存在当前IP
	  	mark=true;														//允许投票
	  else{														//存在当前IP，则判断从上次投票到现在是否超过指定时间，本系统指定为60分钟
 	      last=single.getVoteMSEL();									//从该JavaBean中获取上次投票的时间(以毫秒显示)
 	      String result=MyTools.compareTime(today,last);				//将现在时间与上次投票时的时间进行比较
	      if(result.equals("yes"))										//返回"yes"，表示时间差已超过60分钟，允许投票
	    	  mark=true;
  	      else															//否则，不允许投票
    		  mark=false;		  
  	  }	  
  
	  String strTime=MyTools.formatDate(today);					//将当前投票时间(以毫秒显示的)转为"年-月-日 时:分:秒"的形式
	  if(mark){													//允许投票
		  /** 【1】记录用户IP和投票时间 **/
		  sql="insert into tb_temp(voteIp,voteMSEL,voteTime) values('"+ip+"','"+today+"','"+strTime+"')";
		  int i=myDb.update(sql);
       	  
		  /** 【2】判断记录用户IP是否成功 **/
		  if(i<=0)														//记录IP失败						
			  mess="系统在记录您的IP地址时出错！";
		  else{															//记录IP成功
			  /** 更新票数 **/
   			  sql="update tb_vote set vote_num=vote_num+1 where id="+selectId;
    		  i=myDb.update(sql);												//更新成功
	    	  if(i>0)
		    	  mess="投票生效！ <img src='images/spic.jpg'>";
   			  else																//更新失败
    			  mess="投票失败！";		  
		  }
	  }
	  else{														//不允许投票
		  mess="对不起，通过判断您的IP，您已经投过票了！<br>上次投票时间："+single.getVoteTime()+"<br>60分钟之内不允许再进行投票！";
	  }
  }

  session.setAttribute("mess",mess);						//保存提示信息到session范围内
  response.sendRedirect("messages.jsp");					//将请求重定向到messages.jsp页面，进行提示
%>