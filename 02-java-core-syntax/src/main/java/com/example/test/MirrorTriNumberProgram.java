package com.example.test;

import java.util.Scanner;

public class MirrorTriNumberProgram {
    public static void run() {
        System.out.println("--MIRROR NUMBER");
        Scanner input = new Scanner(System.in);
        
        System.out.print("Ingresa el tamaño: ");
        int size = input.nextInt();

        for (int i=1; i<=size; i++) {
            for (int j=1; j<=i*2-1; j++) {
                System.out.print(j <= i ? j : 2*i-j);
            }
            System.out.println();
        }
    }
}

