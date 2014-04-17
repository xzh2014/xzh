<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbDao.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询留言</title>
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
				
			}
			form{
				margin-left:100px;
			}
		</style>
        <script>
			$(document).ready(function(e) {
				$('#to').hide();
				var tmp = new Object();
				$('textarea').click(function(e) {
                    $(this).text('');
                });
                $('.hf').click(function(e) {
					if($(this).parent('td').prev('td').text() == '已回复')
					{
						if(!confirm('您已经回复过此留言,是否还要回复?'))
						{
							return false;
						}	
					}
                    $('#to').show();
					$('textarea').text('请输入...');
					tmp = $(this);
					
					$('#name').val($(this).parent('td').prev('td').prev('td').prev('td').prev('td').text());
					$('#id').val($(this).parent('td').prev('td').prev('td').prev('td').prev('td').prev('td').text());
					
                });
				$('#qx').click(function(e) {
                    $('#to').hide();
                });
				$('#tj').click(function(e) {
					var messageTo = $('#name').val();
					var id = $('#id').val();
					$.get('toMessage?messageTo='+messageTo+'&id='+id,$('textarea').serializeArray(),function(data){
						alert(data);
						if(data == '留言回复成功!!!')
						{
							tmp.parent('td').prev('td').text('已回复');
								
						}
						
						},'html');
						$('#to').hide();
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
       <!-- <div class="title">-->
           <h1>&nbsp;</h1>
           <h2>&nbsp;</h2>  
            <h2>&nbsp;</h2> 
       <!-- </div>-->
       
       <div class="info" style="height:auto; width:100%; box-shadow:none">
       
        	<div class="info_02" style="width:50%; height:auto;  float:left;">
            	
                
               
            	<p>查看留言</p>
                <hr>
                <p>&nbsp;</p>
               
          		<table>
                <tr>
                	<td>序号</td><td>教师</td><td>回复内容</td><td>回复时间</td>
                </tr>
                <%
					context = request.getServletContext();
                	conn = new DBConnection(context);
                	DBConnection conn_ = new DBConnection(context);
                	sql = "select * from message where messageTo=?";
                	ps = conn.preparedStatement(sql);
					String teacher = (String)session.getAttribute("name");
					System.out.println(teacher);
					ps.setString(1, teacher);
					rs = conn.executeQuery();
					if(rs == null) System.out.println("空");
				%>
					
				<%
					while(rs.next())
					{%>
					<tr>
                    	<td><%=rs.getInt("id")%></td>
                        <td><%=rs.getString("messageFrom")%></td>
                        <td style="width:400px; overflow:scroll"><%=rs.getString("messageText")%></td>
                        <td ><%=(rs.getString("messageTime"))%></td>
                       
                
                    </tr>    
					<%
					}
					%>          
               
                
               
                
                </table>
               
              
            </div>
            
            
           
        </div>
                   
       
       
</body>
</html>