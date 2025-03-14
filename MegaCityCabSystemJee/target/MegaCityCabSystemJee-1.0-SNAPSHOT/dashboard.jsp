<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCityJee Cab System - Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        :root {
            --primary: #0070f3;
            --primary-dark: #0050b3;
            --primary-light: #3291ff;
            --primary-lighter: #d1e9ff;
            --secondary: #7928ca;
            --secondary-dark: #4c0993;
            --accent: #ff0080;
            --success: #0070f3;
            --warning: #f5a623;
            --error: #ff4d4f;
            --foreground: #000;
            --background: #fff;
            --gray-100: #f8f9fa;
            --gray-200: #e9ecef;
            --gray-300: #dee2e6;
            --gray-400: #ced4da;
            --gray-500: #adb5bd;
            --gray-600: #6c757d;
            --gray-700: #495057;
            --gray-800: #343a40;
            --gray-900: #212529;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --card-shadow-hover: 0 10px 30px rgba(0, 0, 0, 0.15);
            --transition-normal: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --transition-bounce: all 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        
        body {
            background-color: var(--gray-100);
            color: var(--foreground);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }
        
        /* Background */
        .background-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -10;
            overflow: hidden;
        }
        
        .background-pattern {
            position: absolute;
            inset: 0;
            height: 100%;
            width: 100%;
            background-color: var(--background);
            background-image: 
                radial-gradient(var(--gray-200) 1px, transparent 1px),
                radial-gradient(var(--gray-200) 1px, transparent 1px);
            background-size: 20px 20px;
            background-position: 0 0, 10px 10px;
            opacity: 0.5;
        }
        
        .gradient-blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.15;
            animation: float 20s infinite alternate ease-in-out;
        }
        
        .blob-1 {
            width: 500px;
            height: 500px;
            background: var(--primary);
            top: -200px;
            right: -100px;
            animation-delay: 0s;
        }
        
        .blob-2 {
            width: 600px;
            height: 600px;
            background: var(--secondary);
            bottom: -300px;
            left: -200px;
            animation-delay: 5s;
        }
        
        .blob-3 {
            width: 300px;
            height: 300px;
            background: var(--accent);
            top: 40%;
            right: 10%;
            animation-delay: 10s;
        }
        
        @keyframes float {
            0% {
                transform: translate(0, 0) scale(1);
            }
            100% {
                transform: translate(50px, 50px) scale(1.1);
            }
        }
        
        /* Navigation  bar css tis oneJee  */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            z-index: 100;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            animation: slideDown 0.5s ease-out;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }
        
        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
        }
        
        .logo-text {
            font-weight: 700;
            font-size: 1.25rem;
            color: var(--foreground);
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        
        .nav-links {
            display: flex;
            gap: 1.5rem;
        }
        
        .nav-link {
            color: var(--gray-700);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition-normal);
            position: relative;
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            transition: var(--transition-normal);
        }
        
        .nav-link:hover {
            color: var(--primary);
        }
        
        .nav-link:hover::after {
            width: 100%;
        }
        
        .user-menu {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            transition: var(--transition-normal);
        }
        
        .user-menu:hover {
            background: var(--gray-200);
        }
        
        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        .user-name {
            font-weight: 500;
        }
        
        /*  menu buttonJee  */
        .menu-button {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--gray-700);
            cursor: pointer;
        }
        
        @media (max-width: 768px) {
            .nav-links, .user-menu .user-name {
                display: none;
            }
            
            .menu-button {
                display: block;
            }
        }
        
        /* Container p */
        .container {
            max-width: 1200px;
            width: 90%;
            margin: 0 auto;
            padding: 7rem 1rem 4rem;
        }
        
        /* Header of the  Section */
        .header {
            margin-bottom: 3rem;
            animation: fadeIn 0.6s ease-out;
            text-align: center;
        }
        
        .header-title-container {
            position: relative;
            display: inline-block;
            margin-bottom: 1rem;
        }
        
        .header-title {
            font-size: 2.5rem;
            font-weight: 800;
            letter-spacing: -0.025em;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            position: relative;
            z-index: 1;
        }
        
        .header-title-bg {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30%;
            background: var(--primary-lighter);
            z-index: 0;
            transform: skewX(-15deg);
        }
        
        .header-description {
            color: var(--gray-600);
            max-width: 36rem;
            margin: 0 auto;
            font-size: 1.1rem;
            line-height: 1.6;
        }
        
        /* This is Dashboard Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }
        
        .stat-card {
            background: var(--background);
            border-radius: 1rem;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            transition: var(--transition-normal);
            position: relative;
            overflow: hidden;
            animation: fadeUp 0.6s ease-out forwards;
            opacity: 0;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }
        
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: var(--primary-lighter);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--foreground);
        }
        
        .stat-label {
            color: var(--gray-600);
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .stat-trend {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
            font-size: 0.875rem;
        }
        
        .trend-up {
            color: var(--success);
        }
        
        .trend-down {
            color: var(--error);
        }
        
        /* Dashboard Grid Jee  */
        .grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 1.5rem;
        }
        
        @media (min-width: 768px) {
            .grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .header-title {
                font-size: 3rem;
            }
        }
        
        @media (min-width: 1024px) {
            .grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        
        .section {
            background: var(--background);
            border-radius: 1rem;
            box-shadow: var(--card-shadow);
            transition: var(--transition-normal);
            position: relative;
            overflow: hidden;
            animation: fadeUp 0.6s ease-out forwards;
            opacity: 0;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .section:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }
        
        .section-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            font-weight: 600;
            padding: 1.25rem 1.5rem;
            border-radius: 1rem 1rem 0 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .section-header i {
            font-size: 1.25rem;
        }
        
        .section-content {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            flex: 1;
        }
        
        .link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.875rem 1.25rem;
            border-radius: 0.75rem;
            background: var(--gray-100);
            color: var(--gray-800);
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            transition: var(--transition-normal);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 3px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary), var(--secondary));
            transition: var(--transition-normal);
            z-index: -1;
        }
        
        .link:hover {
            color: var(--background);
            transform: translateX(5px);
        }
        
        .link:hover::before {
            width: 100%;
        }
        
        .link i {
            font-size: 1.125rem;
            color: var(--primary);
            transition: var(--transition-normal);
        }
        
        .link:hover i {
            color: var(--background);
        }
        
        /* FooterJee  */
        .footer {
            margin-top: 4rem;
            text-align: center;
            color: var(--gray-600);
            font-size: 0.875rem;
            animation: fadeIn 0.6s ease-out;
            animation-delay: 1s;
            animation-fill-mode: both;
        }
        
        .footer a {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition-normal);
        }
        
        .footer a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        /* Animation  is DelaysJee  */
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        .delay-5 { animation-delay: 0.5s; }
        .delay-6 { animation-delay: 0.6s; }
        .delay-7 { animation-delay: 0.7s; }
        .delay-8 { animation-delay: 0.8s; }
        
        /* These are Animations */
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        
        @keyframes fadeUp {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes slideDown {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(0); }
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        /* Notification  of BadgeJee  */
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: var(--accent);
            color: white;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            animation: pulse 2s infinite;
        }
        
        /* Thi is Quick Actions */
        .quick-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .action-button {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            background: var(--background);
            color: var(--gray-800);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--card-shadow);
            transition: var(--transition-bounce);
            border: none;
            cursor: pointer;
            animation: fadeUp 0.6s ease-out forwards;
            opacity: 0;
        }
        
        .action-button:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            background: var(--primary);
            color: white;
        }
        
        .action-button:hover i {
            transform: scale(1.2);
        }
        
        .action-button i {
            transition: var(--transition-bounce);
        }
        
        .primary-action {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
        }
        
        /* Mobile Responsiveness */
        @media (max-width: 480px) {
            .header-title {
                font-size: 2rem;
            }
            
            .container {
                width: 95%;
                padding: 6rem 0.5rem 2rem;
            }
            
            .quick-actions {
                flex-direction: column;
                align-items: stretch;
            }
            
            .action-button {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- These ate the Background ElementsJee  -->
    <div class="background-elements">
        <div class="background-pattern"></div>
        <div class="gradient-blob blob-1"></div>
        <div class="gradient-blob blob-2"></div>
        <div class="gradient-blob blob-3"></div>
    </div>
    
    <!-- this is Navigation bar of magaciyjee -->
    <nav class="navbar">
        <a href="#" class="logo">
            <div class="logo-icon">
                <i class="fas fa-taxi"></i>
            </div>
            <div class="logo-text">MegaCityJee</div>
        </a>
        
        <div class="nav-links">
            <a href="#" class="nav-link">Dashboard</a>
            <a href="#" class="nav-link">Bookings</a>
            <a href="#" class="nav-link">Vehicles</a>
            <a href="#" class="nav-link">Drivers</a>
            <a href="#" class="nav-link">Reports</a>
        </div>
        
        <div class="user-menu">
            <div class="user-avatar">A</div>
            <div class="user-name">Admin</div>
            <i class="fas fa-chevron-down"></i>
        </div>
        
        <button class="menu-button">
            <i class="fas fa-bars"></i>
        </button>
    </nav>
    
    <div class="container">
        <header class="header">
            <div class="header-title-container">
                <div class="header-title-bg"></div>
                <h1 class="header-title">Admin Dashboard</h1>
            </div>
            <p class="header-description">
                Welcome to your dashboard. Manage bookings,system operations all in one place and registrations .
            </p>
        </header>
        
        <!-- Quick Actions  for add, book and view reports -->
        <div class="quick-actions">
            <button class="action-button primary-action delay-1">
                <i class="fas fa-plus"></i> New Booking
            </button>
            <button class="action-button delay-2">
                <i class="fas fa-car"></i> Add Vehicle
            </button>
            <button class="action-button delay-3">
                <i class="fas fa-user"></i> Add Driver
           
            <button class="action-button delay-4">
                <i class="fas fa-chart-line"></i> View Reports
           
            </button>
        </div>
        
        <!-- Section of StatsJee  --
            <a href="Hel>
        <div class="stats-container">
            <div class="stat-card delay-1">
                <div class="stat-icon">
                    <i class="fas fa-car"></i>
                </div>
                <div class="stat-value">124</div>
                <div class="stat-label">Total Vehicles</div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i> 12% from last month
                </div>
            </div>
            
            <div class="stat-card delay-2">
                <div class="stat-icon">
                    <i class="fas fa-route"></i>
                </div>
                <div class="stat-value">1,893</div>
                <div class="stat-label">Active Bookings</div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i> 8% from last month
                </div>
            </div>
            
            <div class="stat-card delay-3">
                <div class="stat-icon">
                    <i class="fas fa-user"></i>
                </div>
                <div class="stat-value">245</div>
                <div class="stat-label">Registered Drivers</div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i> 5% from last month
                </div>
            </div>
            
            <div class="stat-card delay-4">
                <div class="stat-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="stat-value">LKR47,911</div>
                <div class="stat-label">Monthly Revenue</div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i> 15% from last month
                </div>
            </div>
        </div>
        
        <!-- this is Main Grid -->
        <div class="grid">
            <!-- Booking Section -->
            <div class="section delay-5">
                <div class="section-header">
                    <i class="fas fa-calendar-check"></i>
                    <h3>Booking</h3>
                </div>
 <div class="section-content">
                    <a href="BookingsRegister.jsp" class="link">
                        <i class="fas fa-taxi"></i> Book a Cab
                    </a>
                    <a href="BookingHistory.jsp" class="link">
                        <i class="fas fa-history"></i> Booking History
                        <span class="notification-badge">3</span>
                    </a>
                    <a href="Help.jsp" class="link">
                        <i class="fas fa-question-circle"></i> Help
                    </a>
                </div>
            </div>
            
            <!-- Register the  Section -->
            <div class="section delay-6">
                <div class="section-header">
                    <i class="fas fa-user-plus"></i>
                    <h3>Register</h3>
                </div>
                <div class="section-content">
                    <a href="RegisterCar.jsp" class="link">
                        <i class="fas fa-car"></i> Register Car
                    </a>
                    <a href="CustomerRegister.jsp" class="link">
                        <i class="fas fa-user"></i> Register Customer
                    </a>
                    <a href="Driver.jsp" class="link">
                        <i class="fas fa-id-card"></i> Register Driver
                    </a>
                </div>
            </div>
            
            <!-- Update the  Section -->
            <div class="section delay-7">
                <div class="section-header">
                    <i class="fas fa-edit"></i>
                    <h3>Update</h3>
                </div>
                <div class="section-content">
                    <a href="CarUpdate.jsp" class="link">
                        <i class="fas fa-car-alt"></i> Update Car
                    </a>
                    <a href="CustomerUpdate.jsp" class="link">
                        <i class="fas fa-user-edit"></i> Update Customer
                    </a>
                    <a href="DriverUpdate.jsp" class="link">
                        <i class="fas fa-id-badge"></i> Update Driver
                    </a>
                </div>
            </div>
            
            <!-- Delete  the Section -->
            <div class="section delay-8">
                <div class="section-header">
                    <i class="fas fa-trash-alt"></i>
                    <h3>Delete</h3>
                </div>
                <div class="section-content">
                    <a href="CarDelete.jsp" class="link">
                        <i class="fas fa-car-crash"></i> Delete Car
                    </a>
                    <a href="CustomerDelete.jsp" class="link">
                        <i class="fas fa-user-minus"></i> Delete Customer
                    </a>
                    <a href="DriverDelete.jsp" class="link">
                        <i class="fas fa-user-slash"></i> Delete Driver
                    </a>
                </div>
            </div>
        </div>
        
        <!--This Footer  code of this megacityJee-->
        <footer class="footer">
            <p>&copy; 2026 MegaCityJee Cab is System. All rights are reserved. <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></p>
        </footer>
    </div>
    
    <script>
        // Add active class to the current nav link of java sript
        document.addEventListener('DOMContentLoaded', function() {
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks[0].style.color = 'var(--primary)';
            navLinks[0].style.fontWeight = '600';
            
            // this is  hover effect to nav linksjee
            navLinks.forEach(link => {
                link.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                });
                
                link.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Add active class to form inputs when they have contentjee
            const formGroups = document.querySelectorAll('.form-group');
            formGroups.forEach(group => {
                const input = group.querySelector('input');
                if (input && input.value) {
                    group.classList.add('active');
                }
            });
            
            // Mobile menu togglejee
            const menuButton = document.querySelector('.menu-button');
            const navLinksContainer = document.querySelector('.nav-links');
            
            if (menuButton && navLinksContainer) {
                menuButton.addEventListener('click', function() {
                    if (navLinksContainer.style.display === 'flex') {
                        navLinksContainer.style.display = 'none';
                    } else {
                        navLinksContainer.style.display = 'flex';
                        navLinksContainer.style.position = 'absolute';
                        navLinksContainer.style.top = '100%';
                        navLinksContainer.style.left = '0';
                        navLinksContainer.style.width = '100%';
                        navLinksContainer.style.background = 'white';
                        navLinksContainer.style.flexDirection = 'column';
                        navLinksContainer.style.padding = '1rem';
                        navLinksContainer.style.boxShadow = '0 10px 20px rgba(0,0,0,0.1)';
                    }
                });
            }
            
            // Add parallax effect to background blobsjee
            document.addEventListener('mousemove', function(e) {
                const blobs = document.querySelectorAll('.gradient-blob');
                const x = e.clientX / window.innerWidth;
                const y = e.clientY / window.innerHeight;
                
                blobs.forEach((blob, index) => {
                    const speed = (index + 1) * 20;
                    const xOffset = (x - 0.5) * speed;
                    const yOffset = (y - 0.5) * speed;
                    
                    blob.style.transform = `translate(${xOffset}px, ${yOffset}px)`;
                });
            });
            
            // Add hover effect to action buttonsjee
            const actionButtons = document.querySelectorAll('.action-button');
            actionButtons.forEach(button => {
                button.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                
                button.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Add hover effect to section linksjee
            const links = document.querySelectorAll('.link');
            links.forEach(link => {
                link.addEventListener('mouseenter', function() {
                    this.querySelector('i').style.transform = 'scale(1.2)';
                });
                
                link.addEventListener('mouseleave', function() {
                    this.querySelector('i').style.transform = 'scale(1)';
                });
            });
            
            // Add pulse animation to  the notification badgesjee
            const badges = document.querySelectorAll('.notification-badge');
            badges.forEach(badge => {
                setInterval(() => {
                    badge.style.transform = 'scale(1.2)';
                    setTimeout(() => {
                        badge.style.transform = 'scale(1)';
                    }, 500);
                }, 3000);
            });
            
            // Add hover effect to  the  cardsJee
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
        });
        document.addEventListener("DOMContentLoaded", function () {
    const reportButton = document.querySelector(".action-button.delay-4");

    reportButton.addEventListener("click", function () {
        alert("Redirecting to Reports...");
        // Add code here to navigate to the reports page or fetch data
    });
});

    </script>
</body>
</html>