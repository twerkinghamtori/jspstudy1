package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//db와 관련된 함수들의 모임
public class MemberDao {
     public boolean insert(Member mem) {
    	 Connection con = DBConnection.getConnection();
    	 PreparedStatement pstmt = null;
    	 String sql = "insert into member (id, pass, name, gender, tel, email, picture) values(?,?,?,?,?,?,?)";
    	 try {
    		 pstmt = con.prepareStatement(sql);
    		 pstmt.setString(1, mem.getId());
    		 pstmt.setString(2, mem.getPass());
    		 pstmt.setString(3, mem.getName());
    		 pstmt.setInt(4, mem.getGender());
    		 pstmt.setString(5, mem.getTel());
    		 pstmt.setString(6, mem.getEmail());
    		 pstmt.setString(7, mem.getPicture());
    		 if(pstmt.executeUpdate() > 0) return true; //executeUpdate() 뭐더라? row count?
    		 else return false;    		 
    	 } catch(SQLException e) {
    		 e.printStackTrace();
    	 } finally {
    		 DBConnection.close(con, pstmt, null);
    	 }	
    	 return false;
     }
     
     public Member selectOne(String id) {
    	 Connection con = DBConnection.getConnection();
    	 String sql = "select * from member where id=?";
    	 PreparedStatement pstmt=null;
    	 ResultSet rs = null;
    	 try {
    		 pstmt = con.prepareStatement(sql);
    		 pstmt.setString(1, id);
    		 rs = pstmt.executeQuery();
    		 //rs.next() : 조회될게 있으면 true
    		 if(rs.next()) {
    			 Member mem = new Member();
    			 mem.setId(rs.getString("id"));
    			 mem.setPass(rs.getString("pass"));
    			 mem.setName(rs.getString("name"));
    			 mem.setGender(rs.getInt("gender"));
    			 mem.setTel(rs.getString("tel"));
    			 mem.setEmail(rs.getString("email"));
    			 mem.setPicture(rs.getString("picture"));
    			 return mem;
    		 }   		 
    	 } catch(SQLException e) {
    		 e.printStackTrace();
    	 } finally {
    		 DBConnection.close(con, pstmt, rs);
    	 }
    	 return null;
     }
     
     
}
