<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>随机点名</title>
<script src="js/jquery-2.1.0.min.js"></script>
<script>
$(document).ready(function(e) {
	var count = $('input.i').val();//随机的人数
	var i= $('.i').val();//总人数
	//alert(i);
    /*student={
		name:'',
		id:''		
		};*/
		var s = new Array(i);
		
		for( var k=1; k<=i;k++)
		{
			var obj ={};
			obj.id = $('.put_number'+k).val();
			obj.name = $('.put_name'+k).val();
			s.push(obj);
		}
		$('input').remove();

		function getRandom()
		{
        	$('td.td01').text(s[Math.floor(Math.random()*i)].id);
			$('td.td02').text(s[Math.floor(Math.random()*i)].name)
        }
		var js=0;
		
			var r = setInterval(function(){
				var rand  = Math.floor(Math.random()*i);
				if(rand ==0)rand==1;
				$('td.td01').text(s[rand].id);
				$('td.td02').text(s[rand].name);
				var flag = Math.floor(Math.random()*20);
				$('label').text(flag);
				if(flag == 5 && js<=count)
				{
					$('.table').append('<tr style="background-color:#33C"><td style="border:1px solid #3F6;">'+s[rand].id+'</td><td style="border:1px solid #3F6;">'+s[rand].name+'</td></tr>');
					js++;						
				}
				if(js-1 == count)
				{
					clearInterval();
				}
			
			},60);
		
		
		
		
		
		
		
		
			
			
		
		
		
		
});
</script>
<%!
	
	DBConnection conn=null;
	PreparedStatement ps	= null ;
	ResultSet rs = null;
	ServletContext context = null;
	String sql = null;
%>


</head>
<body background="images/bs.jpg">


<div style="width:1px; height:1px; overflow:hidden;">
<%
	context = request.getServletContext();
    conn = new DBConnection(context);
	String class_ = request.getParameter("class_");
	String num = request.getParameter("num");
	String name = (String)session.getAttribute("name");
    //sql = "select * from class_info  where class=? and teacher=?order by rand() limit ?";
    sql = "select * from class_info  where class=? and teacher=?";
	ps = conn.preparedStatement(sql);
	ps.setString(1,class_);
	ps.setString(2,name);
	//ps.setInt(3,Integer.parseInt(num));
	
	int i=0;
    rs = conn.executeQuery();	
	while(rs.next())
	{	
		
%>		
	<input type="text" class="put_number<%=i+1%>" value="<%=rs.getString("s_number")%>" />
    <input type="text" class="put_name<%=i+1%>" value="<%=rs.getString("s_name")%>" /><br>
    <%
	i++;
    }
	%>
    <input type="text" class="i" value="<%=i%>">
     <input type="text" class="count" value="<%=num%>"></div>
    
    <table align="center" style="border:1px solid #09C;">
    	<tr style="background-color:#33C"><td class="td01" style="border:1px solid #3F6;"></td><td class="td02" style="border:1px solid #3F6;"></td></tr>
    </table>
    <table align="center" class="table" style="border:1px solid #09C;">
    	
    </table>
    <label></label>
</body>
</html>