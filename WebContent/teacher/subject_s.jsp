<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改删除试题</title>
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
				background-color:#993300 ;
			}
			form{
				margin-left:0px;
			}
		</style>
		
        <script>
		
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
       <div class="info" style="height:auto; width:1270; box-shadow:none">
        	<div class="info_02" style="width:100; height:auto;" >
            	<h2>&nbsp;</h2>
               
            	<p>试题一览表 <a href="information_" style="margin-left:550px;">教师主页</a></p>
                <hr>
                <p>&nbsp;</p>
          		<table>
                <tr>
                	<td>题号</td><td>题目</td><td>A</td><td>B</td><td>C</td><td>D</td><td>答案</td><td>试题类型</td><td>答案详解</td><td>修改</td><td>删除</td>
                </tr>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	sql = "select * from subject where teacher=? ";
                	ps = conn.preparedStatement(sql);
					ps.setString(1,(String)session.getAttribute("name"));
					rs = conn.executeQuery();
				%>
					
				<%
					while(rs.next())
					{
						%>
					<tr>
                    	<td><%=rs.getInt("id")%></td><td><%=rs.getString("question")%></td><td><%=rs.getString("A")%></td>
                    	<td><%=rs.getString("B")%></td><td><%=rs.getString("C")%></td><td><%=rs.getString("D")%></td><td><%=rs.getString("answer")%></td><td><%=rs.getString("Lx")%></td><td><%=rs.getString("Xj")%></td><td><a href="subject_update?id=<%=rs.getInt("id") %>">修改</a></td><td><a href="?id=<%=rs.getInt("id")%>">删除</a></td>
                    </tr>    
					<%
						
					}
					
					%>          
               
                
               
                
                </table>
               
          </div>
          
      </div>
      <%
	  	sql = "delete  from subject where id=?";
        ps = conn.preparedStatement(sql); 
        if(request.getParameter("id") !=null)
        {
			ps.setInt(1,Integer.parseInt(request.getParameter("id")));
			conn.executeUpdate();
        }
	  	
	  
	  
	  %>
</body>
</html>