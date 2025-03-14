<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Driver Details</title>
    <style>
        /* Customized CSS for the JSP Page */
        body {
            font-family: 'Arial', sans-serif;
            background: #f0f0f0; /* Light gray mixed with white */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .parent {
            width: 350px;
            perspective: 1000px;
        }

        .card {
            background: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
            border-radius: 30px;
            padding: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            transform-style: preserve-3d;
            transition: all 0.5s ease-in-out;
        }

        .glass {
            background: rgba(255, 255, 255, 0.5); /* More transparent white */
            border-radius: 20px;
            padding: 20px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transform: translate3d(0, 0, 20px);
        }

        .content {
            transform: translate3d(0, 0, 30px);
        }

        .content .title {
            color: #333; /* Dark gray for text */
            font-weight: 900;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        form input[type="text"],
        form input[type="date"],
        form input[type="email"] {
            padding: 10px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.9); /* Slightly opaque white */
            font-size: 16px;
            color: #333; /* Dark gray for text */
            outline: none;
            transition: all 0.3s ease;
        }

        form input[type="text"]:focus,
        form input[type="date"]:focus,
        form input[type="email"]:focus {
            background: rgba(255, 255, 255, 1); /* Fully white on focus */
            transform: translate3d(0, 0, 10px);
        }

        form input[type="submit"] {
            padding: 10px;
            border: none;
            border-radius: 10px;
            background: #00894d; /* Green color for the button */
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        form input[type="submit"]:hover {
            background: #006f3d; /* Darker green on hover */
            transform: translate3d(0, 0, 10px);
        }

        .logo {
            position: absolute;
            right: 20px;
            top: 20px;
            transform-style: preserve-3d;
        }

        .logo .circle {
            display: block;
            position: absolute;
            aspect-ratio: 1;
            border-radius: 50%;
            background: rgba(0, 249, 203, 0.2); /* Light green circle */
            backdrop-filter: blur(5px);
            transition: all 0.5s ease-in-out;
        }

        .logo .circle1 {
            width: 80px;
            transform: translate3d(0, 0, 60px);
            top: 0;
            right: 0;
        }

        .logo .circle2 {
            width: 60px;
            transform: translate3d(0, 0, 80px);
            top: 10px;
            right: 10px;
        }

        .logo .circle3 {
            width: 40px;
            transform: translate3d(0, 0, 100px);
            top: 20px;
            right: 20px;
        }

        .parent:hover .card {
            transform: rotate3d(1, 1, 0, 15deg);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2); /* Slightly stronger shadow on hover */
        }

        .parent:hover .logo .circle1 {
            transform: translate3d(0, 0, 80px);
        }

        .parent:hover .logo .circle2 {
            transform: translate3d(0, 0, 100px);
        }

        .parent:hover .logo .circle3 {
            transform: translate3d(0, 0, 120px);
        }
    </style>
</head>
<body>
    <!-- Update Driver Details Form -->
    <div class="parent">
        <div class="card">
            <div class="glass">
                <div class="content">
                    <div class="title">Update Driver</div>
                    <form action="/MegaCityCabSystemJee/UpdateDriverServlet" method="post">
                        <input type="text" name="DriverIDJ" placeholder="Driver ID (Required)" required>
                        <input type="text" name="FirstNameJ" placeholder="First Name">
                        <input type="text" name="LastNameJ" placeholder="Last Name">
                        <input type="date" name="DobJ" placeholder="Date of Birth">
                        <input type="text" name="NICNoJ" placeholder="NIC Number">
                        <input type="text" name="LicenseNumberJ" placeholder="License Number">
                        <input type="text" name="AddressJ" placeholder="Address">
                        <input type="text" name="TelephoneJ" placeholder="Telephone">
                        <input type="email" name="EmailJ" placeholder="Email">
                        <input type="submit" value="Update Driver">
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>