package com.example.test;

public class RocketCountdownProgram {
    public static void run() {
        System.out.println("-- ROCKET COUNTDOWN");
        int TIME = 10;
        try {
            for (int i=TIME; i>=0; i--) {
                System.out.println(i);
                Thread.sleep(1000);
            }
            System.out.println("Despegue! 🚀");
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
