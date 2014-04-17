<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*,java.util.*"%>
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
				width:150px;
				height:30px;
			}
			tr{
				border:1px solid #0066CC;
				background-color:#00CC00 ;
			}
			tr:hover{
				background-color:#993300 ;
			}
			.bt:hover{
				background-color:#00cc00;
			}
			form{
				margin-left:100px;
			}
		</style>
		
        <script>
		CanvasRenderingContext2D.prototype.sector = function (x, y, radius, sDeg, eDeg) {
// 初始保存
this.save();
// 位移到目标点
this.translate(x, y);
this.beginPath();
// 画出圆弧
this.arc(0,0,radius,sDeg, eDeg);
// 再次保存以备旋转
this.save();
// 旋转至起始角度
this.rotate(eDeg);
// 移动到终点，准备连接终点与圆心
this.moveTo(radius,0);
// 连接到圆心
this.lineTo(0,0);
// 还原
this.restore();
// 旋转至起点角度
this.rotate(sDeg);
// 从圆心连接到起点
this.lineTo(radius,0);
this.closePath();
// 还原到最初保存的状态
this.restore();
return this;
}
		window.onload = function draw()
		{
			var canvas = document.getElementById('canvas');
			var context = canvas.getContext('2d');
			var a  = document.getElementById('fg').value;
			var b = document.getElementById('fg_').value;
			//alert(b);
			var c = b/a*100;
			
			c =(c.toString()).substring(0,4);
			document.getElementsByTagName('label').item(0).innerHTML='出勤率:'+c+'%';
			
			
			context.fillStyle='#0f0';
			context.sector(100,100,50,0,2*b/a*Math.PI).fill();
			context.fillStyle="#f00";
			context.sector(100,100,50,2*b/a*Math.PI,2*Math.PI).fill();
			
			
		}
		$(document).ready(function(e) {
            $('tr').each(function(index, element) 
			{
            	if(index >0)
            	{
					if($(this).find('#td').text() == '是')
					{
						$(this).find('a').hide();
					}
            	}
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
	
%>

 <body style="overflow:scroll; text-align:center;  background-attachment:fixed;">
        <div class="title">
           <h1>&nbsp;</h1>
           <h2>&nbsp;</h2>  
        </div>
       <div class="info" style="height:auto; width:1270px; box-shadow:none">
        	<div class="info_02" style="width:auto; height:auto; folat:left">
            	<h2>&nbsp;</h2>
               
            	<p>实验出勤情况一览表</p>
                <hr>
                <p>&nbsp;<a href="information_" style="margin-left:550px;">教师主页</a></p>
          		<table>
                <tr class="bt">
                	<td>学号</td><td style="width:80px;">姓名</td><td>班级</td><td style="width:80px;">是否到课</td><td style="width:80px;">缺课次数</td><td style="width:80px;">记录缺课</td>
                </tr>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	DBConnection conn_ = new DBConnection(context);
                	sql = "select * from class_info where teacher=? and class=? and time=?";
                	//String sql_ = "update class_info set count=? where s_name=? and teacher=? and time=?";
					//String sql_ = "update class_info set count=? where s_name=? and teacher=? and time=?";
					
                	PreparedStatement ps_ = null;
                	ps = conn.preparedStatement(sql);
					String teacher = (String)session.getAttribute("name");
					String class_ = request.getParameter("class_");
					String time = request.getParameter("time");	
					if(class_ ==null)
						class_ = (String)session.getAttribute("class_");
					if(time ==null)
						time = (String)session.getAttribute("time");
					//session.setAttribute("class_", class_);
					//session.setAttribute("time",time);
					System.out.println(teacher+" "+class_+" "+session.getAttribute("time"));
					ps.setString(1, teacher);
					ps.setString(2, class_);
					ps.setString(3, time);
					rs = conn.executeQuery();
					//ps_ = conn_.preparedStatement(sql_);
					if(rs == null) System.out.println("空");
					int fg = 0,fg_ = 0;
				%>
					
				<%
					while(rs.next())
					{
						fg++;
						%>
					<tr>
                    	<td><%=rs.getString("s_number")%></td>
                        <td style="width:80px;"><%=rs.getString("s_name")%></td>
                        <td><%=rs.getString("class")%></td>
                    	<td style="width:80px;" id="td"><%=rs.getString("flag")%></td>
                        <td style="width:80px;"><%=rs.getString("count")%></td>
                        <td class="bt" style="width:80px;"><a href="add_count?id=<%=rs.getString("s_number")%>&count=<%=rs.getString("count")%>&time=<%=time %>" >记录缺课</a></td>
                    </tr>    
					<%
						
						
					if(rs.getString("flag").equals("是"))
					{
						fg_++;
					}
					}
					
					
					%>          
               
                
               
                
                </table>
               
          </div>
          <div  class="info_01" style=" width:15%; margin-left:10px; margin-top:100px; background-color:#CFF; text-align:center;">
            	<canvas id="canvas" style="margin-top:0px;">
            	
            	</canvas>
            	<label></label>
            </div>
      </div>
      <input  id="fg" value=<%=fg%>  hidden="true"/>
      <input  id="fg_" value=<%=fg_%>  hidden="true"/>
</body>
</html>