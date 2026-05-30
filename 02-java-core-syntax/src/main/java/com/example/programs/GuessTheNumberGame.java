package com.example.programs;

import java.util.Scanner;
import java.util.Random;

public class GuessTheNumberGame {
    public static void run() {
        System.out.println("-- GUESS THE NUMBER");
        
        Scanner input = new Scanner(System.in);
        Random random = new Random();
        int LIMIT = 3;
        int random_number = random.nextInt(LIMIT)+1;
        int n_tries = 0;

        while (true) {

            System.out.print("Ingrese un numero: ");
            int number = input.nextInt();

            n_tries++;

            if (number == random_number) {
                System.out.println("Ganaste!");
                System.out.println("Resultados:");
                System.out.println("- N° intentos = " + n_tries);
                break;
            } else {
                System.out.println("Incorrecto.");
                if (n_tries >= LIMIT) {
                    System.out.println("GAME OVER");
                    break;
                }
            }

        }
    }
}
        
