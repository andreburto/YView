package xyz.yvonneshow.yview;

import java.io.IOException;
import java.io.PrintWriter;
 
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import xyz.yvonneshow.ycore.*;

 
public class YView extends HttpServlet {

    private Yvonne yvonneObject;
 
    /**
     * this life-cycle method is invoked when this servlet is first accessed
     * by the client
     */
    public void init(ServletConfig config) {
        System.out.println("YView is being initialized");

        try {
            yvonneObject = new Yvonne();
            System.out.println("Yvonne object initialized");
        }
		catch (Exception e) {
            e.printStackTrace();
		}
    }
 
    /**
     * handles HTTP GET request
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        ImgYvonne imgUrl = yvonneObject.RandomUrl();
        response.sendRedirect(imgUrl.image);
    }
 
    /**
     * this life-cycle method is invoked when the application or the server
     * is shutting down
     */
    public void destroy() {
        System.out.println("YView is being destroyed");
    }
}