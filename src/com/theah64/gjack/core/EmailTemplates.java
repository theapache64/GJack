package com.theah64.gjack.core;

import com.theah64.gjack.utils.FileUtils;

import java.io.File;
import java.io.IOException;

/**
 * Created by theapache64 on 9/10/17.
 */
public class EmailTemplates {

    public static final String KEY_SHARED_BY = "{SHARED_BY}";
    public static final String KEY_ORDER_KEY = "{ORDER_KEY}";
    public static final String KEY_DOC_TITLE = "{DOC_TITLE}";

    public static String getInvitation(String key, String sharedBy, String docTitle) throws IOException {
        System.out.println(new File("../../../../../invitation.jsp").getAbsolutePath());
        String invitationTemplate = FileUtils.read("invitation.jsp");
        invitationTemplate = invitationTemplate.replace(KEY_ORDER_KEY, key);
        invitationTemplate = invitationTemplate.replace(KEY_SHARED_BY, sharedBy);
        invitationTemplate = invitationTemplate.replace(KEY_DOC_TITLE, docTitle);
        return invitationTemplate;
    }

}
