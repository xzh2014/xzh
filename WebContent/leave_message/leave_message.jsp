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
<title>留言页面</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
<style>
	
	
</style>
<script src="js/jquery-2.1.0.min.js"></script>
<script>
$(document).ready(function(e) {
   
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
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
        </div>
        <div class="info" style=" width:75%; height:auto; box-shadow:0px 0px 0px 0px #FFFFFF;">
        	 <div class="info_02" style=" width:100%; height:auto; ">
            	
            	<p>留言板</p>
                <hr>
               
                <form method="post" action="leaveMessage">
               选择留言老师:<select name="teacher" id="class_" style="width:200px; height:30px; font-size:16px;">
                <option value='' selected="selected">
                	请选择...					
                </option>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
					String name = (String)session.getAttribute("name");
                	sql = "select distinct teacher from class_info where s_name=?";
                	ps = conn.preparedStatement(sql);
					ps.setString(1,name);
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
                <p>&nbsp;</p>
                <textarea name="text" rows="10" cols="50"></textarea>
                <p>&nbsp;</p>
                <input type="submit" value="提交" style="width:auto; cursor:pointer;" id="sub"/>
                &nbsp;&nbsp;&nbsp;&nbsp;
                 <input type="reset" value="重置" style="width:auto; cursor:pointer;" id="sub"/>
                </form>
            </div>
       
      
     </div>
   
       
       
</body>
</html>