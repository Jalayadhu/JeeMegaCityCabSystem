
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegacityJee - Booking History</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        :root {
            --primary: #0088ff;
            --primary-dark: #0066cc;
            --secondary: #00ccff;
            --dark: #333;
            --light: #f8f9fa;
            --card-bg: rgba(255, 255, 255, 0.9);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --gradient: linear-gradient(135deg, var(--primary), var(--secondary));
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: var(--light);
            min-height: 100vh;
            perspective: 1000px;
            overflow-x: hidden;
            background: radial-gradient(circle at top right, var(--secondary), transparent),
                        radial-gradient(circle at bottom left, var(--primary), transparent);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 40px;
            position: relative;
            transform-style: preserve-3d;
        }
        
        .logo {
            font-size: 28px;
            font-weight: bold;
            color: var(--primary-dark);
            position: relative;
            transform-style: preserve-3d;
            transform: translateZ(20px);
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .logo span {
            color: var(--secondary);
            animation: float 3s ease-in-out infinite;
            display: inline-block;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            transform: translateZ(30px);
        }
        
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 20px;
            box-shadow: var(--shadow);
            transform-style: preserve-3d;
            animation: pulse 2s infinite;
        }
        
        .user-info {
            line-height: 1.4;
        }
        
        .user-name {
            font-weight: 600;
            color: var(--dark);
        }
        
        .user-status {
            color: var(--primary);
            font-size: 14px;
        }
        
        .page-title {
            font-size: 32px;
            margin-bottom: 30px;
            color: var(--dark);
            position: relative;
            transform-style: preserve-3d;
            transform: translateZ(40px);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100px;
            height: 4px;
            background: var(--gradient);
            border-radius: 2px;
            animation: expandWidth 3s ease-in-out infinite;
        }
        
        .filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--card-bg);
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: var(--shadow);
            transform-style: preserve-3d;
            transform: translateZ(20px) rotateX(5deg);
            transition: all 0.3s ease;
        }
        
        .filter-bar:hover {
            transform: translateZ(30px) rotateX(0deg);
        }
        
        .filter-options {
            display: flex;
            gap: 15px;
        }
        
        .filter-btn {
            padding: 8px 15px;
            border: none;
            background: transparent;
            color: var(--dark);
            font-weight: 500;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .filter-btn.active {
            background: var(--gradient);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 136, 255, 0.3);
        }
        
        .search-box {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 5px;
            padding: 5px 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .search-box input {
            border: none;
            outline: none;
            padding: 8px;
            font-size: 14px;
            width: 200px;
        }
        
        .search-box i {
            color: var(--primary);
        }
        
        .booking-history {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            perspective: 1000px;
        }
        
        .booking-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.5s ease;
            transform-style: preserve-3d;
            transform: rotateY(10deg) translateZ(0);
            position: relative;
            opacity: 0;
            animation: fadeInUp 0.5s forwards;
        }
        
        .booking-card:nth-child(1) { animation-delay: 0.1s; }
        .booking-card:nth-child(2) { animation-delay: 0.2s; }
        .booking-card:nth-child(3) { animation-delay: 0.3s; }
        .booking-card:nth-child(4) { animation-delay: 0.4s; }
        .booking-card:nth-child(5) { animation-delay: 0.5s; }
        .booking-card:nth-child(6) { animation-delay: 0.6s; }
        
        .booking-card:hover {
            transform: rotateY(0deg) translateZ(50px) scale(1.05);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }
        
        .booking-header {
            background: var(--gradient);
            color: white;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }
        
        .booking-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.3) 0%, transparent 70%);
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
        }
        
        .booking-id {
            font-size: 14px;
            opacity: 0.8;
            margin-bottom: 5px;
        }
        
        .booking-date {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .booking-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: rgba(255, 255, 255, 0.2);
        }
        
        .status-completed {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
        }
        
        .status-cancelled {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
        }
        
        .booking-details {
            padding: 20px;
        }
        
        .route-info {
            display: flex;
            margin-bottom: 20px;
            position: relative;
        }
        
        .route-points {
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-right: 15px;
        }
        
        .point {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary);
            position: relative;
            z-index: 1;
        }
        
        .point.destination {
            background: var(--secondary);
        }
        
        .route-line {
            position: absolute;
            top: 12px;
            left: 6px;
            width: 2px;
            height: calc(100% - 24px);
            background: #ddd;
        }
        
        .route-addresses {
            flex: 1;
        }
        
        .address {
            margin-bottom: 30px;
        }
        
        .address-type {
            font-size: 12px;
            color: #777;
            margin-bottom: 5px;
        }
        
        .address-text {
            font-weight: 500;
        }
        
        .booking-meta {
            display: flex;
            justify-content: space-between;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .meta-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .meta-label {
            font-size: 12px;
            color: #777;
            margin-bottom: 5px;
        }
        
        .meta-value {
            font-weight: 600;
            color: var(--dark);
        }
        
        .meta-value i {
            color: var(--primary);
            margin-right: 5px;
        }
        
        .booking-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            gap: 10px;
        }
        
        .action-btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        
        .btn-primary {
            background: var(--gradient);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 136, 255, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 136, 255, 0.4);
        }
        
        .btn-secondary {
            background: #f1f1f1;
            color: var(--dark);
        }
        
        .btn-secondary:hover {
            background: #e5e5e5;
        }
        
        .floating-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--gradient);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: 0 5px 20px rgba(0, 136, 255, 0.4);
            cursor: pointer;
            transition: all 0.3s ease;
            transform-style: preserve-3d;
            transform: translateZ(0) rotate(0deg);
            animation: float 3s ease-in-out infinite;
        }
        
        .floating-btn:hover {
            transform: translateZ(20px) rotate(360deg);
            box-shadow: 0 10px 30px rgba(0, 136, 255, 0.6);
        }
        
        /* 3D Animation Effects */
        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
            100% { transform: translateY(0) rotate(0deg); }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @keyframes expandWidth {
            0% { width: 50px; }
            50% { width: 150px; }
            100% { width: 50px; }
        }
        
        @keyframes shimmer {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: rotateY(10deg) translateY(30px);
            }
            to {
                opacity: 1;
                transform: rotateY(10deg) translateY(0);
            }
        }
        
        /* 3D Card Tilt Effect with JavaScript */
        .tilt-card {
            transform-style: preserve-3d;
            transform: perspective(1000px);
        }
        
        .tilt-card-inner {
            transform-style: preserve-3d;
            transition: transform 0.3s ease;
        }
        
        .tilt-card:hover .tilt-card-inner {
            transform: rotateX(var(--rotateX)) rotateY(var(--rotateY));
        }
        
        .tilt-card-inner > * {
            transform-style: preserve-3d;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .booking-history {
                grid-template-columns: 1fr;
            }
            
            .filter-bar {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            
            .filter-options {
                width: 100%;
                overflow-x: auto;
                padding-bottom: 10px;
            }
            
            .search-box {
                width: 100%;
            }
            
            .search-box input {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">Megacity<span>Jee</span></div>
            <div class="user-profile">
                <div class="user-avatar">JD</div>
                <div class="user-info">
                    <div class="user-name">John Doe</div>
                    <div class="user-status">Premium Member</div>
                </div>
            </div>
        </header>
        
        <h1 class="page-title">Your Booking History</h1>
        
        <div class="filter-bar">
            <div class="filter-options">
                <button class="filter-btn active">All</button>
                <button class="filter-btn">Completed</button>
                <button class="filter-btn">Cancelled</button>
                <button class="filter-btn">Upcoming</button>
            </div>
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search bookings...">
            </div>
        </div>
        
        <div class="booking-history">
            <!-- Booking Card 1 -->
            <div class="booking-card tilt-card">
                <div class="tilt-card-inner">
                    <div class="booking-header">
                        <div class="booking-id">Booking #MJ-2023-8745</div>
                        <div class="booking-date">Today, 10:30 AM</div>
                        <div class="booking-status">Completed</div>
                    </div>
                    <div class="booking-details">
                        <div class="route-info">
                            <div class="route-points">
                                <div class="point"></div>
                                <div class="point destination"></div>
                                <div class="route-line"></div>
                            </div>
                            <div class="route-addresses">
                                <div class="address">
                                    <div class="address-type">PICKUP</div>
                                    <div class="address-text">123 Main Street, Downtown</div>
                                </div>
                                <div class="address">
                                    <div class="address-type">DESTINATION</div>
                                    <div class="address-text">456 Park Avenue, Uptown</div>
                                </div>
                            </div>
                        </div>
                        <div class="booking-meta">
                            <div class="meta-item">
                                <div class="meta-label">FARE</div>
                                <div class="meta-value">$24.50</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DISTANCE</div>
                                <div class="meta-value">7.2 km</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DURATION</div>
                                <div class="meta-value">18 min</div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn btn-primary"><i class="fas fa-redo"></i> Book Again</button>
                            <button class="action-btn btn-secondary"><i class="fas fa-receipt"></i> Receipt</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Card 2 -->
            <div class="booking-card tilt-card">
                <div class="tilt-card-inner">
                    <div class="booking-header">
                        <div class="booking-id">Booking #MJ-2023-8732</div>
                        <div class="booking-date">Yesterday, 2:15 PM</div>
                        <div class="booking-status">Completed</div>
                    </div>
                    <div class="booking-details">
                        <div class="route-info">
                            <div class="route-points">
                                <div class="point"></div>
                                <div class="point destination"></div>
                                <div class="route-line"></div>
                            </div>
                            <div class="route-addresses">
                                <div class="address">
                                    <div class="address-type">PICKUP</div>
                                    <div class="address-text">789 Office Plaza, Business District</div>
                                </div>
                                <div class="address">
                                    <div class="address-type">DESTINATION</div>
                                    <div class="address-text">321 Residential Lane, Suburbs</div>
                                </div>
                            </div>
                        </div>
                        <div class="booking-meta">
                            <div class="meta-item">
                                <div class="meta-label">FARE</div>
                                <div class="meta-value">$32.75</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DISTANCE</div>
                                <div class="meta-value">12.5 km</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DURATION</div>
                                <div class="meta-value">25 min</div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn btn-primary"><i class="fas fa-redo"></i> Book Again</button>
                            <button class="action-btn btn-secondary"><i class="fas fa-receipt"></i> Receipt</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Card 3 -->
            <div class="booking-card tilt-card">
                <div class="tilt-card-inner">
                    <div class="booking-header">
                        <div class="booking-id">Booking #MJ-2023-8721</div>
                        <div class="booking-date">Mar 12, 2023, 9:00 AM</div>
                        <div class="booking-status status-cancelled">Cancelled</div>
                    </div>
                    <div class="booking-details">
                        <div class="route-info">
                            <div class="route-points">
                                <div class="point"></div>
                                <div class="point destination"></div>
                                <div class="route-line"></div>
                            </div>
                            <div class="route-addresses">
                                <div class="address">
                                    <div class="address-type">PICKUP</div>
                                    <div class="address-text">555 Airport Road, Terminal 3</div>
                                </div>
                                <div class="address">
                                    <div class="address-type">DESTINATION</div>
                                    <div class="address-text">777 Hotel Boulevard, City Center</div>
                                </div>
                            </div>
                        </div>
                        <div class="booking-meta">
                            <div class="meta-item">
                                <div class="meta-label">FARE</div>
                                <div class="meta-value">$45.00</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DISTANCE</div>
                                <div class="meta-value">18.3 km</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DURATION</div>
                                <div class="meta-value">35 min</div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn btn-primary"><i class="fas fa-redo"></i> Book Again</button>
                            <button class="action-btn btn-secondary"><i class="fas fa-info-circle"></i> Details</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Card 4 -->
            <div class="booking-card tilt-card">
                <div class="tilt-card-inner">
                    <div class="booking-header">
                        <div class="booking-id">Booking #MJ-2023-8710</div>
                        <div class="booking-date">Mar 10, 2023, 7:45 PM</div>
                        <div class="booking-status">Completed</div>
                    </div>
                    <div class="booking-details">
                        <div class="route-info">
                            <div class="route-points">
                                <div class="point"></div>
                                <div class="point destination"></div>
                                <div class="route-line"></div>
                            </div>
                            <div class="route-addresses">
                                <div class="address">
                                    <div class="address-type">PICKUP</div>
                                    <div class="address-text">222 Restaurant Row, Entertainment District</div>
                                </div>
                                <div class="address">
                                    <div class="address-type">DESTINATION</div>
                                    <div class="address-text">888 Apartment Complex, Riverside</div>
                                </div>
                            </div>
                        </div>
                        <div class="booking-meta">
                            <div class="meta-item">
                                <div class="meta-label">FARE</div>
                                <div class="meta-value">$18.25</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DISTANCE</div>
                                <div class="meta-value">5.7 km</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DURATION</div>
                                <div class="meta-value">12 min</div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn btn-primary"><i class="fas fa-redo"></i> Book Again</button>
                            <button class="action-btn btn-secondary"><i class="fas fa-receipt"></i> Receipt</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Card 5 -->
            <div class="booking-card tilt-card">
                <div class="tilt-card-inner">
                    <div class="booking-header">
                        <div class="booking-id">Booking #MJ-2023-8695</div>
                        <div class="booking-date">Mar 8, 2023, 11:20 AM</div>
                        <div class="booking-status">Completed</div>
                    </div>
                    <div class="booking-details">
                        <div class="route-info">
                            <div class="route-points">
                                <div class="point"></div>
                                <div class="point destination"></div>
                                <div class="route-line"></div>
                            </div>
                            <div class="route-addresses">
                                <div class="address">
                                    <div class="address-type">PICKUP</div>
                                    <div class="address-text">444 Shopping Mall, Retail Park</div>
                                </div>
                                <div class="address">
                                    <div class="address-type">DESTINATION</div>
                                    <div class="address-text">999 Medical Center, Healthcare District</div>
                                </div>
                            </div>
                        </div>
                        <div class="booking-meta">
                            <div class="meta-item">
                                <div class="meta-label">FARE</div>
                                <div class="meta-value">$29.50</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DISTANCE</div>
                                <div class="meta-value">9.8 km</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DURATION</div>
                                <div class="meta-value">22 min</div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn btn-primary"><i class="fas fa-redo"></i> Book Again</button>
                            <button class="action-btn btn-secondary"><i class="fas fa-receipt"></i> Receipt</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Card 6 -->
            <div class="booking-card tilt-card">
                <div class="tilt-card-inner">
                    <div class="booking-header">
                        <div class="booking-id">Booking #MJ-2023-8682</div>
                        <div class="booking-date">Mar 5, 2023, 3:40 PM</div>
                        <div class="booking-status">Completed</div>
                    </div>
                    <div class="booking-details">
                        <div class="route-info">
                            <div class="route-points">
                                <div class="point"></div>
                                <div class="point destination"></div>
                                <div class="route-line"></div>
                            </div>
                            <div class="route-addresses">
                                <div class="address">
                                    <div class="address-type">PICKUP</div>
                                    <div class="address-text">333 University Campus, Education Zone</div>
                                </div>
                                <div class="address">
                                    <div class="address-type">DESTINATION</div>
                                    <div class="address-text">111 Tech Park, Innovation District</div>
                                </div>
                            </div>
                        </div>
                        <div class="booking-meta">
                            <div class="meta-item">
                                <div class="meta-label">FARE</div>
                                <div class="meta-value">$21.75</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DISTANCE</div>
                                <div class="meta-value">6.9 km</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">DURATION</div>
                                <div class="meta-value">15 min</div>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn btn-primary"><i class="fas fa-redo"></i> Book Again</button>
                            <button class="action-btn btn-secondary"><i class="fas fa-receipt"></i> Receipt</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="floating-btn">
        <i class="fas fa-plus"></i>
    </div>
    
    <script>
        // 3D Tilt Effect for Cards
        document.querySelectorAll('.tilt-card').forEach(card => {
            card.addEventListener('mousemove', e => {
                const cardRect = card.getBoundingClientRect();
                const cardWidth = cardRect.width;
                const cardHeight = cardRect.height;
                
                // Calculate mouse position relative to card center
                const centerX = cardRect.left + cardWidth / 2;
                const centerY = cardRect.top + cardHeight / 2;
                const mouseX = e.clientX - centerX;
                const mouseY = e.clientY - centerY;
                
                // Calculate rotation values (limited to +/- 10 degrees)
                const rotateY = mouseX / (cardWidth / 2) * 10;
                const rotateX = -mouseY / (cardHeight / 2) * 10;
                
                // Apply the rotation
                const cardInner = card.querySelector('.tilt-card-inner');
                cardInner.style.setProperty('--rotateX', `${rotateX}deg`);
                cardInner.style.setProperty('--rotateY', `${rotateY}deg`);
            });
            
            // Reset rotation when mouse leaves
            card.addEventListener('mouseleave', () => {
                const cardInner = card.querySelector('.tilt-card-inner');
                cardInner.style.transition = 'transform 0.5s ease';
                cardInner.style.setProperty('--rotateX', '0deg');
                cardInner.style.setProperty('--rotateY', '0deg');
                
                // Reset transition after animation completes
                setTimeout(() => {
                    cardInner.style.transition = 'transform 0.3s ease';
                }, 500);
            });
        });
        
        // Filter buttons functionality
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                // Remove active class from all buttons
                document.querySelectorAll('.filter-btn').forEach(b => {
                    b.classList.remove('active');
                });
                
                // Add active class to clicked button
                btn.classList.add('active');
                
                // Here you would typically filter the booking cards
                // based on the selected filter
            });
        });
        
        // Floating button animation on click
        const floatingBtn = document.querySelector('.floating-btn');
        floatingBtn.addEventListener('click', () => {
            floatingBtn.style.transform = 'translateZ(50px) rotate(180deg)';
            setTimeout(() => {
                floatingBtn.style.transform = '';
            }, 500);
            
            // Here you would typically open a new booking form
            // or navigate to the booking page
        });
    </script>
</body>
</html>