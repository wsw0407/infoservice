package com.ly.lit.utils;

import java.util.Random;

public class RegistRandomCode {

    public static String getRegisCode() {
        char[] chr = { '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
                'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
        Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < 4; i++) {
            buffer.append(chr[random.nextInt(33)]);
        }
        return buffer.toString();
    }


    public static String getRegisNumCode() {
        char[] chr = {'0' ,'1' ,'2', '3', '4', '5', '6', '7', '8', '9'};
        Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < 6; i++) {
            buffer.append(chr[random.nextInt(10)]);
        }
        return buffer.toString();
    }

}
