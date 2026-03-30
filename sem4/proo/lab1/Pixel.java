import java.awt.Point;

public class Pixel {
    
    
    private int luminance;
    public final Point location;

    public Pixel(int luminance, int coordinateX, int coordinateY)
    {
        this.luminance = luminance;
        this.location = new Point(coordinateX, coordinateY);
    }

    //konstruktor kopiujacy
    public Pixel(Pixel myPixel)
    {
        luminance = myPixel.luminance;
        location = new Point(myPixel.location);
    }
    public String toString()
    {
        return ("Wspolrzedna x: " + location.x + "\nWspolrzednia y: "+ location.y + "\nJasnosc: "+ luminance);
    }
    
}

