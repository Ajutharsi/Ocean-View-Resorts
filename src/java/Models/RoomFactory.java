package Models;

import Models.RoomInfo;

public class RoomFactory {

    public static RoomInfo createRoom(String roomType) {
        switch (roomType.toLowerCase()) {
            case "standard":
                return new RoomInfo("Standard Room", 8500.00,
                        "Garden view, AC, WiFi", "🛏️");
            case "deluxe":
                return new RoomInfo("Deluxe Room", 12000.00,
                        "Ocean view, King bed, Premium amenities", "🏨");
            case "suite":
                return new RoomInfo("Suite", 22000.00,
                        "Private balcony, Jacuzzi, Sea view", "👑");
            case "family":
                return new RoomInfo("Family Room", 18000.00,
                        "2 beds, Kids area, Beach access", "👨‍👩‍👧‍👦");
            default:
                throw new IllegalArgumentException("Unknown room type: " + roomType);
        }
    }
}