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
<title>ͼ����ʾͶƱ���</title>
	<link style="text/css" rel="stylesheet" href="css/show.css">
    <script type="text/javascript">
         
    // JSʵ��ѡ��л�
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
<!-- HTMLҳ�沼�� -->
<div id="tabs">
	<h3 class="title">ͶƱ�����ʾ</h3>
	<hr>
    <ul>
        <li class="on">���</li>
        <li>����ͼ</li>
        <li>��ͼ</li>
    </ul>
    <div>
    	<table width="400">
         	<% if(showlist==null||showlist.size()==0){ %>
         	<tr height="200"><td align="center" colspan="4">û��ѡ�����ʾ��</td></tr>
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
         		    float picLen=numOne*145/numAll;						//����ͼƬ����
         		    float per=numOne*100/numAll;							//����Ʊ����ռ�İٷֱ�
         		    float doPer=((int)((per+0.05f)*10))/10f;				//�����ٷֱȺ��һλС������������������
         	%>
         	<tr height="25">
         		<td><%=single.getTitle() %></td>
            	<td width="30%" align="right"><%=single.getNum() %> Ʊ&nbsp;&nbsp;</td> 
         		<td><img src="images/count.jpg" width="<%=picLen%>" height="15" alt="ӰƬ��<%=single.getTitle()%>"></td>
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
    StandardChartTheme standardChartTheme = new StandardChartTheme("CN");		//����������ʽ
    standardChartTheme.setExtraLargeFont(new Font("����", Font.BOLD, 20)); 		//���ñ�������
    standardChartTheme.setRegularFont(new Font("΢���ź�", Font.PLAIN, 15)); 		//����ͼ��������
    standardChartTheme.setLargeFont(new Font("΢���ź�", Font.PLAIN, 15)); 		//�������������
    ChartFactory.setChartTheme(standardChartTheme);							//����������ʽ
    DefaultCategoryDataset dataset1=new DefaultCategoryDataset();
	for(int i=0;i<showlist.size();i++){
		VoteSingle single1=(VoteSingle)showlist.get(i);
		dataset1.addValue(MyTools.strToint(single1.getNum()),"", single1.getTitle());
	}
	//����JFreeChart�����ͼ�����
	JFreeChart chart=ChartFactory.createBarChart3D(
									"ͶƱ���",		//ͼ�����
									"��Ӱ",		//x�����ʾ����
									"Ʊ��",			//y�����ʾ����
									dataset1,	//���ݼ�
									PlotOrientation.VERTICAL,//ͼ����(��ֱ)
									false,		//�Ƿ����ͼ��
									false,		//�Ƿ������ʾ
									false		//�Ƿ����URL
									);
	//����ͼ����ļ���
	// �̶��÷�
	ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
	String fileName=ServletUtilities.saveChartAsPNG(chart,400,270,info,session);
	String url=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName;
	%>
    <div class="hide">
		<img alt="ͶƱ���" src="<%=url%>">
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
	//����JFreeChart�����ͼ�����
	JFreeChart chart2=ChartFactory.createPieChart(
										"ͶƱ���",	//ͼ�����
										dataset2,				//���ݼ�
										true,					//�Ƿ����ͼ��
										false,					//�Ƿ����ͼ��˵��
										false					//�Ƿ��������
										);
	//����ͼ����ļ���
	// �̶��÷�
	ChartRenderingInfo info2 = new ChartRenderingInfo(new StandardEntityCollection());
	String fileName2=ServletUtilities.saveChartAsPNG(chart2,400,270,info2,session);
	String url2=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName2;
	%>
    <div class="hide">
		<img alt="ͶƱ���" src="<%=url2 %>">
		<br/>
		<a href="vote.jsp"><img src="images/backB.jpg" style="border:0"></a>
		<a href="index.jsp"><img src="images/indexB.jpg" style="border:0"></a>
    </div>
    
</div>
</center>
</body>
</html>