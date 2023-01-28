package xyz.yvonneshow.yview;

import java.awt.image.*;
import java.net.*;
import java.io.*;
import java.io.IOException;

import javax.imageio.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import xyz.yvonneshow.ycore.*;

// Code modifued from: https://www.geeksforgeeks.org/servlet-display-image/
public class YImage extends HttpServlet {

    protected Yvonne yvonneObject;
 
    /**
     * this life-cycle method is invoked when this servlet is first accessed
     * by the client
     */
    public void init(ServletConfig config) {
        System.out.println("YImage is being initialized");

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

        response.setContentType("image/jpeg"); 

        ServletOutputStream outStream = response.getOutputStream(); 

		URL website = new URL(yvonneObject.RandomUrl().thumb);
		URLConnection connection = website.openConnection();
  
        // getting image in BufferedInputStream  
        BufferedInputStream bin = new BufferedInputStream(connection.getInputStream());
        BufferedOutputStream bout = new BufferedOutputStream(outStream);  
          
        int ch = 0;  
        while((ch = bin.read()) != -1)  
        {  
            // display image
            bout.write(ch);  
        }  
          
        // close all classes
        bin.close();
        bout.close();  
        outStream.close();  
    }
 
    /**
     * this life-cycle method is invoked when the application or the server
     * is shutting down
     */
    public void destroy() {
        System.out.println("YImage is being destroyed");
    }
}