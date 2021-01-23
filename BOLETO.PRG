Set Procedure To Z:\cif\fac\FACHORP2  
Set Procedure To Z:\cif\fac\RotDev

Set Wrap On
Set Date Brit
Set Score Off
Set Century On
Set Confirm On
Set Exact On

CLEAR
Public ArqEnt
ArqEnt = "100_CRED.TXT" //Space(12)
ArqSai = "100_CRED"     //Space(8)
ArqRel = Space(12)

MesAnoRef=Space(14)
Janela(06,20,23,60,"GR+/B")
@ 07,22 say '                FAC                 '
@ 08,22 say ' HOEPERS - BOLETO MULTIPLA BRADESCO '
@ 10,22 say 'Arquivo Entrada : '  get ArqEnt
@ 12,22 say 'Arquivo Sa¡da   : '  get ArqSai
*@ 14,22 say ' MES REFERENCIA :' Get mesanoref
Read
If  ArqEnt = space(12) .or. ArqSai = space(12)
   Cls
   Return
Endif
If .not. File(ArqEnt)
   @ 16,22 say 'ARQUIVO NAO ENCONTRADO'
   Inkey(4)
   Cls
   Return
ENDIF

OpcaoG := Alerta("Gerar:",{"Cred_Financial","Cred_Notifica‡Æo","Cred_Retail","Cred_Citibank"})

OpcaoPapel := Alerta("Gerar em:?",{"PAPEL A4","PAPEL A3"})

If OpcaoPapel = 1
  Final  = 1
  Papel  = "A4"
  PapelX = "_A4"
  Quebra = 2000
ElseIf OpcaoPapel = 2
  Final  = 2
  Papel  = "A3"
  PapelX = "_A3"
  Quebra = 2000
Endif

Do Banco
Do Comeco

seqlocal = 0
seqestadual = 0
seqnacional = 0
SeqMogi= 0

Indx = 1

seqlTot = 0
seqeTot = 0
seqnTot = 0
seqMTot = 0

public aop

seq1=0
seq2=0
rotv=0
rotp=0
Seq = 0
SeqW = 0
Avista = 0
Parcelado = 0
SEQ=SPACE(5)
NOME=SPACE(30)
SEQUENCIA=0
OUX=SPACE(1)
PUBLIC PCMES[12]
PCMES[01]='JANEIRO'
PCMES[02]='FEVEREIRO'
PCMES[03]='MARCO'
PCMES[04]='ABRIL'
PCMES[05]='MAIO'
PCMES[06]='JUNHO'
PCMES[07]='JULHO'
PCMES[08]='AGOSTO'
PCMES[09]='SETEMBRO'
PCMES[10]='OUTUBRO'
PCMES[11]='NOVEMBRO'
PCMES[12]='DEZEMBRO'

DataProc=dtoc(date())

mdatamov=dataproc
mdiamov=substr(mdatamov,1,2)
mmesmov=substr(mdatamov,4,2)
manomov=substr(mdatamov,7,4)
cabec='            '+mdiamov+'        '+pcmes[val(mmesmov)]

Arqos=Alltrim(ArqSai)+'.OS'
AOP2=FCREATE(ARQOS,0)
FClose(AOP2)
AOP2=FOPEN(ARQOS,1)

public ind1
ind1=1
Crlf = Chr(13)+Chr(10)

DO VARIAVEIS1
DO LIMPA1

PROCESSA1()

********************** Codigo Devolu‡Æo _ M Come‡o
ArqDev(Str(OpcaoT),"M")                       // Move Arquivo
********************** Codigo Devolu‡Æo _ M Come‡o

close All

Delete File "Dados.DBF"
Delete File "Tipo00.DBF"
Delete File "Tipo01.DBF"
Delete File "Tipo02.DBF"
Delete File "Tipo03.DBF"
Delete File "Tipo04.DBF"
Delete File "Tipo05.DBF"
Delete File "Tipo06.DBF"
Delete File "Arquivo.txt"
Delete File "Tipo02.txt"
Delete File "Tipo03.txt"
Delete File "Tipo04.txt"

Delete File "Tipo00.NTX"
Delete File "Tipo01.NTX"
Delete File "Tipo02.NTX"
Delete File "Tipo03.NTX"
Delete File "Tipo04.NTX"
Delete File "Tipo05.NTX"
Delete File "Tipo06.NTX"

PROCEDURE PROCESSA1
A = 0
L = 3
WWW = 1
ArqSai2 = Alltrim(ArqSai)+"."+StrZero(www,3)
AOP=FCREATE(ARQSAI2,0)
FClose(AOP)
AOP=FOPEN(ARQSAI2,1)
WKW=FWRITE(AOP,'%!'+Crlf)
WKW=FWRITE(AOP,'XGF'+Crlf)
WKW=FWRITE(AOP,'500 SETBUFSIZE'+Crlf)
WKW=FWRITE(AOP,'(PRINCIPAL.JDT) STARTLM'+Crlf)

SELECT ENTRADA2
Goto top

Cifos=Substr(Alltrim(Codcif),11,5)

********************** Codigo Devolu‡Æo _ C Come‡o
ArqDev(Str(OpcaoT),"C",ArqEnt,Cifos)               // Cria Arquivo
********************** Codigo Devolu‡Æo _ C Final
                               
 If OpcaoT = 1 .And. OpcaoFac = 1
   X_CodCif = "7209072675"
   ArqDevFin = "Gerado_Como_Teste"
 ElseIf OpcaoT = 1 .And. OpcaoFac = 2
   X_CodCif = "7208298556" 
   ArqDevFin = "Gerado_Como_Teste"
 ElseIf OpcaoT = 1 .And. OpcaoFac = 3
   X_CodCif = "7205065429" 
   ArqDevFin = "Gerado_Como_Teste"
 ElseIf OpcaoT = 2 
   X_CodCif = Substr(Alltrim(Codcif),1,10)
 EndIf

MenorVenc = date()+91

do while .not. eof()
     SKIP A

SeqW++
If SeqW > Quebra
 WWW++
 WKW=FWRITE(AOP,'%%EOF'+Crlf)

  If OpcaoPapel = 1
    FWRITE(AOP2,'A'+';'+Upper(arqsai2)+';'+str(seqlocal)+';'+str(seqestadual)+';'+str(seqnacional)+";"+Alltrim("1")+";"+"N"+";"+Alltrim(Cifos)+';'+str(seqMogi)+';'+DtoC(MenorVenc)+';'+str((seqlocal+seqestadual+seqnacional)*2)+';'+str(seqlocal+seqestadual+seqnacional)+chr(13)+chr(10)) // A4
  ElseIf OpcaoPapel = 2
    FWRITE(AOP2,'A'+';'+Upper(arqsai2)+';'+str(seqlocal)+';'+str(seqestadual)+';'+str(seqnacional)+";"+Alltrim("1")+";"+"N"+";"+Alltrim(Cifos)+';'+str(seqMogi)+';'+DtoC(MenorVenc)+';'+str(seqlocal+seqestadual+seqnacional)+';'+str(Int((seqlocal+seqestadual+seqnacional)/2))+chr(13)+chr(10)) // A3
  Endif

 ArqSai2 = Alltrim(ArqSai)+"."+StrZero(www,3)
 AOP=FCREATE(ARQSAI2,0)                                                                                                                                                                                                       
 FClose(AOP)
 AOP=FOPEN(ARQSAI2,1)
 WKW=FWRITE(AOP,'%!'+Crlf)
 WKW=FWRITE(AOP,'XGF'+Crlf)
 WKW=FWRITE(AOP,'500 SETBUFSIZE'+Crlf)
 WKW=FWRITE(AOP,'(PRINCIPAL.JDT) STARTLM'+Crlf)
 Ind1 = 1
 SeqW = 1
 seqlocal = 0
 seqestadual = 0
 seqnacional = 0
 seqMogi = 0
 sequencia = 0
Endif

filialx=upper(substr(arqent,1,1))

IF EOF()
   @ 19,23 say 'total de fac local      '+str(seqlTot)
   @ 20,23 say 'total de fac estadual   '+str(seqeTot)
   @ 21,23 say 'total de fac nacional   '+str(seqnTot)
   @ 22,23 say 'total de fac Mogi       '+str(seqMTot)

  If OpcaoPapel = 1
    FWRITE(AOP2,'A'+';'+Upper(arqsai2)+';'+str(seqlocal)+';'+str(seqestadual)+';'+str(seqnacional)+";"+Alltrim("1")+";"+"N"+";"+Alltrim(Cifos)+';'+str(seqMogi)+';'+DtoC(MenorVenc)+';'+str((seqlocal+seqestadual+seqnacional)*2)+';'+str(seqlocal+seqestadual+seqnacional)+Crlf+;
                   'J'+';'+'PRINCIPAL.JDT'+Crlf+'J'+';'+'HOEPERS71'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS114'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS98'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS141'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERSDM'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERSICI'+PapelX+'.JDT'+Crlf+;
                   'P'+';'+'hoepers3v.ps'+Crlf+'P'+';'+'hoepersfach.ps'+Crlf+'P'+';'+'hoepersici.ps'+Crlf+'P'+';'+'hoepers71.ps'+Crlf+'P'+';'+'hoepers72.ps'+Crlf+'P'+';'+'hoepers114.ps'+Crlf+'P'+';'+'hoepers115.ps'+Crlf+'P'+';'+'hoepers141.ps'+Crlf+'P'+';'+'hoepers142.ps'+Crlf+'D'+';'+ArqDevFin+chr(13)+chr(10))

  ElseIf OpcaoPapel = 2
    FWRITE(AOP2,'A'+';'+Upper(arqsai2)+';'+str(seqlocal)+';'+str(seqestadual)+';'+str(seqnacional)+";"+Alltrim("1")+";"+"N"+";"+Alltrim(Cifos)+';'+str(seqMogi)+';'+DtoC(MenorVenc)+';'+str(seqlocal+seqestadual+seqnacional)+';'+str(Int((seqlocal+seqestadual+seqnacional)/2))+Crlf+; 
                   'J'+';'+'PRINCIPAL.JDT'+Crlf+'J'+';'+'HOEPERS71'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS114'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS98'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS141'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERS'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERSDM'+PapelX+'.JDT'+Crlf+'J'+';'+'HOEPERSICI'+PapelX+'.JDT'+Crlf+;
                   'P'+';'+'hoepers3v.ps'+Crlf+'P'+';'+'hoepersfach.ps'+Crlf+'P'+';'+'hoepersici.ps'+Crlf+'P'+';'+'hoepers71.ps'+Crlf+'P'+';'+'hoepers72.ps'+Crlf+'P'+';'+'hoepers114.ps'+Crlf+'P'+';'+'hoepers115.ps'+Crlf+'P'+';'+'hoepers141.ps'+Crlf+'P'+';'+'hoepers142.ps'+Crlf+'D'+';'+ArqDevFin+chr(13)+chr(10))
  Endif



If Ind1 > 1
   do imprime
Endif

/*

 If OpcaoT = 2

    Use CepCerto.dbf
    Copy To Arquivo.txt Sdf
    Use Remissao\Arquivo.Dbf 
    Append from Arquivo Sdf

    Select Tipo02
    Copy To Tipo02.txt Sdf
    Use Remissao\Tipo02.Dbf 
    Append from Tipo02 Sdf

    Select Tipo03
    Copy To Tipo03.txt Sdf
    Use Remissao\Tipo03.Dbf 
    Append from Tipo03 Sdf

    Select Tipo04
    Copy To Tipo04.txt Sdf
    Use Remissao\Tipo04.Dbf 
    Append from Tipo04 Sdf

 Endif
*/

   EXIT
ENDIF
Seq2++
sequencia=sequencia+1

cepb=strtran(cep,'-','')
cepb=strtran(cepb,' ','')
cepb=strtran(cepb,'.','')
cepb=Padl(alltrim(cepb),8,"0")

IF VAL(CEPB) >= 8700001 .And. VAL(CEPB) <= 8889999
seqMogi=seqMogi+1
seqMtot++
ENDIF
IF VAL(CEPB) < 10000000
seqlocal=seqlocal+1
seqltot++
ENDIF
IF VAL(CEPB) >= 11000000
IF VAL(CEPB) < 20000000
seqestadual=seqestadual+1
sEQETOT++
ENDIF
ENDIF
IF VAL(CEPB) >= 20000000
seqnacional=seqnacional+1
seqntot++
ENDIF

barracif=codcif
*barrapost=nossonum

*********************************************************DATA DE PROCESSAMENTO
DATAPROC=DTOC(DATE())
@ 17,30 say 'Aguarde      !!!!' color 'W/B'
*********************************************************DATA DE PROCESSAMENTO

*************************************************variavel do registro Tipo02
   XConf2       =  ""
   XValordesc   =  ""
   XValoratual  =  ""
   XDesconto    =  ""
   XPercDesc2   =  ""
select Tipo02
Seek Entrada2->id
If Found()
   XValoratual  = Valoratual
   Xvalordesc   = Valordesc
   XDesconto    = Desconto
   XPercDesc2   = PercDesc2
   Xconf2       = Id
Endif
*************************************************variavel do registro Tipo02
/*
*************************************************variavel do registro Tipo03
   Xconf3       = ""
   XParcelas    = "00"
   XValorEntr   = ""
   XValorParc   = ""
   XPercDesc3   = ""
select Tipo03
Seek Entrada2->id
If Found()
   XParcelas    = Parcelas
   XValorEntr   = ValorEntr
   XValorParc   = ValorParc
   XPercDesc3   = PercDesc3
   Xconf3       = Id
Endif
*************************************************variavel do registro Tipo03
*/

*************************************************variavel do registro Tipo03
Select Entrada2
    kprocura   =""
    kprocura   = id
    Xconf3     = ""
    select Tipo03
    Seek kprocura
  if found()
     kconf3    = ""
     kPROBLEM=0
     k = 1
     While k <= 9
        if id = kprocura
              linhamenP[IND1][k]=Space(1)+"PARCEL"+"Entrada de //F7"+"R$ "+Alltrim(Editadois(ValorEntr))+" //F0+ //F7"+Parcelas+" //F0parcelas de  //F7"+"R$ "+Alltrim(Editadois(ValorParc))  //+Space(01)+" //FA(NESTA OPÇÃO CONCEDIDO DESCONTO DE "+Alltrim(Editadois(Percdesc3))+"%)" 
              linhamenF[IND1][k]=Space(1)+"PARCEL"+"Entrada de //F3"+"R$ "+Alltrim(Editadois(ValorEntr))+" //FX+ //F3"+Parcelas+" //FXparcelas de  //F3"+"R$ "+Alltrim(Editadois(ValorParc))  //+Space(01)+" //FX(NESTA OPÇÃO CONCEDIDO DESCONTO DE//F3 "+Alltrim(Editadois(Percdesc3))+"%)" 
              KPROBLEM++
        Endif
       skip 
        k = k + 1
      enddo
   Else
     kPROBLEM=0
              linhamenP[IND1][1]=Space(1)+"AVISTA"+"***SURPRESA PARA VOCÊ***"
              linhamenP[IND1][2]=Space(1)+"AVISTA"+"Para este contrato foi concedido um DESCONTO EXTRA."
              linhamenP[IND1][3]=Space(1)+"AVISTA"+"Essa condição é exclusivamente para pagamento a vista."
              linhamenP[IND1][4]=Space(1)+"AVISTA"+"Aproveite!"
              linhamenP[IND1][5]=Space(1)+"AVISTA"+""
              linhamenP[IND1][6]=Space(1)+"AVISTA"+""
              linhamenP[IND1][7]=Space(1)+"AVISTA"+""
              linhamenP[IND1][8]=Space(1)+"AVISTA"+""
              linhamenP[IND1][9]=Space(1)+"AVISTA"+""

              linhamenF[IND1][1]=Space(1)+"AVISTA"+"***SURPRESA PARA VOCÊ***"
              linhamenF[IND1][2]=Space(1)+"AVISTA"+"Para este contrato foi concedido um DESCONTO EXTRA."
              linhamenF[IND1][3]=Space(1)+"AVISTA"+"Essa condição é exclusivamente para pagamento a vista."
              linhamenF[IND1][4]=Space(1)+"AVISTA"+"Aproveite!"
              linhamenF[IND1][5]=Space(1)+"AVISTA"+""
              linhamenF[IND1][6]=Space(1)+"AVISTA"+""
              linhamenF[IND1][7]=Space(1)+"AVISTA"+""
              linhamenF[IND1][8]=Space(1)+"AVISTA"+""
              linhamenF[IND1][9]=Space(1)+"AVISTA"+""
   Endif

    if kproblem > 9
       cls
       @ 10,10 say "Quantidade maior que 9 posi‡äes no tipo03"
       @ 11,10 say "verificar o programa ...."
       inkey(0)
       quit
    endif
***************************************************variavel do registro Tipo03

*************************************************variavel do registro Tipo04
Select Entrada2
    xprocura=""
    xprocura=id
    Xconf4       = ""
    select Tipo04
    Seek xprocura
  if found()
     Xconf4       = ""
     XPROBLEM=0
     x = 1
     while x <= 8
        if id = xprocura
              linhamenI[IND1][x]=Space(1)+padr(alltrim(Produto),25," ")+Space(2)+'R$'+Space(01)+alltrim(Editadois(Valor))      //+space(03)+tipoF->vl_icms_f
              XPROBLEM++
        Endif
      skip
     x = x + 1
     enddo
  Else
   XPROBLEM=0

    linhamenI[IND1][1]=Space(01)
    linhamenI[IND1][2]=Space(01)
    linhamenI[IND1][3]=Space(01)
    linhamenI[IND1][4]=Space(01)
    linhamenI[IND1][5]=Space(01)
    linhamenI[IND1][6]=Space(01)
    linhamenI[IND1][7]=Space(01)
    linhamenI[IND1][8]=Space(01)

  Endif

    if xproblem > 8
       cls
       @ 10,10 say "Quantidade maior que 8 posi‡äes no tipo04"
       @ 11,10 say "verificar o programa ...."
       inkey(0)
       quit
    endif
***************************************************variavel do registro Tipo04

select Entrada2

******************************************************* COMECO  BANCO UNIBANCO

********************* conferecia do regitro Tipo02 com o entrada2
if Xconf2 <> id
@ 16,28 say "erro em chave de arquivo Tipo2 "+space(01)+alltrim(id)
erro = erro
endif
********************* conferecia do regitro Tipo02 com o entrada2

/*
********************* conferecia do regitro Tipo03 com o entrada2
if Xconf3 <> id
@ 16,28 say "erro em chave de arquivo Tipo3 "+space(01)+alltrim(id)
erro = erro
endif
********************* conferecia do regitro Tipo03 com o entrada2
*/

******************************************************** COMECO BANCO BRADESCO
************************ DADOS FIXOS DO BANCO BRADESCO ************************** 
//Cedente   = 'Banco Bradesco S/A'
Cedente   = 'Hoepers S/A'
Carteira1 = '06'

If Agencia_V = "41203"
Agencia1  = '4120'
Digagen   = '3'
ElseIf Agencia_V = "03247"
Agencia1  = '0324'
Digagen   = '7'
Else
Erro= ErroAgencia
Endif

If Conta_V = "01699830"
Conta1    = '0169983'
DigConta  = '0'
ElseIf Conta_V = "01641530"
Conta1    = '0164153'
DigConta  = '0'
Else
Erro= ErroContaCorrre
Endif

If Agencia_V = "03247"
 Mageced   = Substr(Agencia1,2,3)+'-'+Digagen+' / '+substr(Conta1,2,6)+'-'+DigConta
Else
 Mageced   = Agencia1+'-'+Digagen+' / '+Conta1+'-'+DigConta
Endif
@ 14,1 SAY Mageced

If Vencimento = "16/11/2009"
  X_Venci = "20/11/2009"
 Else
  X_Venci = Vencimento
EndIf

************************ DADOS FIXOS DO BANCO BRADESCO **************************

********************************************* ROTINA PARA VERIFICAR VENCIMENTO
 vencidos = X_Venci
     rotvencido()
  *   @ 19,22 say datacalc
  if  rotp <> 0 
     @ 16,22 say "obs: h  "+alltrim(str(rotp))+" boleto(s) c/ vencimento MENOR que 7 dias" color "*r/w"
 *    inkey(0)
 *    quit
 *    exit
  Endif
   if rotv <> 0
     @ 17,22 say "obs: h  "+alltrim(str(rotv))+" boleto(s) vencidos" color "*r/w"
*     inkey(0)
*     quit
*     exit
   endif

  if MenorVenc > CtoD(X_Venci)
      MenorVenC = CtoD(X_Venci)
  EndIf

@ 15,22 say "Vencimento mais pr¢ximo : "+DtoC(MenorVenc)
********************************************* ROTINA PARA VERIFICAR VENCIMENTO


******************************* FATOR DE VENCIMENTO **************************
Fator = Str(CtoD(Limite)-CtoD("07/10/1997"),4)
******************************* FATOR DE VENCIMENTO ************************** 
                     
******************************* VALOR DO DOCUMENTO  **************************
If Substr(linhamenP[IND1][1],2,6) = "PARCEL"
Mvalor = Padl(alltrim(""),10,"0") // Com parcelamento
Else
Mvalor = Padl(alltrim(Xvalordesc),10,"0") // sem parcelamento
Endif
******************************* VALOR DO DOCUMENTO  **************************

*************************** CALCULO DO NOSSO NUMERO **************************
Nosson1=Padl(Alltrim(Str(val(Nossonum))+DigNosso),11,'0')
Dign1=MOD_11_7(Carteira1+Nosson1)
Nnumero=Carteira1+'/'+Nosson1+'-'+Dign1
*Nnumero=Carteira1+'/'+Nosson1+'-'+DigNosso
*************************** CALCULO DO NOSSO NUMERO **************************

*************************** CALCULO DO CàDIGO DE BARRAS **************************
CodBarra='2379'+Fator+Mvalor+Agencia1+Carteira1+Nosson1+Conta1+'0'
Dig_Barra=MOD11_9(CodBarra)
If Dig_Barra = 0 .Or. Dig_Barra = 1 .Or. Dig_Barra > 9
Dig_Barra=1
Endif

CodBarra='2379'+str(Dig_Barra,1)+Fator+Mvalor+Agencia1+Carteira1+Nosson1+Conta1+'0'
*************************** CALCULO DO CàDIGO DE BARRAS **************************

*************************** CALCULO DA LINHA DIGITAVEL  **************************
****************************** LINHA DIGITAVEL  ******************************
Linhadig='2379'+Agencia1+Carteira1+Nosson1+Conta1+'0'

Digtav1=Substr(Linhadig,1,9)
Digtov1=MOD10(Digtav1)
Digtav2=Substr(Linhadig,10,10)
Digtov2=MOD10(Digtav2)
Digtav3=Substr(Linhadig,20,10)
Digtov3=MOD10(Digtav3)

Linhadig=Substr(Digtav1,1,5)+'.'+Substr(Digtav1,6,4)+Str(Digtov1,1)+'  '+Substr(Digtav2,1,5)+'.'+Substr(Digtav2,6,5)+Str(Digtov2,1)+;
     '  '+Substr(Digtav3,1,5)+'.'+Substr(Digtav3,6,5)+STR(Digtov3,1)+'  '+Str(Dig_Barra,1)+'  '+Alltrim(Fator+Mvalor)
****************************** LINHA DIGITAVEL  ******************************
*************************** CALCULO DA LINHA DIGITAVEL  **************************

********************** Codigo Devolu‡Æo _ G Come‡o // Grava
vNull = " "
ArqDev(Str(OPCAOT),"G", , ,"NOMECLI|HOEPERS#CIF|"+CodCif+;
                                       "#CPF|"         +Alltrim(Cpf)+;
                                       "#RG|"          +Alltrim(vNull)+;
                                       "#DOCUMENTO|"   +Alltrim(CodDivida)+','+Alltrim(codcredor)+;
                                       "#CEDENTE|"     +AllTrim(Cedente)+;
                                       "#Nome|"        +Alltrim(Nome)+;
                                       "#ENDERECO|"    +Alltrim(Endereco)+;
                                       "#NUMERO|"      +Alltrim(vNull)+;
                                       "#COMPLEMENTO|" +Alltrim(vNull)+;
                                       "#BAIRRO|"      +Alltrim(vNull)+;
                                       "#CIDADE|"      +Alltrim(Cidade)+;
                                       "#ESTADO|"      +Alltrim(Estado)+;
                                       "#CEP|"         +Alltrim(CepB)+;
                                       "#VALOR|"       +Alltrim(EditaDois(MValor))+;
                                       "#VENCIMENTO|"  +Alltrim(Vencimento)+;
                                       "#NNUMERO|"     +Alltrim(Nnumero))
********************** Codigo Devolu‡Æo _ G Final

*********************************************************** FINAL  BANCO CAIXA
TipoX[IND1] = "01"+Space(01)+Alltrim(CodCif)
************************************************************* FRENTE DO BOLETO

If Substr(linhamenP[IND1][1],2,6) = "PARCEL"
Parcelado++
@ 10,1 say 'Parcelado = '+Alltrim(Str(Parcelado))
LinhaA01[Ind1]=Space(1)+"PARCEL"+Alltrim(Cpf)
Else
Avista++
@ 12,1 say 'Avista    = '+Alltrim(Str(Avista))
LinhaA01[Ind1]=Space(1)+"AVISTA"+Alltrim(Cpf)
Endif



*LinhaA02[Ind1]=Space(1)+Alltrim(substr(strtran(Nome,' ',space(100)),1,100)) //+", PENSANDO EM VOCÊ DECIDIMOS RENOVAR NOSSA PROPOSTA PARA QUE VOCÊ TENHA CONDIÇÕES DE SE LIVRAR DE UMA VEZ POR TODAS DESTA PENDÊNCIA EM ABERTO NO SEU NOME JUNTO AO BRADESCO."
LinhaA02[Ind1]=Space(1)+Alltrim(Nome) //+", PENSANDO EM VOCÊ DECIDIMOS RENOVAR NOSSA PROPOSTA PARA QUE VOCÊ TENHA CONDIÇÕES DE SE LIVRAR DE UMA VEZ POR TODAS DESTA PENDÊNCIA EM ABERTO NO SEU NOME JUNTO AO BRADESCO."

Mensagem = "" // "ATENÇÃO: O não pagamento até a data de vencimento, acarretará no cancelamento  do acordo e a inclusão  de seu nome no orgão de proteção ao crédito de sua região e no Serasa."


LinhaA03[Ind1]=Space(1)+" "

LinhaA04[Ind1]=Space(1)+Alltrim(contrato)    //+"Contrato Nº"+Space(01)+Alltrim(contrato)
LinhaA05[Ind1]=Space(1)+"R$"+Space(01)+Alltrim(EditaDois(XvalorAtual))
LinhaA06[Ind1]=Space(1)+"R$"+Space(01)+Alltrim(EditaDois(Xvalordesc))
LinhaA07[Ind1]=Space(1)
LinhaA08[Ind1]=Space(1)

LinhaA09[Ind1]=Space(1)+alltrim(Titulo1)+space(01)+"//F1 Ligação Gratuita"

If OpcaoG = 1 .Or. OpcaoG = 3 
 LinhaA10[Ind1]=Space(1)+"Caso você já tenha efetuado acordo ou pagamento da Pasta nº "+Alltrim(Contrato)+", favor desconsiderar esta correspondência."
Else
 LinhaA10[Ind1]=Space(1)+"Caso você já tenha efetuado acordo ou pagamento do contrato nº "+Alltrim(Contrato)+", favor desconsiderar esta correspondência."
Endif

LinhaA11[Ind1]=Space(1)+LinhaDig
LinhaA12[Ind1]=Space(1)+Cedente
LinhaA13[Ind1]=Space(1)+X_Venci
LinhaA14[Ind1]=Space(1)+Mageced
LinhaA15[Ind1]=Space(1)+Nnumero
LinhaA16[Ind1]=Space(1)+Editadois(Mvalor) 
LinhaA17[Ind1]=Space(1)+DtoC(Date())
LinhaA18[Ind1]=Space(1)+Carteira1
LinhaA19[Ind1]=Space(1)+"RC"
LinhaA20[Ind1]=Space(1)+"N"
LinhaA21[Ind1]=Space(1)+"Sr(a) Caixa, Não receber valores diferentes das opções abaixo:"

If Substr(linhamenP[IND1][1],2,6) = "PARCEL"
LinhaA22[Ind1]=Space(1)+"À VISTA R$ "+Alltrim(EditaDois(Xvalordesc))+Space(70)+"//F9OU"
Else
LinhaA22[Ind1]=Space(1)+"À VISTA R$ "+Alltrim(EditaDois(Xvalordesc))
Endif


LinhaA23[Ind1]=Space(1)//+"À Vista , concedido desconto de //FA"+Alltrim(Editadois(XPercDesc2))+"%"
LinhaA24[Ind1]=Space(1)
LinhaA25[Ind1]=Space(1)
LinhaA26[Ind1]=Space(1)
LinhaA27[Ind1]=Space(1)
LinhaA28[Ind1]=Space(1)
LinhaA29[Ind1]=Space(1)  
LinhaA30[Ind1]=Space(1)+"//UNObservação: Importante//NO"

If Upper(Substr(Arqent,1,8)) = "563_UNIF" .Or. Upper(Substr(Arqent,1,8)) = "578_CITB"
 LinhaA31[Ind1]=Space(1)+"Após o vencimento , pagável somente nas Agências do Bradesco e Casas Lotéricas até"+Space(01)+"//F6"+Limite+"."
Else
 LinhaA31[Ind1]=Space(1)+"Pagável em toda a rede bancária até o vencimento."   //+"Pagável somente nas Agências do Bradesco e Casas Lotéricas até o vencimento."  //+Space(01)+"//F6"+Limite+"."
Endif

LinhaA32[Ind1]=Space(1)+"Após esta data, entre em contato com a Hoepers S/A"
LinhaA33[Ind1]=Space(1)+"Unidade Cedente"
LinhaA34[Ind1]=Space(1)+Nome
LinhaA35[Ind1]=Space(1)+Endereco
LinhaA36[Ind1]=Space(1)+Alltrim(Cidade)+"  "+Estado
LinhaA37[Ind1]=Space(1)+Stuff(CEPb,6,0,"-")
LinhaA38[Ind1]=Space(1)+Cod_Bar(CodBarra)
************************************************************* FRENTE DO BOLETO

************************************************************* VERSO  DO BOLETO
LinhaB1[Ind1]=Space(1)+StrTran(PostNet(Cepb),"S","*")
LinhaB2[Ind1]=Space(1)+Nome
LinhaB3[Ind1]=Space(1)+Endereco
LinhaB4[Ind1]=Space(1)+Alltrim(Cidade)+"  "+Estado
LinhaB5[Ind1]=Space(1)+Stuff(CEPb,6,0,"-")
LinhaB6[Ind1]=Space(1)+StrZero(Sequencia,7)+space(02)+"Arq:"+space(01)+Upper(Alltrim(arqsai2))
LinhaB7[Ind1]=Space(1)+barracif
LinhaB8[Ind1]=Space(1)+alltrim(CodDivida)+','+alltrim(codcredor)
************************************************************* VERSO  DO BOLETO

**********************************************************************PONTEIRO
Indx = Ind1
if ind1 = Final
     do imprime
     do limpa1
     ind1=0
endif
                               
ind1 = ind1 + 1
a =+1
enddo
return
**********************************************************************PONTEIRO

******************************************************************************
PROCEDURE IMPRIME
******************************************************************************

**************************************************************** FRENTE BOLETO

If OpcaoG = 1  // Cred_notifica‡Æo_Financial
   DJDE1="$DJDE$ FORMS=HOEPERS98"+PapelX+",FEED=BAN3,END;"
ElseIf OpcaoG = 2  // Cred_notifica‡Æo_Notifica
   DJDE1="$DJDE$ FORMS=HOEPERS71"+PapelX+",FEED=BAN3,END;"
ElseIf OpcaoG = 3  // Cred_Retail
   DJDE1="$DJDE$ FORMS=HOEPERS114"+PapelX+",FEED=BAN3,END;"
ElseIf OpcaoG = 4  // Cred_Citibank
   DJDE1="$DJDE$ FORMS=HOEPERS141"+PapelX+",FEED=BAN3,END;"
Endif

WKW=FWRITE(AOP,PADR('+'+DJDE1,220)+chr(13)+chr(10))

For Ind1 = 1 to Final

   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA01[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA02[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA03[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA04[ind1]+CHR(13)+chr(10))

   cont = 0
   If LinhaA05[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA05[ind1]+CHR(13)+chr(10))
   Cont ++
   endif

   If LinhaA06[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA06[ind1]+CHR(13)+chr(10))
   Cont ++
   endif

   If LinhaA07[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA07[ind1]+CHR(13)+chr(10))
   Cont ++
   endif


   If LinhaA08[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA08[ind1]+CHR(13)+chr(10))
   Cont ++
   endif

  If Cont <> 4
   For X = 1 to 4-Cont
   WKW=FWRITE(AOP,TipoX[ind1]+SPACE(0)+Chr(13)+Chr(10))
   Next
  Endif
                                
 for K = 1 to 9
   WKW=FWRITE(AOP,TipoX[ind1]+linhamenP[IND1][K]+chr(13)+chr(10))
 next

   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA09[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA10[ind1]+CHR(13)+chr(10))

 for x = 1 to 10
   WKW=FWRITE(AOP,TipoX[ind1]+linhamenI[IND1][x]+chr(13)+chr(10))
 next


   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA11[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA12[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA13[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA14[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA15[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA16[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA17[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA18[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA19[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA20[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA21[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA22[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA23[ind1]+CHR(13)+chr(10))

   contk = 0
   If LinhaA24[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA24[ind1]+CHR(13)+chr(10))
   Contk ++
   endif

   If LinhaA25[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA25[ind1]+CHR(13)+chr(10))
   Contk ++
   endif

   If LinhaA26[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA26[ind1]+CHR(13)+chr(10))
   Contk ++
   endif


   If LinhaA27[ind1] <> "***"
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA27[ind1]+CHR(13)+chr(10))
   Contk ++
   endif

  If Contk <> 4
   For X = 1 to 4-Contk
   WKW=FWRITE(AOP,TipoX[ind1]+SPACE(0)+Chr(13)+Chr(10))
   Next
  Endif

 for K = 1 to 9
   WKW=FWRITE(AOP,TipoX[ind1]+linhamenF[IND1][K]+chr(13)+chr(10))
 next

   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA28[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA29[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA30[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA31[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA32[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA33[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA34[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA35[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA36[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA37[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaA38[ind1]+CHR(13)+chr(10))
Next
**************************************************************** FRENTE BOLETO

***************************************************************** VERSO BOLETO
If OpcaoFac = 1 .And. X_CodCif = "7209072675" 
 DJDE1="$DJDE$ FORMS=HOEPERS"+PapelX+",FEED=BAN3,END;"
ElseIf OpcaoFac = 2 .And. X_CodCif = "7208298556" 
 DJDE1="$DJDE$ FORMS=HOEPERSDM"+PapelX+",FEED=BAN3,END;" 
ElseIf OpcaoFac = 3 .And. X_CodCif = "7205065429" 
 DJDE1="$DJDE$ FORMS=HOEPERSICI"+PapelX+",FEED=BAN3,END;" 
Else
 Erro = ErroForCif
Endif

WKW=FWRITE(AOP,PADR('+'+DJDE1,220)+chr(13)+chr(10))

For Ind1 = Final To 1 Step - 1

   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB1[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB2[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB3[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB4[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB5[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB6[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB7[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB8[ind1]+CHR(13)+chr(10))

Next

/*
Ind1 = 1
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB1[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB2[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB3[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB4[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB5[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB6[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB7[ind1]+CHR(13)+chr(10))
   WKW=FWRITE(AOP,TipoX[ind1]+LinhaB8[ind1]+CHR(13)+chr(10))
*/


***************************************************************** VERSO BOLETO

************************************************************** mostra contador
   @ 18,22 say 'GERANDO BOLETO .... '+str(seq2,7) color 'W/B'
************************************************************** mostra contador

RETURN

PROCEDURE VARIAVEIS1

public linhamenI[2][10]
public linhamenP[2][9]
public linhamenF[2][9]

PUBLIC TipoX[2]
PUBLIC LINHAA01[2]
PUBLIC LINHAA02[2]
PUBLIC LINHAA03[2]
PUBLIC LINHAA04[2]
PUBLIC LINHAA05[2]
PUBLIC LINHAA06[2]
PUBLIC LINHAA07[2]
PUBLIC LINHAA08[2]
PUBLIC LINHAA09[2]
PUBLIC LINHAA10[2]
PUBLIC LINHAA11[2]
PUBLIC LINHAA12[2]
PUBLIC LINHAA13[2]
PUBLIC LINHAA14[2]
PUBLIC LINHAA15[2]
PUBLIC LINHAA16[2]
PUBLIC LINHAA17[2]
PUBLIC LINHAA18[2]
PUBLIC LINHAA19[2]
PUBLIC LINHAA20[2]
PUBLIC LINHAA21[2]
PUBLIC LINHAA22[2]
PUBLIC LINHAA23[2]
PUBLIC LINHAA24[2]
PUBLIC LINHAA25[2]
PUBLIC LINHAA26[2]
PUBLIC LINHAA27[2]
PUBLIC LINHAA28[2]
PUBLIC LINHAA29[2]
PUBLIC LINHAA30[2]
PUBLIC LINHAA31[2]
PUBLIC LINHAA32[2]
PUBLIC LINHAA33[2]
PUBLIC LINHAA34[2]
PUBLIC LINHAA35[2]
PUBLIC LINHAA36[2]
PUBLIC LINHAA37[2]
PUBLIC LINHAA38[2]
                
PUBLIC LINHAB1[2]
PUBLIC LINHAB2[2]
PUBLIC LINHAB3[2]
PUBLIC LINHAB4[2]
PUBLIC LINHAB5[2]
PUBLIC LINHAB6[2]
PUBLIC LINHAB7[2]
PUBLIC LINHAB8[2]
PUBLIC LINHAB9[2]
PUBLIC LINHAB10[2]
PUBLIC LINHAB11[2]
PUBLIC LINHAB12[2]
PUBLIC LINHAB13[2]
PUBLIC LINHAB14[2]
PUBLIC LINHAB15[2]
PUBLIC LINHAB16[2]
PUBLIC LINHAB17[2]
PUBLIC LINHAB18[2]
PUBLIC LINHAB19[2]
PUBLIC LINHAB20[2]
PUBLIC LINHAB21[2]
PUBLIC LINHAB22[2]
PUBLIC LINHAB23[2]

PUBLIC LINHAC1[2]
PUBLIC LINHAC2[2]
PUBLIC LINHAC3[2]
PUBLIC LINHAC4[2]
PUBLIC LINHAC5[2]
PUBLIC LINHAC6[2]
PUBLIC LINHAC7[2]
PUBLIC LINHAC8[2]
PUBLIC LINHAC9[2]
PUBLIC LINHAC10[2]
PUBLIC LINHAC11[2]
PUBLIC LINHAC12[2]
PUBLIC LINHAC13[2]
PUBLIC LINHAC14[2]
PUBLIC LINHAC15[2]
PUBLIC LINHAC16[2]
PUBLIC LINHAC17[2]
PUBLIC LINHAC18[2]
PUBLIC LINHAC19[2]
PUBLIC LINHAC20[2]

PUBLIC LINHAD1[2][13]
PUBLIC LINHAD2[2][13]
PUBLIC LINHAD3[2][13]
PUBLIC LINHAD4[2][13]
PUBLIC LINHAD5[2][13]
PUBLIC LINHAD6[2][13]
PUBLIC LINHAD7[2][13]
PUBLIC LINHAD8[2][13]
PUBLIC LINHAD9[2][13]
PUBLIC LINHAD10[2][13]
PUBLIC LINHAD11[2][13]
PUBLIC LINHAD12[2][13]
PUBLIC LINHAD13[2][13]
PUBLIC LINHAD14[2][13]
PUBLIC LINHAD15[2][13]
PUBLIC LINHAD16[2][13]
PUBLIC LINHAD17[2][13]
PUBLIC LINHAD18[2][13]
PUBLIC LINHAD19[2][13]
PUBLIC LINHAD20[2][13]
PUBLIC LINHAD21[2][13]
PUBLIC LINHAD22[2][13]
PUBLIC LINHAD23[2][13]
PUBLIC LINHAD24[2][13]
PUBLIC LINHAD25[2][13]

return

PROCEDURE LIMPA1
*LOCAL I,IND1
LOCAL IND2, Ind1


 FOR IND1 = 1 TO 2
  TipoX[IND1]="***"
  LINHAA01[IND1]="***"
  LINHAA02[IND1]="***"
  LINHAA03[IND1]="***"
  LINHAA04[IND1]="***"
  LINHAA05[IND1]="***"
  LINHAA06[IND1]="***"
  LINHAA07[IND1]="***"
  LINHAA08[IND1]="***"
  LINHAA09[IND1]="***"
  LINHAA10[IND1]="***"
  LINHAA11[IND1]="***"
  LINHAA12[IND1]="***"
  LINHAA13[IND1]="***"
  LINHAA14[IND1]="***"
  LINHAA15[IND1]="***"
  LINHAA16[IND1]="***"
  LINHAA17[IND1]="***"
  LINHAA18[IND1]="***"
  LINHAA19[IND1]="***"
  LINHAA20[IND1]="***"
  LINHAA21[IND1]="***"
  LINHAA22[IND1]="***"
  LINHAA23[IND1]="***"
  LINHAA24[IND1]="***"
  LINHAA25[IND1]="***"
  LINHAA26[IND1]="***"
  LINHAA27[IND1]="***"
  LINHAA28[IND1]="***"
  LINHAA29[IND1]="***"
  LINHAA30[IND1]="***"
  LINHAA31[IND1]="***"
  LINHAA32[IND1]="***"
  LINHAA33[IND1]="***"
  LINHAA34[IND1]="***"
  LINHAA35[IND1]="***"
  LINHAA36[IND1]="***"
  LINHAA37[IND1]="***"
  LINHAA38[IND1]="***"

for x = 1 to 10
linhamenI[IND1][x]=space(01)
next

for k = 1 to 9
linhamenP[IND1][k]=space(01)
next

for k = 1 to 9
linhamenF[IND1][k]=space(01)
next


 NEXT
FOR IND1 = 1 TO 2
  LINHAB1[IND1]="***"
  LINHAB2[IND1]="***"
  LINHAB3[IND1]="***"
  LINHAB4[IND1]="***"
  LINHAB5[IND1]="***"
  LINHAB6[IND1]="***"
  LINHAB7[IND1]="***"
  LINHAB8[IND1]="***"
  LINHAB9[IND1]="***"
  LINHAB10[IND1]="***"
  LINHAB11[IND1]="***"
  LINHAB12[IND1]="***"
  LINHAB13[IND1]="***"
  LINHAB14[IND1]="***"
  LINHAB15[IND1]="***"
  LINHAB16[IND1]="***"
  LINHAB17[IND1]="***"
  LINHAB18[IND1]="***"
  LINHAB19[IND1]="***"
  LINHAB20[IND1]="***"
  LINHAB21[IND1]="***"
  LINHAB22[IND1]="***"
  LINHAB23[IND1]="***"
NEXT

FOR IND1 = 1 TO 2
  LINHAC1[IND1]="***"
  LINHAC2[IND1]="***"
  LINHAC3[IND1]="***"
  LINHAC4[IND1]="***"
  LINHAC5[IND1]="***"
  LINHAC6[IND1]="***"
  LINHAC7[IND1]="***"
  LINHAC8[IND1]="***"
  LINHAC9[IND1]="***"
  LINHAC10[IND1]="***"
  LINHAC11[IND1]="***"
  LINHAC12[IND1]="***"
  LINHAC13[IND1]="***"
  LINHAC14[IND1]="***"
  LINHAC15[IND1]="***"
  LINHAC16[IND1]="***"
  LINHAC17[IND1]="***"
  LINHAC18[IND1]="***"
  LINHAC19[IND1]="***"
  LINHAC20[IND1]="***"
NEXT

FOR IND2 = 1 TO 13
 FOR IND1 = 1 TO 2
  LINHAD1[IND1][IND2]="***"
  LINHAD2[IND1][IND2]="***"
  LINHAD3[IND1][IND2]="***"
  LINHAD4[IND1][IND2]="***"
  LINHAD5[IND1][IND2]="***"
  LINHAD6[IND1][IND2]="***"
  LINHAD7[IND1][IND2]="***"
  LINHAD8[IND1][IND2]="***"
  LINHAD9[IND1][IND2]="***"
  LINHAD10[IND1][IND2]="***"
  LINHAD11[IND1][IND2]="***"
  LINHAD12[IND1][IND2]="***"
  LINHAD13[IND1][IND2]="***"
  LINHAD14[IND1][IND2]="***"
  LINHAD15[IND1][IND2]="***"
  LINHAD16[IND1][IND2]="***"
  LINHAD17[IND1][IND2]="***"
  LINHAD18[IND1][IND2]="***"
  LINHAD19[IND1][IND2]="***"
  LINHAD20[IND1][IND2]="***"
  LINHAD21[IND1][IND2]="***"
  LINHAD22[IND1][IND2]="***"
  LINHAD23[IND1][IND2]="***"
  LINHAD24[IND1][IND2]="***"
  LINHAD25[IND1][IND2]="***"
 NEXT
NEXT
return

Procedure Banco
TempRem=Time()
*********************************************** BANCO
Declare Matriz[1]
*  Matriz[1]={'Linha     ','C',889,0}
  Matriz[1]={'Linha     ','C',909,0}
AAdd(Matriz,{'Id        ','C',025,0})
AAdd(Matriz,{'Agencia_V ','C',005,0})
AAdd(Matriz,{'Conta_V   ','C',008,0})
DBCreate('Dados.dbf',Matriz)
Use Dados New
Append FROM &ArqEnt SDF
Goto Top

Seq = 0
Do While .not. EOF()

********** Confirma‡Æo Que NÆo Esta Vindo Banco Diferente ao Layout
OK="OK"
if Substr(Linha,1,2) = "00" .or. Substr(Linha,1,2) = "01" .or. Substr(Linha,1,2) = "02" .or. Substr(Linha,1,2) = "03" .or. Substr(Linha,1,2) = "04" .or. Substr(Linha,1,2) = "  "
CONFIRMA = OK
Else 
@ 16,12 say "Obs o Programa NÆo Esta Preparado Para Este Registro "+Substr(Linha,1,2)
erro=erro
endif
********** Confirma‡Æo Que NÆo Esta Vindo Banco Diferente ao Layout


  If Substr(Linha,1,2) = "00" .And. Substr(Linha,4,4) = "0324" .And. Substr(Linha,9,8) = "01699830"
       XAgencia_V = "03247"
       XConta_V   = "01699830"
  ElseIf Substr(Linha,1,2) = "00" .And. Substr(Linha,4,4) = "0324" .And. Substr(Linha,9,8) = "01641530"
       XAgencia_V = "03247"
       XConta_V   = "01641530"
  Endif
                   
  Replace Agencia_V With XAgencia_V
  Replace Conta_V With XConta_V

  If Substr(Linha,1,2) = "01"
     Seq++
  EndIf

  Replace ID With StrZero(Seq,7)+Alltrim(StrTran(Strtran(Dtoc(date())+TempRem,"/",""),":",""))

SKIP
EndDO
Copy To "WWW.WWW" SDF

******************************************************* Tipo00
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'Lixo1     ','C',005,0})
AAdd(Matriz,{'Agencia   ','C',005,0})
AAdd(Matriz,{'Conta     ','C',008,0})
AAdd(Matriz,{'Carteira  ','C',005,0})
AAdd(Matriz,{'CodCedente','C',006,0})
AAdd(Matriz,{'Especie   ','C',002,0})
AAdd(Matriz,{'Banco     ','C',020,0}) // Criadas Colunas em Brancos para Poder Carregar o ID
DBCreate('Tipo00.dbf',Matriz)
Use Tipo00 New
Append FROM "WWW.WWW" All for TipoReg = "00" SDF
Goto Top
******************************************************* Tipo00

******************************************************* Tipo01
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'CEP       ','C',008,0})
AAdd(Matriz,{'Processo  ','C',008,0})
AAdd(Matriz,{'NossoNum  ','C',014,0})
AAdd(Matriz,{'DigNosso  ','C',001,0})
AAdd(Matriz,{'Nome      ','C',040,0})
AAdd(Matriz,{'CPF       ','C',014,0})
AAdd(Matriz,{'Endereco  ','C',055,0})
AAdd(Matriz,{'Cidade    ','C',020,0})
AAdd(Matriz,{'Estado    ','C',002,0})
AAdd(Matriz,{'Vencimento','C',010,0})
AAdd(Matriz,{'Limite    ','C',010,0})
AAdd(Matriz,{'Telefone  ','C',012,0})
AAdd(Matriz,{'CodDevedor','C',008,0})
AAdd(Matriz,{'CodCredor ','C',004,0})
AAdd(Matriz,{'Remessa   ','C',006,0})
AAdd(Matriz,{'Brancos   ','C',052,0})
AAdd(Matriz,{'Filial01  ','C',070,0})
AAdd(Matriz,{'Filial02  ','C',070,0})
AAdd(Matriz,{'Filial03  ','C',070,0})
AAdd(Matriz,{'Filial04  ','C',070,0})
AAdd(Matriz,{'Filial05  ','C',070,0})
AAdd(Matriz,{'Filial06  ','C',070,0})
AAdd(Matriz,{'Filial07  ','C',070,0})
AAdd(Matriz,{'Titulo1   ','C',050,0})
AAdd(Matriz,{'Titulo2   ','C',050,0})
AAdd(Matriz,{'Contrato  ','C',020,0})
AAdd(Matriz,{'Desconto  ','C',003,0})
AAdd(Matriz,{'ValorTot  ','C',010,0})
AAdd(Matriz,{'CodDivida ','C',010,0})
AAdd(Matriz,{'lixo_1_T01','C',010,0})
AAdd(Matriz,{'ID        ','C',025,0})
AAdd(Matriz,{'Agencia_V ','C',005,0})
AAdd(Matriz,{'Conta_v   ','C',013,0})
AAdd(Matriz,{'NumPostal ','C',020,0})
AAdd(Matriz,{'CodCep    ','C',001,0})
AAdd(Matriz,{'CodTri    ','C',001,0})
AAdd(Matriz,{'CodCIF    ','C',034,0})
AAdd(Matriz,{'Categoria ','C',005,0})
DBCreate('Tipo01.dbf',Matriz)
Use Tipo01 alias Boleto New
Append FROM "WWW.WWW" All for TipoReg = "01" SDF
Goto Top
******************************************************* Tipo01

******************************************************* Tipo02
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'Vencimento','C',010,0})
AAdd(Matriz,{'ValorAtual','C',010,0})
AAdd(Matriz,{'Desconto  ','C',010,0})
AAdd(Matriz,{'ValorDesc ','C',010,0})
AAdd(Matriz,{'Contrato  ','C',020,0})
AAdd(Matriz,{'CodSegu2  ','C',010,0})
AAdd(Matriz,{'PercDesc2 ','C',010,0})
AAdd(Matriz,{'Brancos   ','C',827,0}) // Criadas Colunas em Brancos para Poder Carregar o ID
AAdd(Matriz,{'ID        ','C',025,0})
DBCreate('Tipo02.dbf',Matriz)
*Use Tipo02 New
Use Tipo02  New
Append FROM "WWW.WWW" All for TipoReg = "02" SDF
Index on ID to Tipo02
Goto Top
******************************************************* Tipo02

******************************************************* Tipo03
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'Parcelas  ','C',002,0})
AAdd(Matriz,{'ValorEntr ','C',010,0})
AAdd(Matriz,{'ValorParc ','C',010,0})
AAdd(Matriz,{'VAlorAvist','C',010,0})
AAdd(Matriz,{'CodSeg    ','C',010,0})
AAdd(Matriz,{'Lixo3     ','C',028,0})
AAdd(Matriz,{'PercDesc3 ','C',010,0})
AAdd(Matriz,{'Cet_Mes   ','C',010,0})
AAdd(Matriz,{'Cet_Ano   ','C',010,0})
AAdd(Matriz,{'Brancos   ','C',807,0}) // Criadas Colunas em Brancos para Poder Carregar o ID
AAdd(Matriz,{'ID        ','C',025,0})
DBCreate('Tipo03.dbf',Matriz)
Use Tipo03 New
Append FROM "WWW.WWW" All for TipoReg = "03" SDF
Index on ID to Tipo03
Goto Top
******************************************************* Tipo03

******************************************************* Tipo04
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'Produto   ','C',050,0})
AAdd(Matriz,{'Valor     ','C',010,0})
AAdd(Matriz,{'Brancos   ','C',847,0}) // Criadas Colunas em Brancos para Poder Carregar o ID
AAdd(Matriz,{'ID        ','C',025,0})
DBCreate('Tipo04.dbf',Matriz)
Use Tipo04 New
Append FROM "WWW.WWW" All for TipoReg = "04" SDF
Index on ID to Tipo04
Goto Top
******************************************************* Tipo04

******************************************************* Tipo05
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'VeCtoParc ','C',010,0})
AAdd(Matriz,{'NumParc   ','C',003,0})
AAdd(Matriz,{'Plano     ','C',003,0})
AAdd(Matriz,{'ValParc   ','C',010,0})
AAdd(Matriz,{'ID        ','C',025,0})
DBCreate('Tipo05.dbf',Matriz)
Use Tipo05 New
Append FROM "WWW.WWW" All for TipoReg = "05" SDF
Index on ID to Tipo05
Goto Top
******************************************************* Tipo05

******************************************************* Tipo06
Declare Matriz[1]
  Matriz[1]={'TipoReg   ','C',002,0}
AAdd(Matriz,{'Totaliza  ','C',002,0})
AAdd(Matriz,{'TotSemDesc','C',010,0})
AAdd(Matriz,{'TotDesc   ','C',010,0})
AAdd(Matriz,{'ValParc6  ','C',010,0})
AAdd(Matriz,{'CodSegura ','C',010,0})
AAdd(Matriz,{'ID        ','C',025,0})
DBCreate('Tipo06.dbf',Matriz)
Use Tipo06 New
Append FROM "WWW.WWW" All for TipoReg = "06" SDF
Index on ID to Tipo06
Goto Top
******************************************************* Tipo06


Delete File "WWW.WWW"
Return

procedure rotvencido()
  datacalc=ctod(vencidos)-date()
  if datacalc <=7 .and. datacalc > 0
    rotp++
  endif
  if datacalc <= 0
    rotv++
  endif
return
