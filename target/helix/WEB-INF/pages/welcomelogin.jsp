<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" type="image/png" href="/static/images/favicon.ico"/>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <style>
        html,
        body {
            height: 100%;
        }
        body {
            height: 100vh;
            align-items: center;
            background-color: #f5f5f5;
            width: 100%;
            max-width: 360px;
            margin: 0 auto;
        }

        .btn-primary {
            background-color: #1DA1F2;
        }
        .btn-primary:hover {
            background-color: #4d02ee;
        }

        .error-text {
            text-align: center;
            color: #ff0000;
            display: none;
        }

        .links {
            text-align: right;
            margin-top: 1rem;
        }

        .links a {
            margin-top: 0.5rem;
        }

        .content {
            margin-top: 6rem;
            padding: 1rem;
        }

        .my-2 {
            margin-top: 2rem !important;
            margin-bottom: 2rem !important;
        }

        hr.divider {
            text-align: center;
            color: rgba(0, 0, 0, 0.5);
        }

        hr.divider:after {
            content: "Or";
            display: inline-block;
            position: relative;
            top: -14px;
            text-align: center;
            padding: 0 16px;
            background-color: #f5f5f5;
        }

        .auth-container {
            padding: 15px;
            margin: 0 auto;
        }

        .auth-container .form-control {
            position: relative;
            box-sizing: border-box;
            padding: 10px;
            font-size: 16px;
        }

        .auth-container input[type="email"] {
            margin-bottom: -1px;
        }
    </style>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
            integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
            crossorigin="anonymous"
    />
</head>
<body style="margin:0 auto;height: auto">
<div style="margin-top: 5rem;height:auto" >
    <form class="auth-container text-center" >

        <h1 class="h3 mb-3 font-weight-normal">Login Your Account</h1>
        <p class="mb-3 text-muted">
            Welcome to the  social network . Let's connect.
         </p>


        <div class="text-left">

            <div class="form-group">
                <label name="email" for="exampleInputEmail1">Email</label>
                <input
                        type="email"
                        id="signup-email"
                        class="form-control"
                        id="exampleInputEmail1"
                        name="email"
                        aria-describedby="emailHelp"
                        placeholder="Fill Your Email"
                        required
                />
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input
                        type="password"
                        id="signup-password"
                        name="password"
                        class="form-control"
                        id="exampleInputPassword1"
                        placeholder="Fill Your Password"
                        required
                />
            </div>
        </div>
        <p class="error-text" id="signup-error" >Sample error</p>
        <button class="btn btn-primary btn-block" type="button" id="btn-signup">LOGIN</button>
    </form>
</div>
<script>
    //javascript function
    function validateSignupForm()
    {
        var email = $("#signup-email").val();
        var password= $("#signup-password").val();
        var error="";

        if(!email)
        {
            error+="Email is empty. "
        }
        if(!password)
        {
            error+="Password is empty. "
        }
        if(password.length<=3)
        {
            error+="Password length must be greater than 3 characters."
        }
        $("#signup-error").html(error);

        if(error.length>0)
        {
            return false;
        }



        return true;
    }

    $("#btn-signup").click(function(){
        var isFormvalid=validateSignupForm();
        if(isFormvalid)
        {
            $("#signup-error").hide();
            var email = $("#signup-email").val();
            var password= $("#signup-password").val();
            var user={
                "email":email,
                "password":password
            };
            $.ajax({
                type: "POST",
                url:"/login/welcome" ,
                data: JSON.stringify(user),//converting object to string
                success: function(response){
                    if(!!response){
                       if(response.is_logined===true)
                       {
                         location.href="/welcome";
                       }else{
                           $("#signup-password").val("");
                           $("#signup-error").html(response.message);
                           $("#signup-error").show();
                       }

                    }

                    },
                contentType: "application/json"
            });
        }else{
            $("#signup-error").show()
        }

    });
</script>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"
></script>
</body>
</html>