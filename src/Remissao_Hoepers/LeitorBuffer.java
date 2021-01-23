/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Remissao_Hoepers;

/**
 *
 * @author Amarildo dos Santos de Lima
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class LeitorBuffer {

    public static String ler(File arquivo) {
       //StringBuilder sb = new StringBuilder();  //Primeira  Formúla de carregar Arquivo 
       StringBuffer sb = new StringBuffer();      //Segunda Formúla de carregar Arquivo   
     try {
          

                    //Segunda Formúla de carregar Arquivo   
                    BufferedReader br = new BufferedReader (new FileReader (arquivo));  
                    String linha;  
                    while ((linha = br.readLine()) != null) {  
                        sb.append (linha).append ("\r\n");  
                    }  
                    br.close();  
         

            /*  //Primeira  Formúla de carregar Arquivo
            FileReader reader = new FileReader(arquivo);
            BufferedReader bufReader = new BufferedReader(reader);
            String s;
            do {
                s = bufReader.readLine();
                if (s != null) {
                sb.append(s).append("\r\n");
                }
            } while (s != null);

            bufReader.close();
            reader.close();
            
            s = null;
            bufReader = null;           
            reader = null;
  
           System.gc(); 
           */ 
             

        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
        }
 }
