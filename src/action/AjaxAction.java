package action;

import java.io.*;
import com.opensymphony.xwork2.ActionSupport;
 
public class AjaxAction extends ActionSupport  {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private InputStream inputStream;
    public InputStream getInputStream() {
        return inputStream;
    }
 
    public String execute() throws Exception {
        inputStream = new ByteArrayInputStream("Hello World! This is a text string response from a Struts 2 Action.".getBytes("UTF-8"));
        return SUCCESS;
    }
}