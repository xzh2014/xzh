<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>随机</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
<script src="js/jquery-2.1.0.min.js"></script>
<script>
$(document).ready(function(e) {
	$('a.a').hide();
	var i= $('.i').val();//总人数
		//i = i-1;
		var s = new Array();
		
		for( var k=1; k<=i;k++)
		{
			var obj ={};
			obj.id = $('.put_number'+k).val();
			obj.name = $('.put_name'+k).val();
			s.push(obj);
		}
		//alert(s.length);
		var r=0;
		var time = 0;
	//	$('table#table001').hide();
		if(i !=0)
		{
			r = setInterval(function(){
			var rand  = Math.floor(Math.random()*i);
			//if(rand ==0)rand==1;
			$('td.td01').text(s[rand].id);
			$('td.td02').text(s[rand].name);
			time++;
				
				
				if(time % 10 == 0)
				{
					$('.table').append('<tr style="background-color#996600  "><td style="border:1px solid #3F6; width:150px;">'+s[rand].id+'</td><td style="border:1px solid #3F6; width:150px;">'+s[rand].name+'</td><td><button style="background-color:#cc0000;" class="qkbt">记录缺课</button></td></tr>');
											
				}
			},100);
		}
			
			$('input#bt').click(function(e) {
				$('table#table001').hide();
                clearInterval(r);
				$('a').show();
            });	
			$('.qkbt').live('click',function(){
				//alert('hh');
				var s_number = $(this).parent('td').prev('td').prev('td').text();
				var time = $('.time').val();
			//	alert(s_number);
				$.get('log_class?time='+time+'&id='+s_number,null,function(data){
					alert(data);					
					});
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
            	
            	<p>随机点名</p>
                <hr>
              
                <form method="post" action="">
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
					//conn.closeDB();
					}
					%>          
                
                
                </select>
                
           
               
                <input type="submit" value="开始" style="width:50px; cursor:pointer;" id="sub"/><input type="button" id="bt" value="结束" style="width:50px; cursor:pointer; margin-left:5px;"/>
                <a href="information_" style="margin-left:0px;">教师主页</a>
                </form>
            </div>
        </div>
        
       <div style="width:1px; height:1px; overflow:hidden;" id="div_hid">
<%
	//if(request.getParameter("class_") !=null)
	
	context = request.getServletContext();
    conn = new DBConnection(context);
	class_ = request.getParameter("class_");
	//String num = request.getParameter("num");
	String name = (String)session.getAttribute("name");
    sql = "select * from class_info  where class=? and teacher=?";
	ps = conn.preparedStatement(sql);
	ps.setString(1,class_);
	ps.setString(2,name);
	
	
	int i=0;
    rs = conn.executeQuery();	
   
	
	while(rs.next())
	{	
		class_ = rs.getString("class");
		time = rs.getString("time");
%>		
	<input type="text" class="put_number<%=i+1%>" value="<%=rs.getString("s_number")%>" />
    <input type="text" class="put_name<%=i+1%>" value="<%=rs.getString("s_name")%>" /><br>
    <%
	i++;
    }
	%>
    <input type="text" class="i" value="<%=i%>">
   	<input type="text" class="time" value="<%=time%>">
    </div>
    <div style=" margin-top:100px; text-align:center">
    <table align="center" style="border:1px solid #09C; margin-left:500px;" id="table001">
    	<tr style="background-color:#F90"><td class="td01" style="border:1px solid #3F6;width:150px;"></td><td class="td02" style="border:1px solid #3F6;width:150px;"></td></tr>
    </table>
    <br>
    <table align="center" class="table" style="border:1px solid #09C; margin-left:500px;">
    	
    </table>
    <a href="condition?class_=<%=class_%>&time=<%=time %>" class="a"><input type="button" id="bt" value="显示全部学生" style="width:auto; cursor:pointer; margin-left:5px;"/></a>
	</div>  
    
                   
       
       
</body>
</html>