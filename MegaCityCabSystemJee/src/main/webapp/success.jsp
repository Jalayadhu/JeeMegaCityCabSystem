


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration Successful</title>
    <style>
        /* Custom CSS with animations and glassmorphism */
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
            height: 250px;
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

        .parent:hover .card {
            transform: rotate3d(1, 1, 0, 30deg);
            box-shadow:
                rgba(5, 71, 17, 0.3) 30px 50px 25px -40px,
                rgba(5, 71, 17, 0.1) 0px 25px 30px 0px;
        }

        .success-message {
            color: #00894d;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            animation: fadeIn 2s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="parent">
        <div class="card">
            <div class="glass"></div>
            <div class="content">
                <span class="title">Registration Successful</span>
                <div class="success-message">
                    Your registration has been completed successfully!
                </div>
            </div>
        </div>
    </div>
</body>
</html>