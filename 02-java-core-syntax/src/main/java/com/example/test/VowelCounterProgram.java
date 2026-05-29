package com.example.test;

import java.util.Scanner;

public class VowelCounterProgram {
    public static void run() {
        Scanner input = new Scanner(System.in);
        char[] vowels = {'a','e','i','o','u'};
        System.out.println("Ingresa una palabra");
        String word = input.nextLine();
        int vowel_counter = 0;
        for (int i=0; i<word.length(); i++) {
            char letter = word.charAt(i);
            for (char vowel : vowels) {
                if (letter == vowel) {
                    vowel_counter += 1;
                }
            }
        }
        
        if (vowel_counter == 0) {
            System.out.println("Su palabra no tiene vocales!");
        } else {
            System.out.println("Hay " + vowel_counter + " vocales.");
        }
    }
}
