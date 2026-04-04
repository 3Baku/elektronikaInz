import java.awt.Point;

public class Pixel {
    
    
    private int luminance;
    public final Point location;

    //konstruktor glowny
    public Pixel(int luminance, int coordinateX, int coordinateY)
    {
        // zmienna obiektu jest rowna argumentowi
        this.luminance = luminance;
        this.location = new Point(coordinateX, coordinateY);
    }

    //konstruktor kopiujacy
    public Pixel(Pixel myPixel)
    {
        luminance = myPixel.luminance;
        location = new Point(myPixel.location);
    }
    public int getLuminance()
    {
        return this.luminance;
    }
    public void setLuminance(int newLuminance)
    {
        if(newLuminance > 0 && newLuminance <255)
            this.luminance = newLuminance;
        else
            System.out.println("proba nadpisania luminance wartoscia spoza zakresu.");
    }
    @Override
    public String toString()
    {
        return ("Wspolrzedna x: " + this.location.x + "\nWspolrzednia y: "+ this.location.y + "\nJasnosc: "+ this.luminance);
    }
    
}

