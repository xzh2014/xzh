package dbDao;

import java.sql.*;

import javax.servlet.ServletContext;

public class DBConnection 
{
	private Connection conn = null;
	private Statement stmt = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	ServletContext sf = null;
	
	public DBConnection()
	{
		
	}
	public DBConnection(ServletContext context)
	{
		sf = context;
		if(sf == null) System.out.println("��");
		String driver = sf.getInitParameter("driver");
		String host = sf.getInitParameter("host");
		String dbname = sf.getInitParameter("databaseName");
		String username = sf.getInitParameter("user");
		String pass = sf.getInitParameter("pass");
		
		try 
		{
			Class.forName(driver);
			System.out.println("�������سɹ�");
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("��������ʧ��");
		}
		try 
		{
			conn = DriverManager.getConnection("jdbc:mysql://"+host+"/"+dbname, username, pass);
			stmt = conn.createStatement();
			System.out.println(conn+"���ݿ����ӳɹ�");
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("���ݿ�����ʧ��");
		}
	}
	
	public PreparedStatement preparedStatement(String sql) throws SQLException  //��ʼ��Ԥ�����SQL����
	{
		ps = conn.prepareStatement(sql);
		return ps;
	}
	
	public ResultSet executeQuery(String sql) throws SQLException        //ִ�о�̬SQL��䣬���������Ľ��������
	{
		rs = null;
		rs = stmt.executeQuery(sql);
		return rs;
	}
	
	public int executeUpdate(String sql) throws SQLException             //ִ�о�̬SQL������䲢������Ӱ�������
	{
		int re=0;
		try
		{
			conn.setAutoCommit(false);
			re = stmt.executeUpdate(sql);
			conn.commit();
		}
		catch(SQLException e)
		{
			conn.rollback();
		}
		return re;
	}
	
	public ResultSet executeQuery() throws SQLException           //ִ��Ԥ�����SQL��ѯ���
	{
		return ps.executeQuery();	
	}
	
	public int executeUpdate() throws SQLException                                   //ִ��Ԥ�����SQL�������
	{
		int r=0;
		try
		{
			conn.setAutoCommit(false);
			r = ps.executeUpdate();
			conn.commit();
			System.out.println("ִ�е���");
		}
		catch(SQLException e)
		{
			conn.rollback();
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return r;
	}
	
	public boolean closeDB() throws SQLException                           //�ر����ݿ����
	{
		try
		{
			if(this.rs != null)
			{
				rs.close();
			}
			
			if(this.stmt != null)
			{
				stmt.close();
			}
			
			if(this.ps != null)
			{
				ps.close();
			}
			
			if(this.conn != null)
			{
				conn.close();
			}
			return true;
		}
		catch(SQLException e)
		{
			
		}
		return false;
	}
}
