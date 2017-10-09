package com.theah64.gjack;

import com.theah64.gjack.core.EmailTemplates;

import java.io.IOException;

/**
 * Created by theapache64 on 9/10/17.
 */
public class Lab {
    public static void main(String[] args) throws IOException {
        System.out.println(EmailTemplates.getInvitation(key, sharedBy, docTitle, docUrl));
    }
}
