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
		if(sf == null) System.out.println("空");
		String driver = sf.getInitParameter("driver");
		String host = sf.getInitParameter("host");
		String dbname = sf.getInitParameter("databaseName");
		String username = sf.getInitParameter("user");
		String pass = sf.getInitParameter("pass");
		
		try 
		{
			Class.forName(driver);
			System.out.println("驱动加载成功");
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("驱动加载失败");
		}
		try 
		{
			conn = DriverManager.getConnection("jdbc:mysql://"+host+"/"+dbname, username, pass);
			stmt = conn.createStatement();
			System.out.println(conn+"数据库链接成功");
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("数据库链接失败");
		}
	}
	
	public PreparedStatement preparedStatement(String sql) throws SQLException  //初始化预编译的SQL对象
	{
		ps = conn.prepareStatement(sql);
		return ps;
	}
	
	public ResultSet executeQuery(String sql) throws SQLException        //执行静态SQL语句，并返回他的结果集对象
	{
		rs = null;
		rs = stmt.executeQuery(sql);
		return rs;
	}
	
	public int executeUpdate(String sql) throws SQLException             //执行静态SQL更新语句并返回所影响的条数
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
	
	public ResultSet executeQuery() throws SQLException           //执行预编译的SQL查询语句
	{
		return ps.executeQuery();	
	}
	
	public int executeUpdate() throws SQLException                                   //执行预编译的SQL更新语句
	{
		int r=0;
		try
		{
			conn.setAutoCommit(false);
			r = ps.executeUpdate();
			conn.commit();
			System.out.println("执行到此");
		}
		catch(SQLException e)
		{
			conn.rollback();
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return r;
	}
	
	public boolean closeDB() throws SQLException                           //关闭数据库操作
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
