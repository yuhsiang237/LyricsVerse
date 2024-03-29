<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
 request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Lyrics Verse</title>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="./UI/animate.css">
   <link rel="stylesheet" href="./UI/sweetalert2.css">
   <script type="text/javascript" src="./UI/sweetalert2.js"></script>
  <link rel="stylesheet" href="./UI/bootstrap.min.css">
  <script src="./UI/jquery.min.js"></script>
  <script src="./UI/bootstrap.min.js"></script>
  <script src='https://www.google.com/recaptcha/api.js'></script>

  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
    .lv-div-center{
        margin: 0px auto;
    }
    .lv-text-center{
      text-align: center;
    }
    pre{
        background: white;
        border: none;
        font-weight:;
    }

    #searchText,#gobtn{
      z-index: 0;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Lyrics Verse</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
       <li class="active"><a href="./index.jsp">Home</a></li>
        <li><a href="./about.jsp">About</a></li>
        <li><a href="./staff.jsp">Staff</a></li>
        <%
        if(session.getAttribute("TOKEN")!=null){
        out.print(
        "<li><a href='post.jsp'>Post Lyrics</a></li>");
      }
        
      %>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <%
        if(session.getAttribute("TOKEN")==null){
out.print("<li><a href='login.jsp'><span class='glyphicon glyphicon-log-in'></span> Login</a></li>");
out.print("<li><a href='register.jsp'><span class='glyphicon'></span> Register</a></li>");
        }
        else{
        out.print(
        "<li><a href='javascript:logout();' ><span class='glyphicon glyphicon-log-in'></span>Logout</a></li>");
      }
      %>
      </ul>
    </div>
  </div>
</nav>

<div class="jumbotron">
  <div class="container lv-text-center">
    <h1>Lyrics Verse</h1>      
    <p>We collect some lyrics.</p>
 
  </div>
  <div class="row text-center">
        <div class="lv-div-center" style="width: 50%">
    <div class="input-group">
      <input id="searchText" type="text" class="form-control" placeholder="Search for...">
      <span class="input-group-btn">
        <button id="gobtn"class="btn btn-default" type="button">Go!</button>
      </span>
    </div><!-- /input-group -->
 </div>
  </div>
            
</div>
  
<div class="text-center lv-div-center">
   <div id="loginPad" class="container" style="width: 300px;">
   <form method="POST" action="API/login.jsp">
        <h2 class="form-signin-heading">Sign in</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input name="account" type="text" id="account" class="form-control" placeholder="Account" required autofocus><br>
        <label for="inputPassword" class="sr-only">Password</label>
        <input name="password" type="password" id="password" class="form-control" placeholder="Password" required>
        <br>
        <div class="g-recaptcha" data-sitekey="6Ld8IxAUAAAAAAr-rh-Wq4f5-RUTRWQ-UP-nKz9H"></div>
        <br>
        <input  type="submit"  class="btn btn-lg btn-primary btn-block" value="Sign in"></input >
      
    </form>

    </div> <!-- /container -->

</div>
<br><br>

<footer class="container-fluid text-center">
    <p>Copyright © 2016 UM Inc. All rights reserved
</p>
</footer>

</body>
<script type="text/javascript">
    /*
      * 送出表單
      */
      function sendLogin()
      {
          /*
          * Ajax
          */
          var account = $('#account').val();
          var password = $('#password').val();
         
        var params = 'account='+account+
                        '&password='+password;

          
        $.ajax({
                  url: 'API/login.jsp',
                  type:"post",
                  data: params,
                  success: function(data){
                      var data = JSON.parse(data);
                      if(data.status == 'success'){
                          window.location.href='./index.jsp';
                      }
                      else{
                        swal(
                              'Failed',
                              'Account or Password wrong!',
                              'error'
                            )
                        $('#loginPad').addClass('animated shake');
                      }
                  }
          });
      }
      function logout(){
        var params = "";
        $.ajax({
                  url: 'API/logout.jsp',
                  type:"post",
                  data: params,
                  success: function(data){
                      location.reload();

                  }
          });

      }
      
</script>
</html>
<!--load-->
<div id="overlay">
<div id="showload">
<span class="cssload-loader"><span class="cssload-loader-inner"></span></span>
</div>
</div>
<link rel="stylesheet" type="text/css" href="./UI/load.css">
<script type="text/javascript" src="./UI/load.js"></script>
