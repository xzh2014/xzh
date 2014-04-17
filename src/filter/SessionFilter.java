package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "sessionFilter", urlPatterns = {"*.jsp"})
public class SessionFilter implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		
		System.out.println("SessionFilter过滤器");
		HttpServletRequest res = (HttpServletRequest)arg0;
		HttpSession session = res.getSession();
		System.out.println(session.getAttribute("flag"));
		
		if(session.getAttribute("flag") == null ) 
		{
			throw new ServletException("服务器拒绝访问");
		}
		arg2.doFilter(arg0, arg1);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
			
	}

}
