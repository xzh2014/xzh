package action;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class SessionAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4639079515140448499L;
	
	public String information()
	{
		String flag = (String)ServletActionContext.getRequest().getSession().getAttribute("flag");
		HttpServletResponse resp = (HttpServletResponse)ServletActionContext.getResponse();
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		
		if(flag == null) flag = "_";
		System.out.println("flag="+flag);
		if(flag.equals("s") ||flag.equals("t"))
			return SUCCESS;
		return ERROR;
	}
	
	public String information_t()
	{
		String flag = (String)ServletActionContext.getRequest().getSession().getAttribute("flag");
		HttpServletResponse resp = (HttpServletResponse)ServletActionContext.getResponse();
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		
		if(flag == null) flag = "_";
		System.out.println("flag="+flag);
		if(flag.equals("t"))
			return SUCCESS;
		return ERROR;
	}
	
	public String sign_in_()//Ç©µ½
	{
		String flag = (String)ServletActionContext.getRequest().getSession().getAttribute("flag");
		HttpServletResponse resp = (HttpServletResponse)ServletActionContext.getResponse();
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		
		if(flag == null) flag = "_";
		System.out.println("sign_in_flag="+flag);
		if(flag.equals("s"))
			return SUCCESS;
		return ERROR;
	}
	public String submit()
	{
		String flag = (String)ServletActionContext.getRequest().getSession().getAttribute("flag");
		HttpServletResponse resp = (HttpServletResponse)ServletActionContext.getResponse();
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		
		if(flag == null) flag = "_";
		System.out.println("submit_flag="+flag);
		if(flag.equals("s"))
			return SUCCESS;
		return ERROR;
	}
	
	public String add_student()
	{
		String flag = (String)ServletActionContext.getRequest().getSession().getAttribute("flag");
		HttpServletResponse resp = (HttpServletResponse)ServletActionContext.getResponse();
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		
		if(flag == null) flag = "_";
		System.out.println("submit_flag="+flag);
		if(flag.equals("t"))
			return SUCCESS;
		return ERROR;
	}

}
