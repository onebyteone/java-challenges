package com.example.test;

import java.util.Scanner;

public class AsteriskSpiralProgram {
    public static void run() {
        System.out.println("-- ASTERISK SPIRAL");
        Scanner input = new Scanner(System.in);

        System.out.print("Ingrese tamaño de espiral: ");
        int size = input.nextInt();

        int center = size * 2 + 1;
        int width = size * 4 + 1; // cols
        int height = size * 4; // rows

        char[][] matrix = new char[height][width];

        for (int i=0; i<height; i++) {
             for (int j=0; j<width; j++) {
                matrix[i][j] = ' ';
            }
        }

        int[] pos = { center-1, center-1 };
        int padding = size*2;


        for (int i=1; i<=size; i++) {
            padding-=2;
            int temp_w = i*4+1; // relativo w
            int temp_h = i*4; // relativo h

            for (; pos[0]+1<temp_h+padding; pos[0]++) {
                matrix[pos[0]][pos[1]] = '*';
            }
            for (; pos[1]+1<temp_w+padding; pos[1]++) {
                matrix[pos[0]][pos[1]] = '*';
            }
            for (; pos[0]-1>padding-1; pos[0]--) {
                matrix[pos[0]][pos[1]] = '*';
            }
            for (; pos[1]-1>padding-1; pos[1]--) {
                matrix[pos[0]][pos[1]] = '*';
            }
            for (; pos[0]+1<temp_h+padding; pos[0]++) {
                matrix[pos[0]][pos[1]] = '*';
            }
            matrix[pos[0]][pos[1]] = '*';
        }

        for (int i=0; i<height; i++) {
            for (int j=0; j<width; j++) {
                System.out.print(matrix[i][j]);
            }
            System.out.println();
        }
    }
}
