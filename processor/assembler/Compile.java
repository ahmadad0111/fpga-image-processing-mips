import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.*;
import java.lang.*;



public class Compile{

public static String Out_Data ="";

public static void main(String args[]) 
{
	String fileName = "program.bin";
 	char[] charArray;
 	String line;
        String data="";

try (BufferedReader br = new BufferedReader(new FileReader(fileName))) 
  {
   while ((line = br.readLine()) != null)
    {
     compile(line);
				
    }
  } catch (IOException e) {e.printStackTrace();}


save();
  System.out.print(Out_Data);
}


public static void compile(String  line) 
{
String[] strings =  line.split(" ");
switch(strings[0])
 {
   case("addi"):
                {
                  Out_Data=Out_Data+"00000100000";
                  addi(strings[1]);
                  break;
                }
case("add"):
                {
                 Out_Data=Out_Data+"000010";
                 r_formate(strings[1],"add");
                 break;
                }
case("sub"):
                {
                 Out_Data=Out_Data+"000010";
                 r_formate(strings[1],"sub");
                 break;
                }
case("or"):
                {
                 Out_Data=Out_Data+"000010";
                 r_formate(strings[1],"or");
                 break;
                }
case("and"):
                {
                 Out_Data=Out_Data+"000010";
                 r_formate(strings[1],"and");
                 break;
                }
case("xor"):
                {
                 Out_Data=Out_Data+"000010";
                 r_formate(strings[1],"xor");
                 break;
                }
case("lw"):
                {
                 Out_Data=Out_Data+"000100";
                 beq_bne_lw_sw(strings[1]);
                 break;
                }
case("sw"):
                {
                 Out_Data=Out_Data+"000101";
                 beq_bne_lw_sw(strings[1]);
                 break;
                }
case("nop"):
                {
                 Out_Data=Out_Data+"00000000000000000000000000000000"+"\n";
                 break;
                }
case("NOP"):
                {
                 Out_Data=Out_Data+"11111111111111111111111111111111"+"\n";
                 break;
                }
case("beq"):
                {
                 Out_Data=Out_Data+"000011";
                 beq_bne_lw_sw(strings[1]);
                 break;
                }
case("bne"):
                {
                 Out_Data=Out_Data+"000111";
                 beq_bne_lw_sw(strings[1]);
                 break;
                }
case("j"):
                {
                 Out_Data=Out_Data+"0001100000000000";
                 String B=bit_16(strings[1]);
                 Out_Data=Out_Data+B+"\n";
                 break;
                }

   default:  
             {
               break;
             }
 }

}

public static void beq_bne_lw_sw(String strings)
{
String[] strings2=strings.split(",");
String Rt=Registers(strings2[0]);
String Rs=Registers(strings2[1]);
String B=bit_16(strings2[2]);
Out_Data=Out_Data+Rs+Rt+B+"\n";
}
public static void r_formate(String strings,String opcode)
{
String[] strings2=strings.split(",");
String Rd=Registers(strings2[0]);
String Rs=Registers(strings2[1]);
int Len=strings2[2].length();
String t=strings2[2].substring(0,Len-1);
String Rt=Registers(t);
Out_Data=Out_Data+Rs+Rt+Rd+"11111";
switch(opcode)
 {
 case("add"):
             {
              Out_Data=Out_Data+"000000"+"\n";
              break;
             }
 case("sub"):
             {
              Out_Data=Out_Data+"000001"+"\n";
              break;
             }
 case("or"):
             {
              Out_Data=Out_Data+"000010"+"\n";
              break;
             }
 case("and"):
             {
              Out_Data=Out_Data+"000011"+"\n";
              break;
             }
 case("xor"):
             {
              Out_Data=Out_Data+"000100"+"\n";
              break;
             }
   default:  
             {
               break;
             } 
}

}

public static void addi(String strings)
{
  String[] strings2 =  strings.split(",");
  String S=Registers(strings2[0]);
  Out_Data=Out_Data+S;
  String B=bit_16(strings2[1]);
  Out_Data=Out_Data+B+"\n";

}



public static String Registers(String reg)
{
String ret="";
switch(reg)
  {
    case("$z"):
             {
                ret="00000";
                break;
             }
    case("$r"):
             {
                ret="10100";
                break;
             }
 
  case("$s1"):
             {
                ret="00001";
                break;
             }
  
   case("$s2"):
             {
               ret="00010"; 
               break;
             }
    case("$s3"):
             {
                ret="00011";
                break;
             }
    case("$s4"):
             {
                ret="00100";
                break;
             }
    case("$s5"):
             {
                ret="00101";
                break;
             }
    case("$s6"):
             {
                ret="00110";
                break;
             }
    case("$s7"):
             {
                ret="00111";
                break;
             }
    case("$s8"):
             {
                ret="01000";
                break;
             }
    case("$s9"):
             {
                ret="01001";
                break;
             }
    case("$s10"):
             {
                ret="01010";
                break;
             }
    case("$a1"):
             {
                ret="01011";
                break;
             }
    case("$a2"):
             {
                ret="01100";
                break;
             }
    case("$a3"):
             {
                ret="01101";
                break;
             }
    case("$a4"):
             {
                ret="01110";
                break;
             }
    case("$a5"):
             {
                ret="01111";
                break;
             }
    case("$a6"):
             {
                ret="10000";
                break;
             }
    case("$a7"):
             {
                ret="10001";
                break;
             }
    case("$a8"):
             {
                ret="10010";
                break;
             }
    case("$a9"):
             {
                ret="10011";
                break;
             }
    case("$a10"):
             {
                ret="10101";
                break;
             }
    case("$t0"):
             {
                ret="10110";
                break;
             }
    case("$t1"):
             {
                ret="10111";
                break;
             }
    case("$t2"):
             {
                ret="11000";
                break;
             }
    case("$t3"):
             {
                ret="11001";
                break;
             }
    case("$t4"):
             {
                ret="11010";
                break;
             }
    case("$t5"):
             {
                ret="11011";
                break;
             }
    case("$t6"):
             {
                ret="11100";
                break;
             }
    case("$t7"):
             {
                ret="11101";
                break;
             }
    case("$t8"):
             {
                ret="11110";
                break;
             }
    case("$t9"):
             {
                ret="11111";
                break;
             }
   case("$Z"):
             {
                ret="00000";
                break;
             }
    case("$R"):
             {
                ret="10100";
                break;
             }
 
  case("$S1"):
             {
                ret="00001";
                break;
             }
  
   case("$S2"):
             {
               ret="00010"; 
               break;
             }
    case("$S3"):
             {
                ret="00011";
                break;
             }
    case("$S4"):
             {
                ret="00100";
                break;
             }
    case("$S5"):
             {
                ret="00101";
                break;
             }
    case("$S6"):
             {
                ret="00110";
                break;
             }
    case("$S7"):
             {
                ret="00111";
                break;
             }
    case("$S8"):
             {
                ret="01000";
                break;
             }
    case("$S9"):
             {
                ret="01001";
                break;
             }
    case("$S10"):
             {
                ret="01010";
                break;
             }
    case("$A1"):
             {
                ret="01011";
                break;
             }
    case("$A2"):
             {
                ret="01100";
                break;
             }
    case("$A3"):
             {
                ret="01101";
                break;
             }
    case("$A4"):
             {
                ret="01110";
                break;
             }
    case("$A5"):
             {
                ret="01111";
                break;
             }
    case("$A6"):
             {
                ret="10000";
                break;
             }
    case("$A7"):
             {
                ret="10001";
                break;
             }
    case("$A8"):
             {
                ret="10010";
                break;
             }
    case("$A9"):
             {
                ret="10011";
                break;
             }
    case("$A10"):
             {
                ret="10101";
                break;
             }
    case("$T0"):
             {
                ret="10110";
                break;
             }
    case("$T1"):
             {
                ret="10111";
                break;
             }
    case("$T2"):
             {
                ret="11000";
                break;
             }
    case("$T3"):
             {
                ret="11001";
                break;
             }
    case("$T4"):
             {
                ret="11010";
                break;
             }
    case("$T5"):
             {
                ret="11011";
                break;
             }
    case("$T6"):
             {
                ret="11100";
                break;
             }
    case("$T7"):
             {
                ret="11101";
                break;
             }
    case("$T8"):
             {
                ret="11110";
                break;
             }
    case("$T9"):
             {
                ret="11111";
                break;
             }
default:
            {
              break;
            }
  }

return ret;
}


public static void save()
 {
            	 
    
try { 
             FileWriter fw=new FileWriter("factorial.bin");  

 
                 fw.write(Out_Data);
                 fw.close();
                                 
                
                }  catch (IOException e) {
                e.printStackTrace();
                }
   
 }

public static String bit_16(String s)
{
int Len=s.length();
String t=s.substring(0,Len-1);
int i = Integer.parseInt(t);


String binarized = Integer.toBinaryString(i);
int len = binarized.length();
String sixteenZeroes = "00000000000000000";
if (len < 16)
  binarized = sixteenZeroes.substring(0, 16-len).concat(binarized);
else
  binarized = binarized.substring(len - 16);
return binarized;
}
}
