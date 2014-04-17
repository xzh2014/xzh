<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>技能测试</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
<style>
	ul{
		margin-top:10px;
	}
	li{
		list-style:none;
		width:500px;
		height:40px;
		margin-top:10px;
		font-size:18px;
		border:solid 1px  #999933;
	}
	li:hover{
		background-color:#CFC;
		cursor:pointer;
	}
	
</style>
<script src="js/jquery-2.1.0.min.js"></script>
<script>
$(document).ready(function(e) {
    $('div.answer').hide();
	$('li.li').click(function(e) {
		if($('span',this).text() == $('#answer').val())
		{
			//alert('');
			$(this).css('background-color','#0F0');
		}
		else
		{
			$(this).css('background-color','#F00');	
		}
        $('div.answer').show();	
    });
	
});
</script>
      
</head>
<%!
	
	DBConnection conn=null;
	PreparedStatement ps	= null ;
	ResultSet rs = null;
	ServletContext context = null;
	String sql = null;
	String class_ =null;
	String time = null;
	String  Lx = null;
%>

 <body style="overflow:scroll; text-align:center;  background-attachment:fixed;">
        <div class="title">
           <h1>&nbsp;</h1>
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
        </div>
        <div class="info" style=" width:75%; height:auto; box-shadow:0px 0px 0px 0px #FFFFFF;">
        	 <div class="info_02" style=" width:100%; height:auto; ">
            	
            	<p>技能测试<a href="index" style="margin-left:850px;">首页</a></p>
                <hr>
               
                <form method="get" action="">
                选择测试题类型:<select name="Lx" id="class_" style="width:200px; height:30px; font-size:16px;">
                <option value='' selected="selected">
                	请选择...					
                </option>
                <option value='%'>
                	综合					
                </option>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	sql = "select distinct Lx from subject";
                	ps = conn.preparedStatement(sql);
                	rs = conn.executeQuery();
								
				%>
				<%
					while(rs.next())
					{%>
						<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>      
					<%
					
					}
					conn.closeDB();
					%>          
                </select>
                <input type="submit" value="开始测试" style="width:auto; cursor:pointer;" id="sub"/>
                </form>
            </div>
       
        
       <div  id="div_t" style=" text-align:left; height:700px;">
<%
	if(request.getParameter("Lx") !=null)
	{
		context = request.getServletContext();
		conn = new DBConnection(context);
		Lx = request.getParameter("Lx");
		String name = (String)session.getAttribute("name");
		long time = (new java.util.Date()).getTime();
		System.out.println(time);
		//sql = "select * from subject  where Lx like ? ORDER BY RAND() limit 1";
		sql = "select * from subject  where Lx like ? ORDER BY RAND("+time+") limit 1";
		ps = conn.preparedStatement(sql);
		ps.setString(1,Lx);
		rs = conn.executeQuery();	
		if(Lx.equals("%"))
		{
			Lx = "%25";
		}
		else if(Lx.equals("c++"))
		{
			Lx = "c%2B%2B";
		}
		while(rs.next())
		{	
			
	%>		<div style="margin-top:10px; margin-left:50px; background-color:#FFF;width:60%;height:400px; float:left;">
    		<p>&nbsp;</p>
    		<label><%=rs.getString("question")%></label>
    		<ul>
            	<li class="li"><span>A</span>&nbsp;&nbsp;<%=rs.getString("A")%></li>
                <li class="li"><span>B</span>&nbsp;&nbsp;<%=rs.getString("B")%></li>
                <li class="li"><span>C</span>&nbsp;&nbsp;<%=rs.getString("C")%></li>
                <li class="li"><span>D</span>&nbsp;&nbsp;<%=rs.getString("D")%></li>
                <a href="?Lx=<%=Lx%>" style="text-decoration:none; color:#000; "><li>&nbsp;&nbsp;下一题</li></a>
            </ul>
            </div>
            <div style="width:30%; height:400px; float:left;">
            <div style=" background-image:url(images/answer_bodybg.png); margin-top:10px; width:100%; height:300px; font-size:18px;" class="answer">
            <input type="hidden" id="answer" value="<%=rs.getString("answer")%>"/>
            <p>正确答案:&nbsp;<%=rs.getString("answer")%></p>
            <p>知识卡片:</p>
            <p>&nbsp;</p>
             <%=rs.getString("Xj")%>
            </div>
            </div>
    		
		
		<%
		
		}
		conn.closeDB();
	}
	%>
	
    
   
    </div>
     </div>
   
       
       
</body>
</html>