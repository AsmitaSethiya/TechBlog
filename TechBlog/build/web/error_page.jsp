<%-- 
    Document   : error_page
    Created on : 13 Jun, 2023, 11:43:01 AM
    Author     : asmita.sethiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
          clip-path: polygon(30% 0%, 70% 0%, 99% 0, 100% 98%, 68% 95%, 33% 98%, 0 94%, 0 0);
            }
        </style>
    </head>
    <body>
        <div class="container text-center">
            <img src="img/computer.png" class="img-fluid" alt="error page">
            <h3 class="display-3">Sorry !! Something went wrong....</h3>
            <%= exception %>
            <a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
        </div>
    </body>
</html>
