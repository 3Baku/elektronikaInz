public class Main {
    public static void main(String[] args)
    {
        //tworzenie obiektu klasy
        Pixel firstPixel = new Pixel(1,2,3);
        //System.out.println(firstPixel.luminance);
        //Point myPoint = new Point(5,6);
        //myPixel.location = myPoint;
        Pixel secondPixel = new Pixel(firstPixel);
        secondPixel.setLuminance(50);
        secondPixel.location.x = 2137;
        firstPixel.location.y = 67;
        System.out.println("Pierwszy pixel:\n" + firstPixel + "\n\n Drugi pixel:\n" +secondPixel);
    }
}
