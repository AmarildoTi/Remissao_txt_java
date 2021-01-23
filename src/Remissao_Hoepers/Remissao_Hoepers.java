/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Remissao_Hoepers;

/**
 *
 * @author Amarildo dos Santos de Lima
 */


//import java.util.logging.Level;
//import java.util.logging.Logger;
import javax.swing.*;
import javax.swing.text.*;
import java.awt.*;
import java.awt.event.*;
import java.text.*;
import java.io.*;
//import java.util.Vector;

public class Remissao_Hoepers extends JFrame 
{
    
    private JLabel rotulo1, rotulo2, rotulo3, rotulo4, rotulo5, rotulo6, rotulo7, rotulo8, rotulo9;  // Label
    private JTextField texto1, texto2, texto3, texto4;                                               // Caixa de texto
    private JButton botao1, botao2, botao3, botao4, botao5;                                          // Botão
    private JPasswordField texto5;                                                                   // Texto Em PassWord
    private JFormattedTextField texto6;                                                              // Texto Formatado                     
    private MaskFormatter mascaratexto6;                                                             // Mascara de Texto
    private JTextArea textArea1,textArea2;                                                           // Carrega uma area no painel 
    private JScrollPane scrollPane;                                                                  // ScrollPane , Ou barra de Rolagem   
    private JProgressBar ProgressBar;
    private JPanel painel;
    private JFrame frame;   
    private String Chave_Primaria, Chave_Segundaria, Form , Form1, Form2;
    int posInicial, Line, Cont_Reg, Cont_Lin, Cont_DJDE, Forms, minValue, maxValue, Total_Line, Flag; 
    boolean Monta_Cabecalho = true, Insere_DJDE, Faz;
    
    public Remissao_Hoepers() 
     {
               
        super("Programa de Remissão Hoepers = 14/12/2009 14:10");
        final Container tela = getContentPane();
        setLayout(null);
       
        ImageIcon icone = new ImageIcon("C:\\Estudo\\Java\\Graficos Em Java\\JanelaCaixaTextoLabelbotao\\teste.GIF");
          //icone = new ImageIcon("C:\\Estudo\\Java\\Graficos Em Java\\Remissao_Hoepers\\teste.GIF");
          //setIconImage(icone.getImage()); // Troca o Icone do Java por outro Icone
          // System.out.println("Conteudo do arquivo = "+String.valueOf(arquivo));   //Converter Inteiro Para String
        
        
        textArea1 = new JTextArea();
        textArea2 = new JTextArea();        
        textArea1.setEditable(false);                 // Abilita a edição do texto Com true e desabilita com false
        
        ProgressBar = new JProgressBar();
        ProgressBar.setMinimum(minValue);
        //ProgressBar.setMaximum(maxValue);
        ProgressBar.setStringPainted(true);
        
        scrollPane = new JScrollPane(textArea1);  
        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);      
        scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED); 
            
        rotulo1 = new JLabel("Nome");                  //
        rotulo2 = new JLabel("Idade");                 //  TITULOS DAS LABEL
        rotulo3 = new JLabel("Telefone");              // 
        rotulo4 = new JLabel("Celular");               //
        rotulo5 = new JLabel(icone);                   // Carrega a Imagem Em Uma Label
        rotulo6 = new JLabel("Senha");                 // Senha
        rotulo7 = new JLabel("Data");                  // Data
        rotulo8 = new JLabel("A Senha Digitada é ");   // Descobre a Senha Digitada

        try {                                                    //-------
            mascaratexto6 = new MaskFormatter("##/##/####");     //-------\   Funções Para Formatar Texto
            mascaratexto6.setPlaceholderCharacter('_');          //-------/ 
            }                                                    //------- 
        catch (ParseException excp) 
        {
          // Função de Mensagem de Erro
        }                                                 
        texto6 = new JFormattedTextField(mascaratexto6); 


        texto1 = new JTextField(50);                 // 
        texto2 = new JTextField(3);                  // TITULOS CAIXA DE TEXTO
        texto3 = new JTextField(10);                 //
        texto4 = new JTextField(10);                 //
        texto5 = new JPasswordField(10);             //

        botao1 = new JButton("Abrir");               //
        botao2 = new JButton("Pesquisar");           // TITULOS DOS BOTOÃO
        botao3 = new JButton("Salvar");              // 
        botao4 = new JButton("Sair");                // Botão Sair
       // botao5 = new JButton("Imagem ", icone);    // Carrega Imagem Em Um Botão

        rotulo8.setVisible(false);                   // Oculta O Rotulo Até o Botão Mostra Ser Acionado e Exibir Label Exibe a Senha


        //textArea1.setBounds(0, 0, 474, 367);        //  

        ProgressBar.setBounds(410, 393,80, 18);
        ProgressBar.setBorder(BorderFactory.createLineBorder(Color.blue));
        
        scrollPane.setBounds(0, 0, 494, 387);         //
        scrollPane.setBorder(BorderFactory.createLineBorder(Color.black));
  
        
        rotulo1.setBounds(50, 20, 80, 20);           //  
        rotulo2.setBounds(50, 60, 80, 20);           // POSIÇÃO DAS LABEL
        rotulo3.setBounds(50, 100, 80, 20);          //
        rotulo4.setBounds(50, 140, 80, 20);          //
        rotulo5.setBounds(10, 200, 310, 200);        // Label Com Imagem
        rotulo6.setBounds(251, 20, 200, 500);        // Label Senha
        rotulo7.setBounds(50, 180, 80, 020);         // Data
        rotulo8.setBounds(251, 020, 200, 540);       // Exibe a Senha

                                                                       //-------- 
             //    String senha = new String(texto5.getPassword());    //----------\  Está Função Da a Acão Para que a Senha Digitada Seja Exibida na Label
             //    rotulo8.setVisible(true);                           //----------/                          
             //    rotulo8.setText(senha);                             //-------- 
       
        texto1.setBounds(110, 20, 200, 20);          // 
        texto2.setBounds(110, 60, 20, 20);           // POSIÇÃOS DAS CAIXA DE TEXTO
        texto3.setBounds(110, 100, 80, 20);          //
        texto4.setBounds(110, 140, 80, 20);          // 
        texto5.setBounds(295, 260, 70, 20);          // 
        texto6.setBounds(110, 180, 70, 20);          // Data

        botao1.setBounds(05, 390,100, 25);           // Botão Pesquisa
        botao2.setBounds(105, 390,100, 25);          // Botão Imagem
        botao3.setBounds(205, 390,100, 25);          //
        botao4.setBounds(305, 390,100, 25);          //
        //botao5.setBounds(400,390,90,20);           // Botão Com Imagem

        texto1.setBackground(Color.yellow);          //
        texto2.setBackground(Color.blue);            // COR DE FUNDO DA CAIXA DE TEXTO
        texto3.setBackground(Color.red);             //
        texto4.setBackground(Color.pink);            //

        texto1.setFont(new Font("Arial", Font.BOLD, 14));               //
        texto2.setFont(new Font("Arial", Font.BOLD, 13));               // TAMANHO E ESTILO DA FONTE DA CAIXA DE TEXTO
        texto3.setFont(new Font("Arial", Font.BOLD, 12));               //
        texto4.setFont(new Font("Arial", Font.BOLD + Font.ITALIC, 11)); // 

        texto1.setForeground(Color.pink);        //   
        texto2.setForeground(Color.red);         // COR DOS CARACTERES DIGITADOS NA CAIXA DE TEXTO
        texto3.setForeground(Color.yellow);      // 
        texto4.setForeground(Color.blue);        //

        botao1.setForeground(Color.black);       //   
        botao2.setForeground(Color.black);       // COR DOS CARACTERES DIGITADOS NA CAIXA DE TEXTO
        botao3.setForeground(Color.black);       // 
        botao4.setForeground(Color.black);       //
        //botao5.setForeground(Color.black);     //

        botao1.setMnemonic(KeyEvent.VK_ENTER);          //
        botao2.setMnemonic(KeyEvent.VK_ENTER);          // Adicionando Eventos ao Botão 
        botao3.setMnemonic(KeyEvent.VK_ENTER);          //  
        botao4.setMnemonic(KeyEvent.VK_ENTER);          //
        //botao5.setMnemonic(KeyEvent.VK_ENTER);        //
 
     
        
        

 textArea1.addFocusListener(new FocusAdapter(){   
    @Override //public void focusLost(FocusEvent e) {   // FocusLost Sinaliza a Perda de Foco  // focusGained Sinaliza o Ganho do Foco
     public void focusGained(FocusEvent e){   
         textArea1.requestFocus();
         getRootPane().setDoubleBuffered(false);   
      //   System.out.println("O Foco Está textArea1");
     }   
 });  

 botao1.addFocusListener(new FocusAdapter(){   
    @Override //public void focusLost(FocusEvent e) {   // FocusLost Sinaliza a Perda de Foco  // focusGained Sinaliza o Ganho do Foco
     public void focusGained(FocusEvent e){   
         botao1.requestFocus();
         getRootPane().setDefaultButton(botao1);   
      //   System.out.println("O Foco Está botao1");
     }   
 });  

 botao2.addFocusListener(new FocusAdapter(){   
    @Override //public void focusLost(FocusEvent e) {   // FocusLost Sinaliza a Perda de Foco  // focusGained Sinaliza o Ganho do Foco
     public void focusGained(FocusEvent e){   
         botao2.requestFocus();
         getRootPane().setDefaultButton(botao2);   
     //    System.out.println("O Foco Está botao2");
     }   
 });  

 botao3.addFocusListener(new FocusAdapter(){   
    @Override //public void focusLost(FocusEvent e) {   // FocusLost Sinaliza a Perda de Foco  // focusGained Sinaliza o Ganho do Foco
     public void focusGained(FocusEvent e){   
         botao3.requestFocus();
         getRootPane().setDefaultButton(botao3);   
     //    System.out.println("O Foco Está botao3");
     }   
 });  

 botao4.addFocusListener(new FocusAdapter(){   
     @Override //public void focusLost(FocusEvent e) {   // FocusLost Sinaliza a Perda de Foco  // focusGained Sinaliza o Ganho do Foco
     public void focusGained(FocusEvent e){   
         botao4.requestFocus();
         getRootPane().setDefaultButton(botao4);   
     //    System.out.println("O Foco Está botao4");
     }   
 });  

 

        texto5.setEchoChar('*');                 // Para Altera o Caracter Que Esconde a Senha

        texto1.setHorizontalAlignment(JTextField.LEFT);     //
        texto2.setHorizontalAlignment(JTextField.RIGHT);    // ALINHAMENTO QUE DA CAIXA DE TEXTO
        texto3.setHorizontalAlignment(JTextField.CENTER);   //
        texto4.setHorizontalAlignment(JTextField.RIGHT);    //

        //tela.add(rotulo1);               //
        //tela.add(rotulo2);               // ADICIONA A LABEL NA JANELA
        //tela.add(rotulo3);               // 
        //tela.add(rotulo4);               //
        //tela.add(rotulo5);               // Adiciona Label Com Imagem
        //tela.add(rotulo6);               // Senha
        //tela.add(rotulo7);               // Data
        //tela.add(rotulo8);               // Exibe A Senha

        //tela.add(texto1);                //
        //tela.add(texto2);                // ADICIONA CAIXA DE TEXTO NA JANELA
        //tela.add(texto3);                //
        //tela.add(texto4);                //  
        //tela.add(texto5);                // Senha
        //tela.add(texto6);                // Data

        tela.add(botao1);                  //
        tela.add(botao2);                  // ADICIONA BOTAO NA JANELA
        tela.add(botao3);                  //
        tela.add(botao4);                  //
        //tela.add(textArea1);             // Area de Texto a ser Preenchida
        tela.add(ProgressBar);
        tela.add(scrollPane);              // Barra de Rolagem 
                    // 

        
        
    botao1.addActionListener(new ActionListener(){                          
        public void actionPerformed(ActionEvent Clik){                                                     
              ProgressBar.setValue(0);
              //JFileChooser fileChooser = new JFileChooser("."); 
              JFileChooser fileChooser = new JFileChooser("P:"); // Força a Abrir em uma Pasta Determinada
              fileChooser.showOpenDialog(tela);
              File arquivo_Entrada = fileChooser.getSelectedFile();

            if (arquivo_Entrada != null){

                        textArea1.setText("");
                        String s = LeitorBuffer.ler(arquivo_Entrada);
                        textArea1.append(s);

                        s = null;
                        arquivo_Entrada = null;
                        fileChooser = null;
                        textArea1.setCaretPosition(0);
                        int quant = textArea1.getLineCount();
                        maxValue = quant;
                        ProgressBar.setMaximum(maxValue - 2);
                       // System.out.println("Bytes e memoria livres  Antes de passar ganbage collection o System.gc() = " + Runtime.getRuntime().freeMemory());

                       System.gc();

                        for (int j = 0; j < quant; j++) {
                            final int percent = j;
                            // Função Para Barra de Processamento Começo
                            ProgressBar.setValue(percent);
                            // Função Para Barra de Processamento Final
                        }
            }
        }
    });
         
    botao2.addActionListener(new ActionListener(){                          
        public void actionPerformed(ActionEvent Clik){                                                     
           ProgressBar.setValue(0);
           if (!textArea1.getText().equals("")){  
              textArea1.setCaretPosition(0); // Mantem o Cursor no inicio
              Chave_Segundaria = "+$DJDE$";            
              Chave_Primaria = JOptionPane.showInputDialog(null, " Digite Ou Use o Leitor Optico Para Pesquisa ", "Box de Pesquisa", JOptionPane.INFORMATION_MESSAGE);
           }else{
                JOptionPane.showMessageDialog(null, "            Não Foi Selecionado Nenhum Arquivo "+"\n"+"Por Favor Click em Abrir Para Selecionar o Arquivo "+"\n"+"                             a Ser Pesquisado", "                   Mensagem de Erro Verificar", JOptionPane.ERROR_MESSAGE) ;
                }
   
           if (Chave_Primaria != null){
               if (!Chave_Primaria.equals("")){   
                       int Codigo_de_Pesquisa = textArea1.getText().indexOf(Chave_Primaria.trim().toUpperCase(), posInicial);
                       if(Codigo_de_Pesquisa < 0){
                          JOptionPane.showMessageDialog(null, "    Codigo Não Encontrado   ");
                          posInicial = 0;   
                       }else{
                                                    
                          Cont_Reg++; 
                          
                          if(Cont_Reg > 1){
                                Monta_Cabecalho = false;
                            }   

                          //  System.out.println("Resultado da Variavel Boolean = "+Monta_Cabecalho);   //Converter Inteiro Para String

                            textArea1.requestFocus();
                            textArea1.select(Codigo_de_Pesquisa, Codigo_de_Pesquisa + Chave_Primaria.length());
                            posInicial = Codigo_de_Pesquisa + Chave_Primaria.length();
                            
                          int quant = textArea1.getLineCount();
                          maxValue=quant;
                          ProgressBar.setMaximum(maxValue-2);
                          
                          for(int i = 0; i < quant; i++){
                            try{
                                  int inicio = textArea1.getLineStartOffset(i);
                                  int fim = textArea1.getLineEndOffset(i);
                                  final int percent = i;
                             
                            // Função Para Barra de Processamento Começo
                                  ProgressBar.setValue(percent);
                            // Função Para Barra de Processamento Final
                            
                                  String linha = textArea1.getText(inicio, fim - inicio);
                                 // JOptionPane.showMessageDialog(null, "LINHA = " + (i + 1) + " = " + linha);
                                     if(linha.indexOf(Chave_Segundaria.trim().toUpperCase()) == 0 && posInicial != 0){   
                                         //System.out.println("Achou uuuu ");                              
                                         Cont_Lin = 0;
                                         Cont_DJDE++;
                                         
                                        if(Cont_DJDE == 1){
                                          Form1 = linha.trim().substring(0);    
                                          Form1 = Form1.replaceAll("_A3" , "_A4");
                                        }else if(Cont_DJDE == 2){
                                          Form2 = linha.trim().substring(0);
                                          Form2 = Form2.replaceAll("_A3" , "_A4");
                                        }                               
                                     }
                                 
                                 if (linha.indexOf(Chave_Primaria.trim().toUpperCase()) >0){
                                      
                                   Cont_Lin++;
                                                                                                                                            
                                    if(Cont_Lin == 1){ 
                                       Forms++;
                                    }else if(Forms >= 2){
                                        Forms = 0;
                                    }   
                                  
                                     if(Forms == 1 && Cont_Lin == 1){
                                        Form = Form1;
                                        Insere_DJDE = true; 
                                        Flag = 1;                                     
                                     }else if(Forms == 2 && Cont_Lin == 1){
                                        Form = Form2;
                                        Insere_DJDE = true;
                                        Flag = 2;
                                     }else { 
                                        Insere_DJDE = false;
                                        Line = 0;
                                        Total_Line = Cont_Lin-1;
                                     }    
                                    // System.out.println("cont_linha "+Cont_Lin);
                                    // System.out.println("Vedadeiro ou falso "+Insere_DJDE);                                  
                                    // System.out.println("Formulario "+Form);
                                 }

                                  
                                  // ***** Abaixo a Função Já Esta Funcionando Para Remissao Em A4 Começo
                                   if (linha.indexOf(Chave_Primaria.trim().toUpperCase()) > 0 || i < 4 && Monta_Cabecalho == true ){ 
                                            
                                      //  JOptionPane.showMessageDialog(null, " Cont_Lin = " + Cont_Lin +" Total_Line = " + Total_Line+" Formulario = " + Forms+" Flag = " + Flag);

                                   //  if(Total_Line > Cont_Lin){
                                   //   do {
                                   //     System.out.println("******************* Fazendo **********************");
                                   //     Line++;
                                   //     textArea2.setText(textArea2.getText()+"KKK = "+Line+"\r\n");
                                    //   }while (  Line <= Total_Line  );
                                    //  }
                                       
                                       if(Insere_DJDE == true){
                                        textArea2.setText(textArea2.getText()+Form+"\r\n");
                                        //System.out.println("Total_Line "+Total_Line);
                                       }

                                       textArea2.setText(textArea2.getText()+linha.trim().substring(0)+"\r\n");    
                                      // System.out.println(textArea2.getText()+" Flag "+Flag );
                                   }
                                 // ***** Acima a Função Já Esta Funcionando Para Remissao Em A4 Final
                            
                            }catch(BadLocationException ex){
                                 // possiveis erros são tratados aqui
                            } 
                          }    
                       }
               }else{
                  JOptionPane.showMessageDialog(null, "Não Foi Inserido o Codigo Para Pesquisa", "Mensagem de Erro Verificar", JOptionPane.ERROR_MESSAGE);
                    }   
          }   
        
        }         
    });
         
    botao3.addActionListener(new ActionListener(){                           
        public void actionPerformed(ActionEvent Clik){  
             ProgressBar.setValue(0);
             if (!textArea2.getText().equals("")){
                         //JFileChooser fc = new JFileChooser();                       
                         JFileChooser fc = new JFileChooser("R://REMISSÕES"); // Força a Abrir em uma Pasta Determinada
                 if(fc.showSaveDialog(Remissao_Hoepers.this) != JFileChooser.APPROVE_OPTION){
                        return;
                 }   
                       File arquivo_Saida = fc.getSelectedFile(); 
                    if(arquivo_Saida == null){
                         return;
                    }   
                       FileWriter writer = null;   
                      try{
 
                          writer = new FileWriter(arquivo_Saida);
                          writer.write(textArea2.getText());
                             int quant = textArea2.getLineCount();
                             maxValue=quant;
                             ProgressBar.setMaximum(maxValue-2);
                             for(int j = 0; j < quant; j++){
                               final int percent = j;
                               // Função Para Barra de Processamento Começo
                                ProgressBar.setValue(percent);
                               // Função Para Barra de Processamento Final
                             }
                         }catch(IOException ex){
                    //   Possiveis erros aqui
                         } 
                      finally{
                             if(writer != null){
                                 try{
                                  writer.close();
                                 }catch (IOException x){
                                // Codigo de erro a ser Inserido   
                                 }
                               }
                             }
               }else{            
                  JOptionPane.showMessageDialog(null, "Não Foi Selecionado Nenhum Registro", "Mensagem de Erro Verificar", JOptionPane.ERROR_MESSAGE);
                    }   
        }                                            
    });                                              

    botao4.addActionListener(new ActionListener(){                 //-------                                            
        public void actionPerformed(ActionEvent Clik){             //----------\  Está Função Da a Ação Sair Para o Botão
              System.exit(0);                                      //----------/
        }                                                          //-------- 
    });                                          
    
          tela.setBackground(Color.black);                      //Tela cores padrão 
          //tela.setBackground(new Color(230, 230, 230));      // Telas cores Personalizadas
          pack();
          setSize(500, 450);
          setVisible(true);
          setLocationRelativeTo(null);
         //setExtendedState(ICONIFIED);                           // Para Exibir Janela Minimizada
         //setExtendedState(MAXIMIZED_BOTH);                      // Para Exibir Janela Maximizada
          setResizable(false);                                 // Para desabilitar o Botão de Maximizar 
 
          System.gc();
   }

    public static void main(String args[]){
        Remissao_Hoepers app = new Remissao_Hoepers();
        app.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}
