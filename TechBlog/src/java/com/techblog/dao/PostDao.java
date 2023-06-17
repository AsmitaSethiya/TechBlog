/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.techblog.dao;
import com.techblog.entities.Post;
import com.techblog.entities.category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

/**
 *
 * @author asmita.sethiya
 */
public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    
    public ArrayList<category> getAllCategories()
    {
        ArrayList<category> list = new ArrayList<>();
        
        try
        {
            String  q  = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);
            while(set.next())
            {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getNString("description");
                
                category c = new category(cid,name,description);
                list.add(c);
                
                
            }
        
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        
        return list;
    
    }

   
public boolean savePost(Post p)
{

    boolean f  = false;
    
    try
    {
    
        String q = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) value (?,?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(q);
        
        stmt.setString(1, p.getpTitle());
        stmt.setString(2, p.getpContent());
        stmt.setString(3, p.getpCode());
        stmt.setString(4, p.getpPic());
        stmt.setInt(5, p.getCatId());
        stmt.setInt(6, p.getUserId());
        
        stmt.executeUpdate();
        f = true;
        
        
        
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    
    
    return f;
    
    
}
    
   
public List<Post> getAllPost()
{
    List<Post> list = new ArrayList<>();
    
    //fetch all post
    
    try
    {
    
        PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
        
        ResultSet set= p.executeQuery();
        
        while(set.next())
        {
            int pid = set.getInt("pid");
            String pTitle = set.getString("pTitle");
            String pContent = set.getString("pContent");
            String pCode = set.getString("pCode");
            String pPic = set.getString("pPic");
            Timestamp date = set.getTimestamp("pDate");
            int catId = set.getInt("catId");
            int userId = set.getInt("userId");
            
            Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
            
            list.add(post);
                    
            
            
            
        }
        
    }catch(Exception e)
    {
        e.printStackTrace();
    }

    return list;
}

public List<Post> getPostByCatID(int catId)
{
    List<Post> list = new ArrayList<>();
    //fetch all post by id
    try
    {
    
        PreparedStatement p = con.prepareStatement("select * from posts where catId = ?");
        p.setInt(1, catId);
        ResultSet set= p.executeQuery();
        
        while(set.next())
        {
            int pid = set.getInt("pid");
            String pTitle = set.getString("pTitle");
            String pContent = set.getString("pContent");
            String pCode = set.getString("pCode");
            String pPic = set.getString("pPic");
            Timestamp date = set.getTimestamp("pDate");
            int userId = set.getInt("userId");
            
            Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
            
            list.add(post);
                    
         
            
        }
        
    }catch(Exception e)
    {
        e.printStackTrace();
    }

    return list;
    
}


public Post getPostByPostId(int postId)
{
    
    Post post = null;

   String  q = "select * from posts where pid = ?" ;
   
   try{
   
       PreparedStatement p = con.prepareStatement(q);
       p.setInt(1, postId);
       
       ResultSet set = p.executeQuery();
       
       if(set.next())
       {
           int pid = set.getInt("pid");
            String pTitle = set.getString("pTitle");
            String pContent = set.getString("pContent");
            String pCode = set.getString("pCode");
            String pPic = set.getString("pPic");
            Timestamp date = set.getTimestamp("pDate");
            int userId = set.getInt("userId");
            int cid = set.getInt("catId");
            
            post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
            
       
          
           
       }
       
   }catch(Exception e)
   {
   
   
   }
    return post;
}

}

