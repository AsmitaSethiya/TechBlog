<%-- 
    Document   : profile
    Created on : 13 Jun, 2023, 7:29:13 PM
    Author     : asmita.sethiya
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.entities.category"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User)session.getAttribute("currentUser");
    if(user == null)
    {
        response.sendRedirect("login_page.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
         <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
           clip-path: polygon(30% 0%, 70% 0%, 99% 0, 100% 91%, 68% 95%, 33% 92%, 0 94%, 0 0);
            }
        </style>

    </head>
    <body>
      <!--statr of navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
           <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Tech Blog</a>
           <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
           <span class="navbar-toggler-icon"></span>
           </button>

         <div class="collapse navbar-collapse" id="navbarSupportedContent">
           <ul class="navbar-nav mr-auto">
             <li class="nav-item active">
                 <a class="nav-link" href="#"><span class="fa fa-book"></span>Learn Code with Asmita<span class="sr-only">(current)</span></a>
             </li>

             <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   <span class="fa fa-exchange"></span>Categories
               </a>
               <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="#">Programming Language</a>
                 <a class="dropdown-item" href="#">Project Implementation</a>
                 <div class="dropdown-divider"></div>
                 <a class="dropdown-item" href="#">Data Structure</a>
               </div>
             </li>

             <li class="nav-item">
                 <a class="nav-link" href="#"><span class="fa fa-address-book"></span>Contact</a>
             </li>
             <li class="nav-item">
                 <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-edit"></span>Do Post</a>
             </li>


           </ul>
             <ul class="navbar-nav mr-right">
               <li class="nav-item">
                 <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span><%= user.getName() %></a>
               </li> 
               <li class="nav-item">
                 <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span>Logout</a>
               </li> 
             </ul>
         </div>
       </nav>
      <!--end of navbar-->
                            <%
                               Message m = (Message)session.getAttribute("msg");
                               if(m!=null){
                            %>   
                                <div class="alert <%= m.getCssClass() %>" role="alert">
                                    <%= m.getContent() %>
                                </div>
                            <%
                               session.removeAttribute("msg");
                               }
                            %>  
       
       <!--main body of the page start-->
       <main>
           <div class="container">
            <div class="row mt-4">
            
                <!--first col-->
                <div class="col-md-4">
                    <!--categories-->
                  <div class="list-group">
                      <a href="#" onclick="getPost(0,this)" class=" c-link list-group-item list-group-item-action active">
                      All Posts
                    </a>
                      <!--Categories-->
                      <%
                         PostDao d = new PostDao(ConnectionProvider.getConnection());
                         ArrayList<category> list1 = d.getAllCategories();
                         for(category cc:list1)
                         {
                      %>
                      <a href="#" onclick="getPost(<%= cc.getCid()%>,this)" class=" c-link list-group-item list-group-item-action"><%= cc.getName() %></a>
                      <%
                         }
                      %>
                    </div> 
                    
                </div>
                <!--second col-->
                <div class="col-md-8">
                    <!--post-->
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa-4x fa-spin"></i>
                        <h3 class="mt-2">Loading............</h3>
                    </div>
                    <div class="container-fluid" id="post-container">
                        
                    </div>
                </div>
            </div>
           </div>
       </main>
       <!--main body of the page end-->
                            
                            
                            
      <!--profile modal-->
      
      
     

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  <div class="container text-center">
                      <img src="pics/<%= user.getProfile()%>" alt="profile picture"/>
                      
                      <h5 class="modal-title" id="exampleModalLabel"> <%= user.getName() %></h5>
                      
                      <!--user details-->
                      <div id="profile-details">
                      <table class="table">
                        
                        <tbody>
                          <tr>
                            <th scope="row">Id</th>
                            <td><%= user.getId() %></td>
                            
                          </tr>
                          <tr>
                            <th scope="row">Email:</th>
                            <td><%= user.getEmail() %></td>
                           
                          </tr>
                          <tr>
                            <th scope="row">Gender :</th>
                            <td><%= user.getGender() %></td>
                          </tr>
                          <tr>
                            <th scope="row">About</th>
                            <td><%= user.getAbout()%></td>
                          </tr>
                          <tr>
                            <th scope="row">Registered on: </th>
                            <td><%= user.getDateTime().toString()%></td>
                          </tr>
                        </tbody>
                      </table>
                      </div>
                  </div>
                          
                          <!--profile edit-->
                   
                          <div id="profile-edit" style="display: none;">
                              <h2 class="mt-2 text-center">Please Edit Carefully</h2>
                              <form action="EditServlet" method="post" enctype="multipart/form-data">
                                  <table class="table">
                                      <tr>
                                          <td>Id : </td>
                                          <td><%= user.getId() %></td>
                                      </tr>
                                      <tr>
                                          <td>Email: </td>
                                          <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail() %>"></td>
                                      </tr>
                                      <tr>
                                          <td>Name </td>
                                          <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                      </tr>
                                      <tr>
                                          <td>Password </td>
                                          <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                      </tr>
                                      <tr>
                                          <td>Gender </td>
                                          <td><%= user.getGender().toUpperCase()%></td>
                                      </tr>
                                      <tr>
                                          <td>About: </td>
                                          <td>
                                              <textarea class="form-control" name="user_about"> <%= user.getAbout() %></textarea>  
                                          </td>
                                      </tr>
                                      <tr>
                                          <td>New Profile</td>
                                          <td>
                                              <input type="file" name="image" class="form-control">
                                          </td>
                                      </tr>
                                  </table>
                                   
                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-outlinr-primary">Save</button>
                                    </div>
                                              
                              </form>
                          </div>   
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button id="edit-profile-btn" type="button" class="btn btn-primary">EDIT</button>
              </div>
            </div>
          </div>
        </div>
      
       
      <!-- end of profile modal--> 
      
      <!--add post modal-->
      
      <!-- Button trigger modal -->
       

        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  <form id="add-post-form" action="AddPostServlet" method="post">
                    
                    <div class="form-group">
                        <select class="form-control" name="cid">
                            <option selected disabled>----Select Category----</option>
                            
                            <%
                                PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                
                                ArrayList<category> list = postd.getAllCategories();
                                
                                for(category c:list)
                                {
                                %>
                                <option value="<%= c.getCid() %>"><%= c.getName() %></option>
                                   
                                    
                                    <%
                                        }
                                     %>
                                </select>
                    </div>
                    
                    <div class="form-group">
                        <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control"> 
                    </div>
                    <div class="form-group">
                        <textarea name="pContent" class="form-control" style="height: 100px" placeholder="Enter your content here"></textarea>
                    </div>
                    <div class="form-group">
                        <textarea name="pCode" class="form-control" style="height: 100px" placeholder="Enter your program here (if any)"></textarea>
                    </div
                    <div>
                        <label>Select your pic...</label>
                        <br>
                        <input name="pic" type="file">
                    </div>
                    
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-primary">Post</button>
                    </div>
                    
                </form>
              </div>
            </div>
          </div>
        </div>

      
      
      
      
      <!--add post modal end-->
      
      
      
        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
         <script src="js/myjs.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
         <script>
             $(document).ready(function()
             {
                 let editStatus = false;
                 
                 $('#edit-profile-btn').click(function(){
                      if(editStatus == false)
                      {
                            $("#profile-details").hide();
                     
                            $("#profile-edit").show();
                            
                            editStatus = true;
                            
                            $(this).text("Back");
                      }
                      else
                      {
                            $("#profile-details").show();
                     
                            $("#profile-edit").hide();
                     
                            editStatus = false;

                          $(this).text("Edit");
                      }
                 });
                 
             });
         </script>
             
            <!--adding post js-->
            <script>
                $(document).ready(function (e){
                    
                    $("#add-post-form").on("submit",function(event)
                    {
                       //this code is execute when form is submit
                       event.preventDefault();
                       console.log("Submitted");
                       
                       let form  = new FormData(this);
                       //now requesting to server
                       $.ajax({
                           
                           url : "AddPostServlet",
                           type: 'POST',
                           data: form,
                           success: function (data, textStatus, jqXHR) {
                               console.log(data);
                               if(data.trim()=='done')
                               {
                                   
                                 swal("Good job!", "Post Saved Successfully", "success");
                               }
                               else
                               {
                                   
                                 swal("Error", "Sorry Something went wrong, Please try again", "error"); 
                                   
                               }
                            }, 
                            error: function (jqXHR, textStatus, errorThrown) {
                                 swal("Error", "Sorry Something went wrong, Please try again", "error"); 
                                
                                 
                             },
                             
                             processData: false,
                             contentType: false
                                                
                           
                       });
                       
                        
                    });
                    
                    
                });
            </script>
     <!--loading post-->
     <script>
      
             function getPost(catId,temp)
             {
                 $("#loader").show();
                 $("#post-container").hide();
                 
                 $(".c-link").removeClass("active");
                 
                  $.ajax({
                 url: "load_post.jsp",
                 data:{cid:catId},
                 success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                        $(temp).addClass("active");
                    }
                 
             });
                 
            }
            
               $(document).ready(function(e){ 
                   
                   let allPostRef = $(".c-link")[0];
                   
                   getPost(0,allPostRef);
         });
     </script>
    </body>
</html>
