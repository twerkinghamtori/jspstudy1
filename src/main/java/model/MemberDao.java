package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
     
     public boolean update(Member mem) {
    	 Connection con = DBConnection.getConnection();
    	 PreparedStatement pstmt = null;
    	 ResultSet rs = null;
    	 String sql = "update member set name=?,gender=?,tel=?,email=?,picture=? where id=?";
    	 try {
    		 pstmt = con.prepareStatement(sql);
    		 pstmt.setString(1, mem.getName());
    		 pstmt.setInt(2, mem.getGender());
    		 pstmt.setString(3, mem.getTel());
    		 pstmt.setString(4, mem.getEmail());
    		 pstmt.setString(5, mem.getPicture());
    		 pstmt.setString(6, mem.getId());
    		 if(pstmt.executeUpdate()>0) return true;
    		 else return false;
    	 } catch(SQLException e) {
    		 e.printStackTrace();
    	 } finally {
    		 DBConnection.close(con, pstmt, null);
    	 }
    	 return false;
     }
     
     public List<Member> list() {
    	 Connection con = DBConnection.getConnection();
    	 PreparedStatement pstmt=null;
    	 ResultSet rs = null;
    	 List<Member> list = new ArrayList<>();
    	 try {
    		 pstmt = con.prepareStatement("select * from member");
    		 rs = pstmt.executeQuery();
    		 while(rs.next()) {
    			 Member m = new Member(); //계속 같은 이름으로 member 객체 생성하는거 아닌가? duplicate name error 안뜸?
    			 m.setId(rs.getString("id"));
    			 m.setPass(rs.getString("pass"));
    			 m.setName(rs.getString("name"));
    			 m.setGender(rs.getInt("gender"));
    			 m.setTel(rs.getString("tel"));
    			 m.setEmail(rs.getString("email"));
    			 m.setPicture(rs.getString("picture")); 
    			 list.add(m);
    		 }
    		 return list;    		 
    	 } catch(SQLException e) {
    		 e.printStackTrace();
    	 } finally {
    		 DBConnection.close(con, pstmt, rs);
    	 }
    	 return null;
     }
     
     public boolean delete(String id) {
    	 Connection con = DBConnection.getConnection();
    	 PreparedStatement pstmt = null;
    	 String sql = "delete from member where id=?";
    	 try {
    		 pstmt = con.prepareStatement(sql);
    		 pstmt.setString(1, id);
    		 if(pstmt.executeUpdate()>0) return true;
    		 else return false;
    	 } catch(SQLException e) {
    		 e.printStackTrace();
    	 } finally {
    		 DBConnection.close(con, pstmt, null);
    	 }
    	 return false;
     }
}
