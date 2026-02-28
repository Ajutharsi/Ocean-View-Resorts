<%-- 
    Document   : ReservationReport
    Created on : Feb 25, 2026, 8:54:43?PM
    Author     : Dell
--%>


<html>
<head>
    <title>Reservation Reports</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #eee; }
    </style>
</head>
<body>
<h2>Reservation Report</h2>

<!-- Optional filter form -->
<form method="get" action="ReservationReport">
    Room Type:
    <select name="roomType">
        <option value="">All</option>
        <option value="standard">Standard</option>
        <option value="deluxe">Deluxe</option>
        <option value="suite">Suite</option>
        <option value="presidential">Presidential</option>
    </select>
    From: <input type="date" name="fromDate">
    To: <input type="date" name="toDate">
    <input type="submit" value="Filter">
</form>

<table>
    <tr>
        <th>ID</th>
        <th>Guest Name</th>
        <th>Room Type</th>
        <th>Check In</th>
        <th>Check Out</th>
        <th>Total Amount</th>
    </tr>
    <c:forEach var="r" items="${reservations}">
        <tr>
            <td>${r.id}</td>
            <td>${r.guestName}</td>
            <td>${r.roomType}</td>
            <td>${r.checkIn}</td>
            <td>${r.checkOut}</td>
            <td>${r.total}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
