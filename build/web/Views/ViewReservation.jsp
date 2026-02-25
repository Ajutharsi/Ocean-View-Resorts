<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Reservation"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    @SuppressWarnings("unchecked")
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    if (reservations == null) {
        reservations = new java.util.ArrayList<>();
    }

    int totalCount = reservations.size();
    int activeCount = 0, completedCount = 0, pendingCount = 0;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date today = new java.util.Date();

    for (Reservation r : reservations) {
        java.util.Date checkIn = new java.util.Date(r.getCheckIn().getTime());
        java.util.Date checkOut = new java.util.Date(r.getCheckOut().getTime());
        if (checkOut.before(today)) completedCount++;
        else if (checkIn.after(today)) pendingCount++;
        else activeCount++;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Reservations - Ocean View Resort</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
    }

    /* Header */
    .top-header {
        background: linear-gradient(135deg, #2d5aa0 0%, #1e3a6f 100%);
        padding: 15px 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    .logo-section {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo-section h1 {
        color: white;
        font-size: 24px;
        font-weight: 600;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 10px;
        color: white;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #667eea;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }

    .logout-btn {
        background: rgba(255,255,255,0.2);
        color: white;
        border: 1px solid rgba(255,255,255,0.3);
        padding: 8px 20px;
        border-radius: 20px;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.3s;
    }

    .logout-btn:hover {
        background: rgba(255,255,255,0.3);
    }

    /* Page Header */
    .page-header {
        background: linear-gradient(135deg, #7c8ff6 0%, #9370db 100%);
        padding: 30px 40px;
        border-radius: 20px;
        margin-bottom: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }

    .page-header h2 {
        color: white;
        font-size: 32px;
        font-weight: 600;
        margin-bottom: 10px;
    }

    .page-header p {
        color: rgba(255,255,255,0.9);
        font-size: 16px;
    }

    .header-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 15px;
        margin-top: 20px;
    }

    .add-btn, .back-btn {
        padding: 12px 24px;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .add-btn {
        background: white;
        color: #667eea;
        box-shadow: 0 4px 15px rgba(255,255,255,0.3);
    }

    .add-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255,255,255,0.4);
    }

    .back-btn {
        background: white;
        color: #667eea;
        box-shadow: 0 4px 15px rgba(255,255,255,0.3);
    }

    .back-btn:hover {
        background: rgba(255,255,255,0.3);
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
    }

    /* Stats Cards */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        display: flex;
        align-items: center;
        gap: 20px;
        transition: all 0.3s;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }

    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
    }

    .stat-icon.total {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }

    .stat-icon.active {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    }

    .stat-icon.completed {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    }

    .stat-icon.pending {
        background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
    }

    .stat-content {
        flex: 1;
    }

    .stat-label {
        color: #6b7280;
        font-size: 14px;
        margin-bottom: 5px;
    }

    .stat-value {
        color: #1f2937;
        font-size: 32px;
        font-weight: 700;
    }

    /* Search & Filters */
    .search-filter-section {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        margin-bottom: 30px;
    }

    .search-filter-grid {
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 20px;
    }

    .filter-group label {
        display: block;
        color: #374151;
        font-weight: 500;
        margin-bottom: 8px;
    }

    .filter-control {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e5e7eb;
        border-radius: 10px;
        font-size: 15px;
        transition: all 0.3s;
    }

    .filter-control:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    /* Table Card */
    .table-card {
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        overflow: hidden;
    }

    .table-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 20px 30px;
    }

    .table-title {
        color: white;
        font-size: 20px;
        font-weight: 600;
    }

    .table-container {
        padding: 0;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background: #f9fafb;
    }

    th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid #e5e7eb;
    }

    tbody tr {
        border-bottom: 1px solid #e5e7eb;
        transition: all 0.2s;
    }

    tbody tr:hover {
        background: #f9fafb;
    }

    td {
        padding: 15px;
        color: #4b5563;
        font-size: 14px;
    }

    /* Status Badges */
    .status-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: capitalize;
    }

    .status-active {
        background: #dbeafe;
        color: #1e40af;
    }

    .status-completed {
        background: #d1fae5;
        color: #065f46;
    }

    .status-pending {
        background: #fef3c7;
        color: #92400e;
    }

    /* Action Buttons */
    .action-btn {
        padding: 8px 12px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 13px;
        margin-right: 5px;
        transition: all 0.3s;
        font-weight: 500;
    }

    .btn-view {
        background: #dbeafe;
        color: #1e40af;
    }

    .btn-view:hover {
        background: #bfdbfe;
    }

    .btn-edit {
        background: #fef3c7;
        color: #92400e;
    }

    .btn-edit:hover {
        background: #fde68a;
    }

    .btn-delete {
        background: #fee2e2;
        color: #991b1b;
    }

    .btn-delete:hover {
        background: #fecaca;
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
    }

    .empty-icon {
        font-size: 64px;
        margin-bottom: 20px;
    }

    .empty-message {
        color: #6b7280;
        font-size: 18px;
        margin-bottom: 25px;
    }

    /* Modal */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 1000;
        align-items: center;
        justify-content: center;
    }

    .modal.show {
        display: flex;
    }

    .modal-content {
        background: white;
        border-radius: 20px;
        width: 90%;
        max-width: 600px;
        max-height: 80vh;
        overflow-y: auto;
        box-shadow: 0 20px 50px rgba(0,0,0,0.3);
    }

    .modal-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 25px 30px;
        border-radius: 20px 20px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-title {
        color: white;
        font-size: 22px;
        font-weight: 600;
    }

    .close-btn {
        background: rgba(255,255,255,0.2);
        color: white;
        border: none;
        width: 35px;
        height: 35px;
        border-radius: 50%;
        font-size: 24px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .close-btn:hover {
        background: rgba(255,255,255,0.3);
        transform: rotate(90deg);
    }

    #modalBody {
        padding: 30px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .search-filter-grid {
            grid-template-columns: 1fr;
        }

        .stats-grid {
            grid-template-columns: 1fr;
        }

        .table-container {
            overflow-x: scroll;
        }

        .action-btn {
            display: block;
            margin-bottom: 5px;
            width: 100%;
        }

        .page-header h2 {
            font-size: 24px;
        }
    }
</style>
</head>
<body>

<!-- Top Header -->


<!-- Page Header -->
<div class="page-header">
    
    <div class="header-actions">
        <a href="AddReservation.jsp" class="add-btn">➕ Add New Reservation</a>
        <a href="Dashboard.jsp" class="back-btn">← Back to Dashboard</a>
    </div>
</div>

<div class="container">
    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon total">📊</div>
            <div class="stat-content">
                <div class="stat-label">Total Reservations</div>
                <div class="stat-value"><%= totalCount %></div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon active">🔄</div>
            <div class="stat-content">
                <div class="stat-label">Active</div>
                <div class="stat-value"><%= activeCount %></div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon completed">✅</div>
            <div class="stat-content">
                <div class="stat-label">Completed</div>
                <div class="stat-value"><%= completedCount %></div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon pending">⏳</div>
            <div class="stat-content">
                <div class="stat-label">Pending</div>
                <div class="stat-value"><%= pendingCount %></div>
            </div>
        </div>
    </div>

    <!-- Search & Filters -->
    <div class="search-filter-section">
        <div class="search-filter-grid">
            <div class="filter-group">
                <label for="searchInput">🔍 Search Reservations</label>
                <input type="text" id="searchInput" class="filter-control" placeholder="Search by guest name, contact, or reservation ID...">
            </div>
            <div class="filter-group">
                <label for="statusFilter">Filter by Status</label>
                <select id="statusFilter" class="filter-control">
                    <option value="">All Status</option>
                    <option value="active">Active</option>
                    <option value="completed">Completed</option>
                    <option value="pending">Pending</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Reservations Table -->
    <div class="table-card">
        <div class="table-header">
            <div class="table-title">📝 All Reservations</div>
        </div>
        <div class="table-container">
            <% if(!reservations.isEmpty()){ %>
            <table id="reservationsTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Guest Name</th>
                        <th>Contact</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Room Type</th>
                        <th>Guests</th>
                        <th>Status</th>
                        <th>Total</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Reservation r : reservations) {
                        java.util.Date checkIn = new java.util.Date(r.getCheckIn().getTime());
                        java.util.Date checkOut = new java.util.Date(r.getCheckOut().getTime());
                        String status = "active";
                        if (checkOut.before(today)) status = "completed";
                        else if (checkIn.after(today)) status = "pending";
                %>
                    <tr>
                        <td><strong>RES<%= String.format("%03d", r.getId()) %></strong></td>
                        <td><%= r.getGuestName() != null ? r.getGuestName() : "" %></td>
                        <td><%= r.getContactNumber() != null ? r.getContactNumber() : "" %></td>
                        <td><%= sdf.format(checkIn) %></td>
                        <td><%= sdf.format(checkOut) %></td>
                        <td><%= r.getRoomType() != null ? r.getRoomType() : "N/A" %></td>
                        <td><%= r.getGuests() %></td>
                        <td><span class="status-badge status-<%= status %>"><%= status %></span></td>
                        <td><strong>LKR <%= String.format("%,.2f", r.getTotal()) %></strong></td>
                        <td>
                            <button class="action-btn btn-view" onclick="viewDetails('<%= r.getId() %>')">👁️ View</button>
                            <button class="action-btn btn-edit" onclick="editReservation('<%= r.getId() %>')">✏️ Edit</button>
                            <button class="action-btn btn-delete" onclick="deleteReservation('<%= r.getId() %>')">🗑️ Delete</button>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <!-- Empty State -->
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <div class="empty-message">No reservations found</div>
                <a href="AddReservation.jsp" class="add-btn">➕ Create First Reservation</a>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Modal -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">📄 Reservation Details</h2>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <div id="modalBody"></div>
    </div>
</div>

<script>
function viewDetails(id){ 
    // Implement view details functionality
    alert("View details for reservation: " + id); 
}

function editReservation(id){ 
    window.location.href = "EditReservation.jsp?id=" + id;
}

function deleteReservation(id){ 
    if(confirm("Are you sure you want to delete this reservation?")) {
        window.location.href = "DeleteReservationServlet?id=" + id;
    }
}

// Search filter
document.getElementById('searchInput').addEventListener('input', function(){
    const filter = this.value.toLowerCase();
    const rows = document.querySelectorAll('#reservationsTable tbody tr');
    rows.forEach(row => {
        const name = row.cells[1].innerText.toLowerCase();
        const contact = row.cells[2].innerText.toLowerCase();
        const resId = row.cells[0].innerText.toLowerCase();
        const visible = name.includes(filter) || resId.includes(filter) || contact.includes(filter);
        row.style.display = visible ? '' : 'none';
    });
});

// Status filter
document.getElementById('statusFilter').addEventListener('change', function(){
    const filter = this.value.toLowerCase();
    const rows = document.querySelectorAll('#reservationsTable tbody tr');
    rows.forEach(row => {
        if(filter === '') {
            row.style.display = '';
        } else {
            const status = row.querySelector('.status-badge').innerText.toLowerCase();
            row.style.display = status.includes(filter) ? '' : 'none';
        }
    });
});

function closeModal(){
    document.getElementById('viewModal').classList.remove('show');
}

// Close modal on outside click
window.onclick = function(event) {
    const modal = document.getElementById('viewModal');
    if (event.target == modal) {
        closeModal();
    }
}
</script>

</body>
</html>
