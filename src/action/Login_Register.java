package action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import dbDao.DBConnection;

public class Login_Register extends ActionSupport
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4149789080582136317L;
	private String id;
	private String pass;
	private String pass1;
	private String class_;
	private String role;
	private String username;
	private String time;
	
	private File upload;
	private String uploadContentType;
	private String uploadFileName;
	private String savePath;
	private String tip;
	

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getSavePath() {
		return ServletActionContext.getServletContext().getRealPath("/WEB-INF/"+savePath);
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPass1() {
		return pass1;
	}

	public void setPass1(String pass1) {
		this.pass1 = pass1;
	}

	public String getClass_() {
		return class_;
	}

	public void setClass_(String class_) {
		this.class_ = class_;
	}

	public String login() throws SQLException
	{
		ServletContext context = ServletActionContext.getServletContext();
		//System.out.println("id="+ServletActionContext.getRequest().getParameter("id"));
		DBConnection conn = new DBConnection(context);
		String sql = "select * from user where id=?";
		PreparedStatement ps = null;
		
		try 
		{
			ps = conn.preparedStatement(sql);
			//System.out.println("id="+getId());
			ps.setString(1, getId());
			ResultSet rs = conn.executeQuery(); 
			
			if(rs.next())
			{
				System.out.println(rs.getString("pass"));
				if(rs.getString("pass").equals(pass))
				{
					ServletActionContext.getRequest().getSession().setAttribute("flag", rs.getString("flag"));
					System.out.println("登录成功"+rs.getString("flag"));
					ServletActionContext.getRequest().getSession().setAttribute("id", id);
					ServletActionContext.getRequest().getSession().setAttribute("name", rs.getString("name"));
					
					
					if(rs.getString("flag").equals("s"))
						return "success_s";
					else
					{
						ps = null;
						String login_time = null;
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
						login_time = (formatter.format(new Date())).substring(0, 10);
						
						sql = "update class_info set flag='否' where login_time <>? and teacher=? and flag='是'";
						ps = conn.preparedStatement(sql);
						ps.setString(1, login_time);
						ps.setString(2, rs.getString("name"));
						int r = conn.executeUpdate();
						System.out.println(id+"更新"+r+"记录");
						
						return "success_t";
					}
				}
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			return ERROR;
		}   //创建一个预处理SQL对象
		finally
		{
			conn.closeDB();
		}
		this.setTip("用户名或密码错误!!!");
		return ERROR;
	}
	
	public String logout()
	{
		ServletActionContext.getRequest().getSession().invalidate();
		System.out.println("Session销毁成功");
		return SUCCESS;
	}
	
	public String register()
	{
		System.out.println("id="+ServletActionContext.getRequest().getParameter("id"));
		ServletContext context = ServletActionContext.getServletContext();
		DBConnection conn = new DBConnection(context);
		String sql = "insert into user values(?,?,?,?)";
		PreparedStatement ps = null;
		
		try
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, id);
			ps.setString(2, username);
			ps.setString(3, pass);
			ps.setString(4, role);
			int rs = conn.executeUpdate();
			if(rs == 1) return SUCCESS;
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ERROR;
		}
		finally
		{
			try 
			{
				conn.closeDB();
			} catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ERROR;
	}
	
	public String s_update()
	{
		System.out.println("id="+(String)ServletActionContext.getRequest().getSession().getAttribute("id"));
		System.out.println("pass1="+pass1);
		ServletContext context = ServletActionContext.getServletContext();
		DBConnection conn = new DBConnection(context);
		String sql = "update user set pass = ? where id=?";
		PreparedStatement ps = null;
		
		try
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, pass1);
			ps.setString(2, (String)ServletActionContext.getRequest().getSession().getAttribute("id"));
			int rs = conn.executeUpdate();
			if(rs != 0) return SUCCESS;
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ERROR;
		}
		finally
		{
			try 
			{
				conn.closeDB();
			} catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ERROR;
	}
	
	public String sign_in()
	{
		ServletContext context = ServletActionContext.getServletContext();
		//String ip = ServletActionContext.getRequest().getRemoteAddr();
		//System.out.println("ip="+ip+"class="+class_);
		DBConnection conn = new DBConnection(context);
		String sql = "update class_info set flag ='是',login_time=? where s_number=? and time=?";
		System.out.println(id+" "+time);
		PreparedStatement ps = null;
		String login_time = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
		login_time = (formatter.format(new Date())).substring(0, 10);
		System.out.println("login_time="+login_time);
		
		try 
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, login_time);
			ps.setString(2, id);
			ps.setString(3,time);
			//ps.setString();
			int rs = conn.executeUpdate();
			if(rs != 0) return SUCCESS;
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ERROR;
	}

	public String submit_work() throws IOException
	{
		FileOutputStream fos = null;
		FileInputStream fis = null;
		String name = (String)ServletActionContext.getRequest().getSession().getAttribute("name");
		try 
		{
			fos = new FileOutputStream(getSavePath()+"\\"+name+this.getUploadFileName());
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			fis = new FileInputStream(this.getUpload());
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		byte[] buffer = new byte[2048];
		int len = 0 ;
		try 
		{
			while((len = fis.read(buffer)) > 0)
			{
				fos.write(buffer,0,len);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			fis.close();
			fos.close();
		}
		return SUCCESS;
	}
	
	
}
