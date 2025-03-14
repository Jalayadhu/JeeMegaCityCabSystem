
<!DOCTYPE html>
<html>
<head>
    <title>Delete Customer</title>
    <style>
        /* Custom CSS by codelofi.coffee */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: Arial, sans-serif;
        }

        .parent {
            width: 350px;
            height: 300px;
            perspective: 1000px;
        }

        .card {
            height: 100%;
            border-radius: 50px;
            background: linear-gradient(135deg, rgb(0, 255, 214) 0%, rgb(8, 226, 96) 100%);
            transition: all 0.5s ease-in-out;
            transform-style: preserve-3d;
            box-shadow:
                rgba(5, 71, 17, 0) 40px 50px 25px -40px,
                rgba(5, 71, 17, 0.2) 0px 25px 25px -5px;
            padding: 20px;
            box-sizing: border-box;
        }

        .glass {
            transform-style: preserve-3d;
            position: absolute;
            inset: 8px;
            border-radius: 55px;
            border-top-right-radius: 100%;
            background: linear-gradient(0deg, rgba(255, 255, 255, 0.349) 0%, rgba(255, 255, 255, 0.815) 100%);
            transform: translate3d(0px, 0px, 25px);
            border-left: 1px solid white;
            border-bottom: 1px solid white;
            transition: all 0.5s ease-in-out;
        }

        .content {
            padding: 40px 30px 0px 30px;
            transform: translate3d(0, 0, 26px);
        }

        .content .title {
            display: block;
            color: #00894d;
            font-weight: 900;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }

        .content input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #00894d;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.8);
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
        }

        .content input[type="text"]:focus {
            background: rgba(255, 255, 255, 1);
            transform: translate3d(0, 0, 10px);
        }

        .content input[type="submit"] {
            width: 100%;
            padding: 10px;
            background: #00894d; /* Green color for the button */
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .content input[type="submit"]:hover {
            background: #006f3d; /* Darker green on hover */
            transform: translate3d(0, 0, 10px);
        }

        .parent:hover .card {
            transform: rotate3d(1, 1, 0, 30deg);
            box-shadow:
                rgba(5, 71, 17, 0.3) 30px 50px 25px -40px,
                rgba(5, 71, 17, 0.1) 0px 25px 30px 0px;
        }

        .msg {
            color: #dc3545; /* Red color for error messages */
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="parent">
        <div class="card">
            <div class="glass"></div>
            <div class="content">
                <span class="title">Delete Customer</span>
                <form action="DeleteCustomersServlet" method="post">
                    
                    <input type="text" name="registration_number" placeholder="Registration Number" required>
                    <input type="submit" value="Delete Customer">
                </form>
            </div>
        </div>
    </div>
</body>
</html>