<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegacityJee Support</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            background-image: url('https://via.placeholder.com/1500x800'); /* Replace with actual background image */
            background-size: cover;
            background-position: center;
            overflow-x: hidden;
        }
        .header {
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
            animation: fadeInDown 0.8s ease-out;
        }
        .content {
            margin-top: 50px;
            color: black;
            animation: fadeIn 1s ease-out;
        }
        .grid-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .grid-item {
            background: white;
            padding: 20px;
            margin: 10px;
            width: 160px;
            height: 120px;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: scaleIn 0.5s ease-out forwards;
            opacity: 0;
            transform: scale(0.8);
        }
        .grid-item:nth-child(1) { animation-delay: 0.1s; }
        .grid-item:nth-child(2) { animation-delay: 0.2s; }
        .grid-item:nth-child(3) { animation-delay: 0.3s; }
        .grid-item:nth-child(4) { animation-delay: 0.4s; }
        .grid-item:nth-child(5) { animation-delay: 0.5s; }
        
        .grid-item:hover {
            transform: translateY(-10px);
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.15);
        }
        
        .grid-item::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, #3498db, #2ecc71);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .grid-item:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        .grid-item i {
            font-size: 30px;
            margin-bottom: 10px;
            transition: transform 0.3s ease, color 0.3s ease;
            color: #555;
        }
        
        .grid-item:hover i {
            transform: scale(1.2);
            color: #3498db;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        /* Pulse animation for icons */
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }
        
        h1 {
            animation: fadeInDown 0.8s ease-out 0.2s both;
        }
        
        p {
            animation: fadeInDown 0.8s ease-out 0.4s both;
        }
    </style>
</head>
<body>
    <div class="header">Help</div>
    
    <div class="content">
        <h1>Welcome to MegacityJee Support</h1>
        <p>We're here to help. Looking for customer service contact information? Explore support resources below.</p>
        
        <div class="grid-container">
            <div class="grid-item">
                <i class="fas fa-car pulse"></i>
                Riders
            </div>
            <div class="grid-item">
                <i class="fas fa-steering-wheel"></i>
                Driving & Delivering
            </div>
            <div class="grid-item">
                <i class="fas fa-comment-dots"></i>
                Complaint
            </div>
            <div class="grid-item">
                <i class="fas fa-comment-pen"></i>
                Feedback
            </div>
            <div class="grid-item">
                <i class="fas fa-utensils"></i>
                Merchants & Restaurants
            </div>
        </div>
    </div>
</body>
</html>