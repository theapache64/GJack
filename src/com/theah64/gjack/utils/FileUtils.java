package com.theah64.gjack.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by theapache64 on 9/10/17.
 */
public class FileUtils {

    public static String read(String filePath) throws IOException {

        final FileReader fr = new FileReader(new File(filePath));
        final BufferedReader br = new BufferedReader(fr);
        final StringBuilder sb = new StringBuilder();
        String line = null;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        br.close();
        fr.close();

        return sb.toString();
    }
}
