<%@page import="com.techblog.entities.User"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>

<div class="row">

<%
    User u = (User)session.getAttribute("currentUser");
    Thread.sleep(1000);
   PostDao d = new PostDao(ConnectionProvider.getConnection());
   
   int cid  = Integer.parseInt(request.getParameter("cid"));
   List<Post> posts = null;
   if(cid == 0)
   {
     posts = d.getAllPost();
   }
   else
   {
        posts = d.getPostByCatID(cid);
    }
   
    if(posts.size() == 0)
    {
        out.println("<h3 class='display-4 text-center'>No post in this category !!</h3>");
        return;
    }
    
    for(Post p: posts)
    {

%>
<div class="col-md-6 mt-2">
    <div class="card">
        <img class="card-img-top" src="blog_pic/<%= p.getpPic() %>" alt="Card Image">
        <div class="card-body">
            <b><%= p.getpTitle() %></b>
            <p><%= p.getpContent() %></p>
        </div> 
        <div class="card-footer primary-background text-center">
            <% 
                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
            %>
            <a href="show_blog_page.jsp?post_id=<%= p.getpId() %>" class="btn btn-outline-light btn-rm">Read More...</a>
            <a href="#!"  onclick="doLike(<%= p.getpId()%>,<%= u.getId()%>)" class="btn btn-outline-light btn-rm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikePost(p.getpId()) %></span></a>
            <a href="#!" class="btn btn-outline-light btn-rm"><i class="fa fa-commenting-o"></i><span>10</span></a>
        </div>
    </div>
</div>
<%    
        }
%>

</div>