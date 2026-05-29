package com.example.test;

import java.util.Scanner;

public class CrazyMultiplicationTableProgram {
    public static void run() {
        System.out.println("Crazy Table");
        Scanner input = new Scanner(System.in);
        System.out.print("Ingrese un numero: ");
        int number = input.nextInt();
        for (int i=1; i<=10; i++) {
            if (number*i % 2 == 0) {
                System.out.println(number+" x "+i+" = "+(number*i));
            }
        }
    }
}
