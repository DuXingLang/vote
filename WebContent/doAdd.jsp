<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="valuebean.VoteSingle" %>
<%@ page import="toolbean.MyTools" %>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加电影选项</title>
</head>
<body>
<%
	String name =new String((request.getParameter("movieName")).getBytes("ISO-8859-1"),"gb2312");
	//String name = request.getParameter("movieName");
	for (int i = 0; i < votelist.size(); i++) {
		VoteSingle voteSingle = (VoteSingle) votelist.get(i);
		if (name.equals(voteSingle.getTitle())) {
			%>
			<script type="text/javascript">
				alert("您输入的电影已存在！");
				window.location.href="addOption.jsp";
			</script>
			<%
			return;
		}
	}
	int id = votelist.size()+1;
	int num = 0;
	int order = votelist.size()+1;
	String sql1 = "insert into tb_vote values(" + id + ",'" + name
					+ "'," + num + "," + order + ")";
	myDb.update(sql1);
	response.sendRedirect("vote.jsp");
%>
</body>
</html>