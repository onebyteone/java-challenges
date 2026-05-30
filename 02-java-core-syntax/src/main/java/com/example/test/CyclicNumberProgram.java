/**
 * Un número cíclico es un número entero de k dígitos tal que,
 * al multiplicarlo por cualquier número entero del 1 al k,
 * el resultado es simplemente una permutación cíclica
 * (una rotación) de los dígitos del número original.
 */

package com.example.test;

import java.util.Scanner;

public class CyclicNumberProgram {
    public static void run() {
        System.out.println("-- Detector de números cíclicos --");
        Scanner input = new Scanner(System.in);

        System.out.print("Ingrese un número: ");
        int number = input.nextInt();

        int k = getDigitsCount(number);
        int[] digits = getDigits(number, k);
        digits = sortDigits(digits);

        boolean isCyclic = true;

        for (int i=1; i<=k; i++) {
            int res = number * i;
            System.out.print(number + " * " + i + " = " + res);

            int[] resDigits = getDigits(res, k);
            resDigits = sortDigits(resDigits);
            if (!checkRotation(digits, resDigits)) {
                isCyclic = false;
                System.out.println(" ❌");
                break;
            }
            System.out.println(" ✅");
        }

        if (!isCyclic) {
            System.out.println("El numero no es ciclico.");
        } else {
            System.out.println("El numero es ciclico!");
        }

    }

    private static int getDigitsCount(int number) {
        int count = 0;
        for (int temp = number; temp > 0; temp /= 10) {
            count++;
        }
        return count;
    }

    private static int[] getDigits(int number, int k) {
        int[] digits = new int[k];
        int temp = number;
        for (int i = 0; i < k; i++) {
            digits[i] = temp % 10;
            temp /= 10;
        }
        return digits;    
    }

    private static boolean checkRotation(int[] original, int[] candidate) {
        int n = original.length;
        for (int i=0; i<n; i++) {
            if (original[i] != candidate[i]) {
                return false;
            }
        }
        return true;
    }

    private static int[] sortDigits(int[] digits) {
        int n = digits.length;
        int minor = digits[0];
        for (int i=0; i<n; i++) {
            for (int j=i; j<n; j++) {
                if (digits[j]<digits[i]) {
                    int temp = digits[j];
                    digits[j] = digits[i];
                    digits[i] = temp;
                }
            }
        }
        return digits;
    }
}