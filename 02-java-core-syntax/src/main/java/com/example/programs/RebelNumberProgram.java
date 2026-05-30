/**
 * 2. Número “rebelde”
 * Pide un número al usuario y verifica si es un número “rebelde”:
 * Un número es rebelde si:
 *   la suma de sus dígitos es impar
 *   y el producto de sus dígitos es par
 *
 */

package com.example.programs;

import java.util.Scanner;

public class RebelNumberProgram {
    public static void run() {
        System.out.println("-- REBEL NUMBER");
        Scanner input = new Scanner(System.in);
        
        System.out.print("Ingrese un numero: ");
        int number = input.nextInt();

        int temp = number;
        int sum = 0;
        int product = 1;

        for (int digit=temp%10; temp>0; digit=temp%10) {
            sum+= digit;
            product*= digit;

            temp = temp/10;
        }

        System.out.println("Suma: "+sum);
        System.out.println("Product: "+product);

        if (((sum%2)!=0) && ((product%2)==0)) {
            System.out.println("Rebelde!");
        } else {
            System.out.println("No es rebelde");
        }
    }
}

