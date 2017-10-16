using System;

public class Delegate
{
  public delegate int ApplyTwoInt(Func<int, int, int> func, int a, int b);
  public static ApplyTwoInt apply = new ApplyTwoInt((func, a, b) => func(a, b));

  public static void Main(){
    Console.WriteLine(apply((a, b) => a + b, 5, 5));
    Console.WriteLine(apply((a, b) => a * b, 5, 5));
  }
}
