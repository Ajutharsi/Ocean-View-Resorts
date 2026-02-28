package Models;

public class RoomInfo {
    private String roomType;
    private double ratePerNight;
    private String description;
    private String icon;

    public RoomInfo(String roomType, double ratePerNight,
                    String description, String icon) {
        this.roomType     = roomType;
        this.ratePerNight = ratePerNight;
        this.description  = description;
        this.icon         = icon;
    }

    public String getRoomType()     { return roomType; }
    public double getRatePerNight() { return ratePerNight; }
    public String getDescription()  { return description; }
    public String getIcon()         { return icon; }
}