<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生出勤情况</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
        <script src="js/jquery-2.1.0.min.js"></script>
        <style>
			table{
				border:solid 1px #0066CC;
			}
			td{
				border: 1px solid #000;
				width:150px;;
				height:30px;
			}
			tr{
				border:1px solid #0066CC;
				background-color:#00CC00 ;
			}
			tr:hover{
				background-color:#993300   ;
			}
			form{
				margin-left:100px;
			}
		</style>
        <script>
			window.onload = function draw()
{
	var canvas = document.getElementById('canvas');
	var context = canvas.getContext('2d');
	context.beginPath();
	context.arc(50,50,50,0,2*Math.PI);
	context.fillStyle='rgba(0,255,0,1)';
	context.fill();
	
	
	
	
	
	
}
		</script>
</head>
<%!
	
	DBConnection conn=null;
	PreparedStatement ps	= null ;
	ResultSet rs = null;
	ServletContext context = null;
	String sql = null;
%>

 <body style="overflow:scroll; text-align:center;  background-attachment:fixed;">
       <!-- <div class="title">-->
           <h1>&nbsp;</h1>
           <h2>&nbsp;</h2>  
            <h2>&nbsp;</h2> 
       <!-- </div>-->
       
       <div class="info" style="height:auto; width:100%; box-shadow:none">
       
        	<div class="info_02" style="width:50%; height:auto;  float:left;">
            	
                
               
            	<p>出勤情况一览表</p>
                <hr>
                <p>&nbsp;<a href="information_" style="margin-left:550px;">教师主页</a></p>
               
          		<table>
                <tr>
                	<td>学号</td><td>姓名</td><td>班级</td><td>缺课次数</td>
                </tr>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	DBConnection conn_ = new DBConnection(context);
                	sql = "select * from class_info where teacher=? and class=? and time=?";
                	String sql_ = "update class_info set count=? where s_name=? and teacher=? and time=?";
                	PreparedStatement ps_ = null;
                	ps = conn.preparedStatement(sql);
					String teacher = (String)session.getAttribute("name");
					String class_ = request.getParameter("class_");
					String time = request.getParameter("time");	
					System.out.println(teacher+" "+class_+" "+time);
					ps.setString(1, teacher);
					ps.setString(2, class_);
					ps.setString(3, time);
					rs = conn.executeQuery();
					ps_ = conn_.preparedStatement(sql_);
					if(rs == null) System.out.println("空");
				%>
					
				<%
					while(rs.next())
					{%>
					<tr>
                    	<td><%=rs.getString("s_number")%></td><td><%=rs.getString("s_name")%></td><td><%=rs.getString("class")%></td>
                    	<td><%=rs.getString("count")%></td>
                    </tr>    
					<%
					}
					%>          
               
                
               
                
                </table>
              
            </div>
             <div  class="info_01" style=" width:20%; margin-left:20px; margin-top:100px; background-color:#CFF;">
            	<canvas id="canvas" style="margin-top:0px;">
            	
            	</canvas>
            	出勤率:100%
            </div>
           
        </div>
                   
       
       
</body>
</html>