<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
<title>删除学生名单</title>
</head>
<%!
	
	DBConnection conn=null;
	PreparedStatement ps	= null ;
	ResultSet rs = null;
	ServletContext context = null;
	String sql = null;
%>
<body>
        <div class="title">
           <h1>&nbsp;</h1>
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
        </div>
        <div class="info">
        	 <div class="info_02">
            	<h2>&nbsp;</h2>
               
            	<p>删除学生名单 <a href="information_" style="margin-left:550px;">教师主页</a></p>
                <hr>
                <h2>&nbsp;</h2>
                <form method="post" action="deleteStudent">
                <p>班级:<select name="class_" id="class_" style="width:200px; height:30px; font-size:16px;">
                <option value='' selected="selected">
                	请选择...					
                </option>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	sql = "select distinct class from class_info";
                	ps = conn.preparedStatement(sql);
                	rs = conn.executeQuery();				
				%>
				<%
					while(rs.next())
					{%>
						<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>      
					<%
					}
					%>          
                </select>
                </p>
                <p>节次:<select name="time" id="time" style="width:200px; height:30px; font-size:16px;">
                <option value='' selected="selected">
                	请选择...					
                </option>
                <%
					//ServletContext context = request.getServletContext();
                	conn = new DBConnection(context);
                	sql = "select distinct time from class_info";
                	ps = conn.preparedStatement(sql);
                	rs = conn.executeQuery();				
				%>
				<%
					while(rs.next())
					{%>
						<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>      
					<%
					}
					%>          
                
                
                </select>
               </p>
                <input type="submit" value="提交" style="width:50px; cursor:pointer;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </form>
            </div>
        </div>
                   
       
       
</body>
</html>