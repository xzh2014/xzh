<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导出教学记录表</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
<script src="js/jquery-2.1.0.min.js"></script>
<script>
$(document).ready(function(e) {
	
			
				$.get('log_class?time='+time+'&id='+s_number,null,function(data){
					alert(data);					
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
%>

 <body style="overflow:scroll; text-align:center;  background-attachment:fixed;">
        <div class="title">
           <h1>&nbsp;</h1>
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
           <h2>&nbsp;</h2>
        </div>
        <div class="info" style=" width:75%; height:auto; box-shadow:0px 0px 0px 0px #FFFFFF">
        	 <div class="info_02" style=" width:100%; height:auto">
            	
            	<p>导出教学记录表</p>
                <hr>
              
                <form method="post" action="show_record.jsp">
                班级:<select name="class_" id="class_" style="width:200px; height:30px; font-size:16px;">
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
				conn.closeDB();
					%>          
                
                
                </select>
                
           
               
                <input type="submit" value="查看记录表" style="width:auto; cursor:pointer;" id="sub"/>
                <a href="information_" style="margin-left:0px;">教师主页</a>
                </form>
            </div>
        </div>
        
       
	
    
                   
       
       
</body>
</html>