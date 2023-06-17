/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.techblog.dao;
import java.sql.*;

/**
 *
 * @author asmita.sethiya
 */
public class LikeDao {
    
    Connection con;

    public LikeDao(Connection con) 
    {
        this.con = con;
    }
    
    
    public boolean insertLike(int pid, int uid)
    {
        boolean f  = false;
        
        try{
        
            String query = "insert into likes(pid, uid) values (?,?)";
            PreparedStatement sp = con.prepareStatement(query);
            
            //values set
            sp.setInt(1,pid);
            sp.setInt(2,uid);
            sp.executeUpdate();
            
            f = true;
            
        
        }catch(Exception e)
        {
            e.printStackTrace();
        }
    return f;
    }

    public int countLikePost(int pid)
    {
    
        int count = 0;
        

        try{
        
            String q = "select count(*) from likes where pid = ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, pid);
            ResultSet set =  ps.executeQuery();
            
            
            if(set.next())
            {
                count = set.getInt("count(*)");
            }
            
            
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return count;
    }    
    
    
    public boolean isLikedByUser(int pid, int uid)
    {
        boolean f = false;
        
        
        try{
        
            PreparedStatement ps = this.con.prepareStatement("select * from likes where pid = ? and uid = ?");
            ps.setInt(1, pid);
            ps.setInt(2, uid);
            ResultSet set = ps.executeQuery();
            
            if(set.next())
            {
                f = true;
            }
            
        }catch(Exception e){
        
            e.printStackTrace();

        }
        
        return f;
    
    }
    
    
    public boolean deleteLike(int pid, int uid)        
    {
        boolean f = false;
        
        try{
            
            PreparedStatement p  = this.con.prepareStatement("delete from likes where pid = ? and uid = ?");
            p.setInt(1, pid);
            p.setInt(2, uid);
            p.executeUpdate();
            
            f = true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }

        return f;
    
    }
    
}



