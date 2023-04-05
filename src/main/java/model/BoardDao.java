package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BoardDao {
    public int maxnum() {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int maxnum=0;
    	try {
    		pstmt = con.prepareStatement("select num from board");
    		rs = pstmt.executeQuery();
    		while(rs.next()) {
    			if(maxnum<rs.getInt("num")) maxnum=rs.getInt("num");
    		}
    		return maxnum;
    	} catch(SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DBConnection.close(con, pstmt, rs);
    	}
    	return maxnum;
    }
    
    public boolean insert(Board board) {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	String sql = "insert into board (num, writer, pass, title, content, file1, boardid, regdate, readcnt, grp, grplevel, grpstep) values (?,?,?,?,?,?,?,?,?,?,?,?)";
    	try {
    		pstmt = con.prepareStatement(sql);
    		pstmt.setInt(1, board.getNum());
    		pstmt.setString(2, board.getWriter());
    		pstmt.setString(3, board.getPass());
    		pstmt.setString(4, board.getTitle());
    		pstmt.setString(5, board.getContent());
    		pstmt.setString(6, board.getFile1());
    		pstmt.setString(7, board.getBoardid());
    		pstmt.setDate(8, (Date)board.getRegdate());
    		pstmt.setInt(9, board.getReadcnt());
    		pstmt.setInt(10, board.getGrp());
    		pstmt.setInt(11, board.getGrplevel());
    		pstmt.setInt(12, board.getGrpstep());
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
