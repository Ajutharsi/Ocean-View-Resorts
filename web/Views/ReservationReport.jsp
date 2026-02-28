<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Report - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:     #f5f6fa;
            --header: linear-gradient(135deg, #1e3c72, #2a5298);
            --purple: linear-gradient(135deg, #667eea, #764ba2);
            --accent: #667eea;
            --purple2:#764ba2;
            --navy:   #2a5298;
            --text:   #333;
            --muted:  #888;
            --light:  #999;
            --card:   #ffffff;
            --border: rgba(102,126,234,0.15);
            --green:  #2dc653;
            --red:    #e63946;
            --gold:   #e9c46a;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        /* HEADER - matches My Reservations */
        .header {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 15px rgba(0,0,0,0.2);
        }

        .header h1 { font-size: 1.6em; font-weight: 600; }
        .header-right { display: flex; gap: 12px; }

        .btn-nav {
            padding: 9px 22px;
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            font-size: 0.9em;
            font-weight: 600;
            text-decoration: none;
            background: rgba(255,255,255,0.15);
            transition: all 0.3s;
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
        }

        .btn-nav:hover { background: white; color: #2a5298; }

        /* CONTAINER */
        .container { max-width: 1300px; margin: 0 auto; padding: 36px 30px; }

        .page-title { margin-bottom: 32px; }
        .page-title h2 { font-size: 1.8em; color: #2a5298; margin-bottom: 4px; font-weight: 700; }
        .page-title p  { color: var(--muted); font-size: 0.9em; }

        /* KPI CARDS */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 32px;
        }

        .kpi-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            padding: 22px 24px;
            position: relative;
            overflow: hidden;
            transition: transform 0.25s, box-shadow 0.25s;
        }

        .kpi-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102,126,234,0.15);
        }

        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .kpi-label {
            font-size: 0.78em;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--muted);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .kpi-value { font-size: 2em; font-weight: 700; color: #2a5298; line-height: 1; margin-bottom: 6px; }
        .kpi-sub   { font-size: 0.8em; color: var(--muted); }

        .kpi-badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 0.75em;
            font-weight: 600;
            margin-top: 8px;
        }

        .badge-up   { background: rgba(45,198,83,0.12); color: #1a8a3a; }
        .badge-down { background: rgba(230,57,70,0.12); color: var(--red); }

        /* CHARTS */
        .charts-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 28px;
        }

        .chart-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            padding: 24px;
        }

        .chart-title {
            font-size: 0.82em;
            font-weight: 700;
            color: var(--muted);
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Bar Chart */
        .bar-chart { display: flex; align-items: flex-end; gap: 10px; height: 160px; }

        .bar-group { display: flex; flex-direction: column; align-items: center; flex: 1; height: 100%; justify-content: flex-end; gap: 6px; }

        .bar {
            width: 100%;
            border-radius: 5px 5px 0 0;
            transition: opacity 0.2s;
            cursor: pointer;
        }

        .bar:hover { opacity: 0.75; }
        .bar-label { font-size: 0.72em; color: var(--muted); }
        .bar-val   { font-size: 0.72em; color: var(--text); font-weight: 700; }

        /* Donut */
        .donut-wrap { display: flex; align-items: center; gap: 28px; }
        .legend-item { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
        .legend-dot  { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
        .legend-name { font-size: 0.85em; color: var(--text); flex: 1; }
        .legend-pct  { font-size: 0.85em; color: var(--muted); font-weight: 700; }

        /* FILTER BAR */
        .filter-bar {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            padding: 20px 24px;
            display: flex;
            gap: 16px;
            align-items: flex-end;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .filter-group { display: flex; flex-direction: column; gap: 6px; }

        .filter-label {
            font-size: 0.75em;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--muted);
            font-weight: 700;
        }

        .filter-control {
            padding: 9px 14px;
            background: #f5f6fa;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            color: var(--text);
            font-size: 0.88em;
            font-family: 'DM Sans', sans-serif;
            outline: none;
            transition: border-color 0.2s;
            min-width: 140px;
        }

        .filter-control:focus { border-color: #667eea; }

        .btn-filter {
            padding: 9px 22px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            transition: opacity 0.2s;
        }

        .btn-filter:hover { opacity: 0.85; }

        .btn-export {
            padding: 9px 22px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 25px;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            transition: all 0.3s;
            margin-left: auto;
        }

        .btn-export:hover { background: #667eea; color: white; }

        /* TABLE */
        .table-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            overflow: hidden;
        }

        .table-header {
            padding: 18px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #f0f0f0;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .table-title { font-size: 0.9em; font-weight: 700; color: white; text-transform: uppercase; letter-spacing: 1px; }
        .table-count { font-size: 0.82em; color: rgba(255,255,255,0.75); }

        table { width: 100%; border-collapse: collapse; }

        thead th {
            padding: 13px 20px;
            text-align: left;
            font-size: 0.75em;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--muted);
            font-weight: 700;
            background: #fafafa;
            border-bottom: 1px solid #f0f0f0;
        }

        tbody tr {
            border-bottom: 1px solid #f8f8f8;
            transition: background 0.15s;
        }

        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: rgba(102,126,234,0.04); }

        tbody td { padding: 14px 20px; font-size: 0.88em; color: var(--text); }

        .room-tag {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 0.82em;
            font-weight: 600;
            color: white;
        }

        .tag-standard     { background: #0984e3; }
        .tag-deluxe       { background: linear-gradient(135deg,#667eea,#764ba2); }
        .tag-suite        { background: #e9c46a; color: #333; }
        .tag-presidential { background: #e63946; }

        .amount { font-weight: 700; color: #2a5298; }

        /* FOOTER */
        footer {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: rgba(255,255,255,0.7);
            text-align: center;
            padding: 18px;
            font-size: 0.85em;
            margin-top: 40px;
        }

        @media (max-width: 1024px) { .kpi-grid { grid-template-columns: repeat(2,1fr); } }
        @media (max-width: 768px) {
            .kpi-grid { grid-template-columns: 1fr 1fr; }
            .charts-row { grid-template-columns: 1fr; }
            .header { padding: 14px 20px; }
            .container { padding: 24px 16px; }
            .filter-bar { flex-direction: column; }
            .btn-export { margin-left: 0; }
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <h1>Ocean View Resort</h1>
    <div class="header-right">
        <a href="#" class="btn-nav">&larr; Dashboard</a>
        <a href="#" class="btn-nav">Logout</a>
    </div>
</header>

<div class="container">

    <!-- Page Title -->
    <div class="page-title">
        <h2>Reservation Report &amp; Analysis</h2>
        <p>Overview of all reservations ? February 2026</p>
    </div>

    <!-- KPI Cards -->
    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-label">Total Reservations</div>
            <div class="kpi-value">4</div>
            <div class="kpi-sub">This month</div>
            <span class="kpi-badge badge-up">+12% vs last month</span>
        </div>
        <div class="kpi-card">
            <div class="kpi-label">Total Revenue</div>
            <div class="kpi-value" style="font-size:1.5em;">LKR 0.0M</div>
            <div class="kpi-sub">Gross earnings</div>
            <span class="kpi-badge badge-up">+8% vs last month</span>
        </div>
        <div class="kpi-card">
            <div class="kpi-label">Avg. Stay Duration</div>
            <div class="kpi-value">0.04</div>
            <div class="kpi-sub">Nights per booking</div>
            <span class="kpi-badge badge-down">-0.2 vs last month</span>
        </div>
        <div class="kpi-card">
            <div class="kpi-label">Occupancy Rate</div>
            <div class="kpi-value">2%</div>
            <div class="kpi-sub">Rooms filled</div>
            <span class="kpi-badge badge-up">+0.1% vs last month</span>
        </div>
    </div>

    <!-- Charts -->
    <div class="charts-row">

        <!-- Bar Chart -->
        <div class="chart-card">
            <div class="chart-title">Bookings by Month</div>
            <div class="bar-chart">
                <div class="bar-group">
                    <div class="bar-val">14</div>
                    <div class="bar" style="height:0%; background:linear-gradient(180deg,#667eea,#764ba2); opacity:0.5;"></div>
                    <div class="bar-label">Sep</div>
                </div>
                <div class="bar-group">
                    <div class="bar-val">18</div>
                    <div class="bar" style="height:0%; background:linear-gradient(180deg,#667eea,#764ba2); opacity:0.6;"></div>
                    <div class="bar-label">Oct</div>
                </div>
                <div class="bar-group">
                    <div class="bar-val">22</div>
                    <div class="bar" style="height:0%; background:linear-gradient(180deg,#667eea,#764ba2); opacity:0.7;"></div>
                    <div class="bar-label">Nov</div>
                </div>
                <div class="bar-group">
                    <div class="bar-val">19</div>
                    <div class="bar" style="height:0%; background:linear-gradient(180deg,#667eea,#764ba2); opacity:0.75;"></div>
                    <div class="bar-label">Dec</div>
                </div>
                <div class="bar-group">
                    <div class="bar-val">21</div>
                    <div class="bar" style="height:10%; background:linear-gradient(180deg,#667eea,#764ba2); opacity:0.85;"></div>
                    <div class="bar-label">Jan</div>
                </div>
                <div class="bar-group">
                    <div class="bar-val">24</div>
                    <div class="bar" style="height:50%; background:linear-gradient(180deg,#667eea,#764ba2);"></div>
                    <div class="bar-label">Feb</div>
                </div>
            </div>
        </div>

        <!-- Donut Chart -->
        <div class="chart-card">
            <div class="chart-title">Room Type Distribution</div>
            <div class="donut-wrap">
                <svg width="140" height="140" viewBox="0 0 140 140">
                    <circle cx="70" cy="70" r="50" fill="none" stroke="#667eea" stroke-width="22"
                        stroke-dasharray="119.4 195.5" stroke-dashoffset="0" transform="rotate(-90 70 70)"/>
                    <circle cx="70" cy="70" r="50" fill="none" stroke="#764ba2" stroke-width="22"
                        stroke-dasharray="91.1 223.8" stroke-dashoffset="-119.4" transform="rotate(-90 70 70)"/>
                    <circle cx="70" cy="70" r="50" fill="none" stroke="#e9c46a" stroke-width="22"
                        stroke-dasharray="66 248.9" stroke-dashoffset="-210.5" transform="rotate(-90 70 70)"/>
                    <circle cx="70" cy="70" r="50" fill="none" stroke="#2a5298" stroke-width="22"
                        stroke-dasharray="37.7 277.1" stroke-dashoffset="-276.5" transform="rotate(-90 70 70)"/>
                    <text x="70" y="66" text-anchor="middle" fill="#2a5298" font-size="14" font-weight="700" font-family="DM Sans">24</text>
                    <text x="70" y="82" text-anchor="middle" fill="#888" font-size="9" font-family="DM Sans">bookings</text>
                </svg>
                <div class="donut-legend">
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#667eea;"></div>
                        <div class="legend-name">Standard</div>
                        <div class="legend-pct">38%</div>
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#764ba2;"></div>
                        <div class="legend-name">Deluxe</div>
                        <div class="legend-pct">29%</div>
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#e9c46a;"></div>
                        <div class="legend-name">Suite</div>
                        <div class="legend-pct">21%</div>
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#2a5298;"></div>
                        <div class="legend-name">Presidential</div>
                        <div class="legend-pct">12%</div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Filter Bar -->
    <div class="filter-bar">
        <div class="filter-group">
            <div class="filter-label">Room Type</div>
            <select class="filter-control">
                <option value="">All Types</option>
                <option value="standard">Standard</option>
                <option value="deluxe">Deluxe</option>
                <option value="suite">Suite</option>
                <option value="presidential">Presidential</option>
            </select>
        </div>
        <div class="filter-group">
            <div class="filter-label">From Date</div>
            <input type="date" class="filter-control" value="2026-02-01">
        </div>
        <div class="filter-group">
            <div class="filter-label">To Date</div>
            <input type="date" class="filter-control" value="2026-02-28">
        </div>
        <button class="btn-filter">Apply Filter</button>
        <button class="btn-export">Export CSV</button>
    </div>

    <!-- Table -->
    <div class="table-card">
        <div class="table-header">
            <div class="table-title">Reservation Records</div>
            <div class="table-count">Showing 6 of 24 records</div>
        </div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Guest Name</th>
                    <th>Room Type</th>
                    <th>Check In</th>
                    <th>Check Out</th>
                    <th>Nights</th>
                    <th>Total Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>#1001</td>
                    <td>Tharsh </td>
                    <td><span class="room-tag tag-deluxe">Deluxe</span></td>
                    <td>27 feb 2026</td>
                    <td>28 feb 2026</td>
                    <td>3</td>
                    <td class="amount">LKR 45,000</td>
                </tr>
                <tr>
                    <td>#1002</td>
                    <td>subitika </td>
                    <td><span class="room-tag tag-standard">Standard</span></td>
                    <td>28 Feb 2026</td>
                    <td>28 Feb 2026</td>
                    <td>3</td>
                    <td class="amount">LKR 27,000</td>
                </tr>
                <tr>
                    <td>#1003</td>
                    <td>kajani </td>
                    <td><span class="room-tag tag-suite">Suite</span></td>
                    <td>28 Feb 2026</td>
                    <td>28 Feb 2026</td>
                    <td>4</td>
                    <td class="amount">LKR 96,000</td>
                </tr>
                
               
               
            </tbody>
        </table>
    </div>

</div>

<footer>
    &copy; 2026 Ocean View Resort. All rights reserved.
</footer>

</body>
</html>