package action;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import dbDao.DBConnection;

public class MessageAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8650025936077300957L;
	private String teacher;
	private String text;
	private String messageTo;
	private InputStream inputStream;
	private String id;
    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public InputStream getInputStream() {
        return inputStream;
    }
	
	public String getMessageTo() {
		return messageTo;
	}

	public void setMessageTo(String messageTo) {
		this.messageTo = messageTo;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String message()
	{
		HttpServletResponse resp = (HttpServletResponse)ServletActionContext.getResponse();
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		if(ServletActionContext.getRequest().getSession().getAttribute("name")  !=null)
		{
			System.out.println("hhh");
			return SUCCESS;
		}
		return ERROR;
	}
	
	public String leaveMessage()
	{
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "insert into message(messageFrom,messageTo,messageText,messageTime) values(?,?,?,?)";
		String messageFrom = (String)ServletActionContext.getRequest().getSession().getAttribute("name");
		String messageTime = new Date().toString();
		PreparedStatement ps = null;
		try 
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, messageFrom);
			ps.setString(2, teacher);
			ps.setString(3, getText());
			ps.setString(4, messageTime);
			int r = conn.executeUpdate();
			if(r == 1)
			{
				return SUCCESS;
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			//e.printStackTrace();
			System.out.println(e.toString());
		}
		
		
		
		return ERROR;
	}
	
	public String toMessage()
	{
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "insert into message(messageFrom,messageTo,messageText,messageTime,flag) values(?,?,?,?,'已回复')";
		String messageFrom = (String)ServletActionContext.getRequest().getSession().getAttribute("name");
		String messageTime = new Date().toString();
		PreparedStatement ps = null;
		System.out.println("messageFrom="+messageFrom);
		System.out.println("messageTo="+messageTo);
		System.out.println("text="+text+"id="+id);
		
		try 
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, messageFrom);
			ps.setString(2, messageTo);
			ps.setString(3, text);
			ps.setString(4, messageTime);
			int r = conn.executeUpdate();
			if(r == 1)
			{
				try 
				{
					inputStream = new ByteArrayInputStream("留言回复成功!!!".getBytes("UTF-8"));
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				sql = "update message set flag = '已回复' where id=?";
				ps = conn.preparedStatement(sql);
				ps.setString(1, id);
				conn.executeUpdate();
				
				return SUCCESS;
			}
			
			
		} catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ERROR;
	}

}
