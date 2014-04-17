<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改试题</title>
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
               
            	<p>试题修改 <a href="information_" style="margin-left:550px;">教师主页</a></p>
                <hr>
                <p>&nbsp;</p>
                <form action="update_subject" method="post" name="form">
          		<table>
               <!-- <tr>
                	<td>题号</td><td>题目</td><td>A</td><td>B</td><td>C</td><td>D</td><td>答案</td><td>试题类型</td><td>答案详解</td>
                </tr>-->
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	sql = "select * from subject where id=? ";
                	ps = conn.preparedStatement(sql);
					ps.setString(1,request.getParameter("id"));
					rs = conn.executeQuery();
					int id = 0;
				%>
					
				<%
					while(rs.next())
					{
						id = rs.getInt("id");
						%>
					<tr>
                    	<td>题目:</td><td><textarea cols="30" rows="5" style="box-shadow:5px 2px 6px #009933;" name="question" required><%=rs.getString("question")%></textarea></td>
                        <td>A选项:</td><td><textarea cols="30" rows="5" style="box-shadow:5px 2px 6px #009933;" name="A" required><%=rs.getString("A")%></textarea></td>
                        <td>B选项:</td><td><textarea cols="30" rows="5" style="box-shadow:5px 2px 6px #009933;" name="B" required><%=rs.getString("B")%></textarea></td>
                    </tr>
                    <tr>
                    	<td>C选项:</td><td><textarea cols="30" rows="5" style="box-shadow:5px 2px 6px #009933;" name="C" required><%=rs.getString("C")%></textarea></td>
                        <td>D选项:</td><td><textarea cols="30" rows="5" style="box-shadow:5px 2px 6px #009933;" name="D" required><%=rs.getString("D")%></textarea></td>
                        <td>答案详解:</td><td><textarea cols="30" rows="5" style="box-shadow:5px 2px 6px #009933;" name="Xj" required><%=rs.getString("Xj")%></textarea></td>
                    </tr>
                    <tr>
                    	<td>答案:</td><td><input type="text" name="answer" required  value="<%=rs.getString("answer")%>"/></td>
                        <td>试题类型:</td><td><input type="text" name="Lx" required  value="<%=rs.getString("Lx")%>"/></td>
                        <td>&nbsp;</td><td> <input type="submit" value="提交" style="width:50px; cursor:pointer;"/></td>
                        <td>&nbsp;</td><td> <input type="reset" value="重置" style="width:50px; cursor:pointer;"/></td>
                    </tr>
					<%
						
					}
					
					%>          
               
                
               
                
                </table>
                <input name="id" type="hidden" value="<%=id%>"/>
                </form>
               
          </div>
          
      </div>
      
</body>
</html>