<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
 request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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

    a{
      color: black;
      text-decoration:none;
    }
    a:hover {  
      color: #272821;
      text-decoration:none;
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
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Staff</a></li>
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
        <button onclick="sendSearch()" class="btn btn-default" type="button">Go!</button>
      </span>
    </div><!-- /input-group -->
 </div>
  </div>
            
</div>
<div id="searchRs">
</div>
<br>

<br><br>

<footer class="container-fluid text-center">
  <p>Footer Text</p>
</footer>
<script type="text/javascript">

      function sendSearch(){
        window.location.replace('?term='+$( "#searchText" ).val());
         return;
      }


      /*
      * 送出表單
      */
      function getLyrics()
      {
          /*
          * Ajax
          */
        <%
      String term = "INDEX8";
       if(request.getParameter("term") != null){
            term = new String(request.getParameter("term")
                                .getBytes("ISO-8859-1"), "utf-8");
        }

        %>
        var params = 'term=<%=term%>';

        $.ajax({
                  url: 'API/getLyrics.jsp',
                  type:"post",
                  data: params,
                  success: function(data){
                      var data = JSON.parse(data);
                      var allDataRow = "";
                      //先mod4看有幾個
                      var temp = "";
                      var count = 0;
                      for(var i=0;i<data.length;i++){
                          temp +='<div class="col-sm-3"> <a href="lyrics.jsp?vid='+data[i].id+'">'+
                          data[i].title
                          +'</a><img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image"></div>';
                        count++;
                        if(count%4==0){
                          //mix row & add
                          allDataRow += '<div class="container-fluid bg-3 text-center"><div class="row">'
                          +
                            temp;
                          +
                          '</div>';
                          if(i!=0){
                            allDataRow +="&nbsp;<br/>";
                          }
                          temp="";
                        }
                      }
                      //final
                      allDataRow += '<div class="container-fluid bg-3 text-center"><div class="row">'
                          +
                            temp;
                          +
                         '</div>';

                      $( "#searchRs" ).empty();
                      $( "#searchRs" ).append( allDataRow );

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
      
      $( document ).ready(function() {
          getLyrics();
          //sendSearch("INDEX8");
      });
</script>
</body>
</html>
