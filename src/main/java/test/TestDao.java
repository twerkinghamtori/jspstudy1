package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.DBConnection;

public class TestDao {
      public boolean insert(Book book) {
    	  Connection con = DBConnection.getConnection();
    	  PreparedStatement pstmt = null;
    	  ResultSet rs = null;
    	  String sql = "insert into diary (writer,title,content) values(?,?,?)";
    	  try {
    		  pstmt = con.prepareStatement(sql);
    		  pstmt.setString(1,book.getWriter());
    		  pstmt.setString(2,book.getTitle());
    		  pstmt.setString(3,book.getContent());
    		  if(pstmt.executeUpdate()>0) return true;
    		  else return false;
    	  } catch(SQLException e) {
    		  e.printStackTrace();
    	  } finally {
    		  DBConnection.close(con, pstmt, rs);
    	  }
    	  return false;
      }
      
      public Book selectAll() {
    	  Connection con = DBConnection.getConnection();
    	  PreparedStatement pstmt=null;
    	  ResultSet rs=null;
    	  String sql = "select * from diary";
    	  
    	  try {
    		  pstmt = con.prepareStatement(sql);
    		  rs = pstmt.executeQuery();
    		  if(rs.next()) {
    			  Book book = new Book();
    			  book.setWriter(rs.getString("writer"));
    			  book.setTitle(rs.getString("title"));
    			  book.setContent(rs.getString("content"));
    			  return book;
    		  }    		  
    	  } catch(SQLException e) {
    		  e.printStackTrace();
    	  } finally {
    		  DBConnection.close(con, pstmt, rs);
    	  }
    	  return null;
      }
}
