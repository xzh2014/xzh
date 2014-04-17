package action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import dbDao.DBConnection;

public class TeacherAction extends ActionSupport
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 258187838902275645L;
	private File upload;
	private String id;
	private String name;
	private String time;
	private String uploadFileName;
	private String uploadContentType;
	private String class_;
	private String question;
	private String A;
	private String B;
	private String C;
	private String D;
	private String Xj;
	private String answer;
	private String Lx;
	private int count;
	private String text;
	private InputStream inputStream;
	
	
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getLx() {
		return Lx;
	}
	public void setLx(String lx) {
		Lx = lx;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getA() {
		return A;
	}
	public void setA(String a) {
		A = a;
	}
	public String getB() {
		return B;
	}
	public void setB(String b) {
		B = b;
	}
	public String getC() {
		return C;
	}
	public void setC(String c) {
		C = c;
	}
	public String getD() {
		return D;
	}
	public void setD(String d) {
		D = d;
	}
	public String getXj() {
		return Xj;
	}
	public void setXj(String xj) {
		Xj = xj;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getClass_() {
		return class_;
	}
	public void setClass_(String class_) {
		this.class_ = class_;
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
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	public String addStudent() throws IOException
	{
		FileOutputStream fos = null;
		FileInputStream fis = null;
		String path = "D:\\"+this.getUploadFileName();
		String teacher = (String)ServletActionContext.getRequest().getSession().getAttribute("name");//教师姓名
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "insert into class_info values(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = null;
		
		System.out.println("文件名是:"+this.uploadFileName+"文件类型是:"+this.getUploadContentType());
		try 
		{
			fos = new FileOutputStream(path);
		} 
		catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ERROR;
		}
		
		try 
		{
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
			return ERROR;
		}
		finally
		{
			fis.close();
			fos.close();
		}
		
		try
		{
			ps = conn.preparedStatement(sql);
			HSSFWorkbook workbook = new HSSFWorkbook(new java.io.FileInputStream(path));
			HSSFSheet sheet = workbook.getSheet(workbook.getSheetName(0));
			HSSFRow row = null;
			HSSFCell cell = null;
			int count = sheet.getLastRowNum();
			DecimalFormat df = new DecimalFormat("#");
			
			for(int i=0; i<count; i++)
			{
				row = sheet.getRow(i);
				cell = row.getCell(0);
				if(cell != null )
				{
					ps.setString(1, cell.getStringCellValue());
					ps.setString(2,name);
					cell = row.getCell(2);
					if(cell.getCellType() == Cell.CELL_TYPE_STRING)
					{
						System.out.println("出问题了");
						ps.setString(3,(row.getCell(2)).getStringCellValue());
						
					}
					else if(row.getCell(2).getCellType() == Cell.CELL_TYPE_NUMERIC)
					{
						//System.out.println("数字");
						ps.setString(3,df.format((row.getCell(2)).getNumericCellValue()));
						
					}
					
					ps.setString(4,(row.getCell(3)).getStringCellValue());
					ps.setString(5,(row.getCell(4)).getStringCellValue());
					
					ps.setString(6,time);
					ps.setString(7, teacher);
					ps.setString(8,"否");
					ps.setInt(9, 0);
					ps.setString(10, "0000-00-00");
						
					
				}
				
				conn.executeUpdate() ;
			}
			
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	public String deleteStudent()
	{
		
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "delete from class_info where time=? and class=?";
		PreparedStatement ps = null;
		try 
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, time);
			ps.setString(2, class_);
			System.out.println(time+" "+class_);
			int r = conn.executeUpdate();
			if(r >0)
			{
				return SUCCESS;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return ERROR;
	}
	
	public String subject_add()
	{
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "insert into subject (question,A,B,C,D,answer,Xj,Lx,teacher) values(?,?,?,?,?,?,?,?,?)";
		String teacher = (String)ServletActionContext.getRequest().getSession().getAttribute("name");
		if(teacher == null)
			teacher = "学生分享";
		PreparedStatement ps = null;
		try 
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, question);
			ps.setString(2, A);
			ps.setString(3, B);
			ps.setString(4, C);
			ps.setString(5, D);
			ps.setString(6, answer);
			ps.setString(7, Xj);
			ps.setString(8, Lx);
			ps.setString(9, teacher);
			int r = conn.executeUpdate();
			if(r == 1) return SUCCESS;
	
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ERROR;
	}
	
	public String subject_()
	{
		
			return SUCCESS;
		
	}
	
	public String condition()
	{
		ServletActionContext.getRequest().getSession().setAttribute("time", time);
		ServletActionContext.getRequest().getSession().setAttribute("class_", class_);
		//ServletActionContext.getRequest().getSession().setAttribute();
		System.out.println("condition:"+time+" "+"class_");
		return SUCCESS;
	}
	
	public String update_subject()
	{
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "update subject set question=?, A=?, B=?, C=?, D=?, answer=?, Lx=?, Xj=? where id=?";
		PreparedStatement ps=null;
		System.out.println("subject_update");
		try 
		{
			ps = conn.preparedStatement(sql);
			ps.setString(1, question);
			ps.setString(2, A);
			ps.setString(3, B);
			ps.setString(4, C);
			ps.setString(5, D);
			ps.setString(6, answer);
			ps.setString(7,Lx);
			ps.setString(8,Xj);
			ps.setString(9,id);
			int r = conn.executeUpdate();
			
			if(r ==1)
				return SUCCESS;
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ERROR;
		}
		
		
		return ERROR;
	}
	
	public String add_count()
	{
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "update class_info set count=? where s_number=? and time=?";
		System.out.println(count+" "+id);
		PreparedStatement ps;
		try {
			ps = conn.preparedStatement(sql);
			ps.setInt(1, count+1);
			ps.setString(2, id);
			ps.setString(3, time);
			System.out.println("time="+time);
			int r = conn.executeUpdate();
			System.out.println("r="+r);
			if(r == 1) return SUCCESS;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ERROR;
	}
	
	/*public String toMessage()
	{
		String teacher = (String)ServletActionContext.getRequest().getSession().getAttribute("name");//教师姓名
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "insert into message values(?,?,?,?)";
		String time = new java.util.Date().toString();
		PreparedStatement ps = null;
		
		return ERROR;
	}*/
	public String log_class()
	{
		DBConnection conn = new DBConnection(ServletActionContext.getServletContext());
		String sql = "update class_info set count=? where s_number=? and time=?";
		System.out.println(count+" "+id);
		PreparedStatement ps;
		try {
			ps = conn.preparedStatement(sql);
			ps.setInt(1, count+1);
			ps.setString(2, id);
			ps.setString(3, time);
			int r = conn.executeUpdate();
			System.out.println("r="+r);
			if(r == 1) 
			{
				try {
					inputStream = new ByteArrayInputStream("记录成功!!!".getBytes("UTF-8"));
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return SUCCESS;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ERROR;
	}
	
	

}
