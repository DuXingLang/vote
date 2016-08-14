<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page import="org.jfree.chart.plot.PlotOrientation" %>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection" %>
<%@ page import="org.jfree.chart.ChartRenderingInfo" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@ page import="org.jfree.chart.StandardChartTheme"%>
<%@ page import="java.awt.Font"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List" %>
<%@ page import="valuebean.VoteSingle" %>
<%@ page import="toolbean.MyTools"%>
<jsp:useBean id="myDb" class="toolbean.DB"/>
<%
  float numAll=0;
  String sql="select * from tb_vote order by vote_order";
  List showlist=myDb.selectVote(sql);
%>
<html>
<head>
<title>图表显示投票结果</title>
	<link style="text/css" rel="stylesheet" href="css/show.css">
    <script type="text/javascript">
         
    // JS实现选项卡切换
        window.onload = function(){
             var oTab = document.getElementById("tabs");
             var oUl = oTab.getElementsByTagName("ul")[0];
             var oLis = oUl.getElementsByTagName("li");
             var oDivs= oTab.getElementsByTagName("div");

             for(var i= 0,len = oLis.length;i<len;i++){
                 oLis[i].index = i;
                 oLis[i].onclick = function() {
                     for(var n= 0;n<len;n++){
                         oLis[n].className = "";
                         oDivs[n].className = "hide";
                     }
                     this.className = "on";
                     oDivs[this.index].className = "";
                 }
             };
        }
    
 	</script>
 </head>
<body>
<center>
<!-- HTML页面布局 -->
<div id="tabs">
	<h3 class="title">投票结果显示</h3>
	<hr>
    <ul>
        <li class="on">表格</li>
        <li>柱形图</li>
        <li>饼图</li>
    </ul>
    <div>
    	<table width="400">
         	<% if(showlist==null||showlist.size()==0){ %>
         	<tr height="200"><td align="center" colspan="4">没有选项可显示！</td></tr>
         	<% 
         	}else{
              	int i=0;
              	int j=0;
              	while(j<showlist.size()){
              		VoteSingle single=(VoteSingle)showlist.get(j);
              		numAll+=Integer.parseInt(single.getNum());
              		j++;
              	}
              	while(i<showlist.size()){
              		VoteSingle single=(VoteSingle)showlist.get(i);
         		    int numOne=Integer.parseInt(single.getNum());
         		    float picLen=numOne*145/numAll;						//计算图片长度
         		    float per=numOne*100/numAll;							//计算票数所占的百分比
         		    float doPer=((int)((per+0.05f)*10))/10f;				//保留百分比后的一位小数，并进行四舍五入
         	%>
         	<tr height="25">
         		<td><%=single.getTitle() %></td>
            	<td width="30%" align="right"><%=single.getNum() %> 票&nbsp;&nbsp;</td> 
         		<td><img src="images/count.jpg" width="<%=picLen%>" height="15" alt="影片：<%=single.getTitle()%>"></td>
                <td width="15%" align="right"><%=doPer%>%</td>
         	</tr>                        
         	<% 
              		i++;
             	}
         	} 
         	%>
         	<tr height="25">
		 		<td colspan="2"><a href="vote.jsp"><img src="images/backB.jpg" style="border:0"></a></td>
         		<td colspan="2" align="right"><a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a></td>
         	</tr>
         </table>
    </div>
    <%
    StandardChartTheme standardChartTheme = new StandardChartTheme("CN");		//创建主题样式
    standardChartTheme.setExtraLargeFont(new Font("隶书", Font.BOLD, 20)); 		//设置标题字体
    standardChartTheme.setRegularFont(new Font("微软雅黑", Font.PLAIN, 15)); 		//设置图例的字体
    standardChartTheme.setLargeFont(new Font("微软雅黑", Font.PLAIN, 15)); 		//设置轴向的字体
    ChartFactory.setChartTheme(standardChartTheme);							//设置主题样式
    DefaultCategoryDataset dataset1=new DefaultCategoryDataset();
	for(int i=0;i<showlist.size();i++){
		VoteSingle single1=(VoteSingle)showlist.get(i);
		dataset1.addValue(MyTools.strToint(single1.getNum()),"", single1.getTitle());
	}
	//创建JFreeChart组件的图表对象
	JFreeChart chart=ChartFactory.createBarChart3D(
									"投票结果",		//图表标题
									"电影",		//x轴的显示标题
									"票数",			//y轴的显示标题
									dataset1,	//数据集
									PlotOrientation.VERTICAL,//图表方向(垂直)
									false,		//是否包含图例
									false,		//是否包含提示
									false		//是否包含URL
									);
	//设置图表的文件名
	// 固定用法
	ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
	String fileName=ServletUtilities.saveChartAsPNG(chart,400,270,info,session);
	String url=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName;
	%>
    <div class="hide">
		<img alt="投票结果" src="<%=url%>">
		<br/>
		<a href="vote.jsp"><img src="images/backB.jpg" style="border:0"></a>
		<a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a>
    </div>
    <%
    
	DefaultPieDataset dataset2=new DefaultPieDataset();
    for(int i=0;i<showlist.size();i++){
    	VoteSingle single2=(VoteSingle)showlist.get(i);
    	dataset2.setValue(single2.getTitle(), MyTools.strToint(single2.getNum()));
    }
	//创建JFreeChart组件的图表对象
	JFreeChart chart2=ChartFactory.createPieChart(
										"投票结果",	//图表标题
										dataset2,				//数据集
										true,					//是否包含图例
										false,					//是否包含图例说明
										false					//是否包含连接
										);
	//设置图表的文件名
	// 固定用法
	ChartRenderingInfo info2 = new ChartRenderingInfo(new StandardEntityCollection());
	String fileName2=ServletUtilities.saveChartAsPNG(chart2,400,270,info2,session);
	String url2=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName2;
	%>
    <div class="hide">
		<img alt="投票结果" src="<%=url2 %>">
		<br/>
		<a href="vote.jsp"><img src="images/backB.jpg" style="border:0"></a>
		<a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a>
    </div>
    
</div>
</center>
</body>
</html>