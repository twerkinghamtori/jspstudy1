package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {
    public int maxnum() {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int maxnum=0;
    	try {
    		pstmt = con.prepareStatement("select num from board"); //"select ifnull(max(num),0) maxnum from board"
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
    	String sql = "insert into board (num, writer, pass, title, content, file1, boardid, regdate, readcnt, grp, grplevel, grpstep) values (?,?,?,?,?,?,?,now(),0,?,?,?)";
    	try {
    		pstmt = con.prepareStatement(sql);
    		pstmt.setInt(1, board.getNum());
    		pstmt.setString(2, board.getWriter());
    		pstmt.setString(3, board.getPass());
    		pstmt.setString(4, board.getTitle());
    		pstmt.setString(5, board.getContent());
    		pstmt.setString(6, board.getFile1());
    		pstmt.setString(7, board.getBoardid());
    		pstmt.setInt(8, board.getGrp());
    		pstmt.setInt(9, board.getGrplevel());
    		pstmt.setInt(10, board.getGrpstep());
    		if(pstmt.executeUpdate()>0) return true;
    		else return false;
    	} catch(SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DBConnection.close(con, pstmt, null);
    	}
    	return false;
    }
    
    public int boardCount(String boardid) {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	try {
    		pstmt = con.prepareStatement("select count(*) from board where boardid=?");
    		pstmt.setString(1, boardid);
    		rs=pstmt.executeQuery();
    		if(rs.next()) return rs.getInt(1);
    	} catch(SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DBConnection.close(con, pstmt, null);
    	}
    	return 0;
    }
    
    public List<Board> list(String boardid, int pageNum, int limit) {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	List<Board> list = new ArrayList<Board>();
    	// limit 시작레코드번호, 개수 : 오라클에서는 사용 불가. substring 같은 거구만..ㅎㅅㅎ
    	String sql = "select * from board where boardid=? order by grp desc, grpstep asc limit ?,?";
    	try {
    		pstmt=con.prepareStatement(sql);
    		pstmt.setString(1, boardid);
    		pstmt.setInt(2, (pageNum-1)*limit);
    		pstmt.setInt(3, limit);
    		rs = pstmt.executeQuery();
    		while(rs.next()) {
    			Board b = new Board();
    			b.setNum(rs.getInt("num"));
    			b.setWriter(rs.getString("writer"));
    			b.setPass(rs.getString("pass"));
    			b.setTitle(rs.getString("title"));
    			b.setContent(rs.getString("content"));
    			b.setFile1(rs.getString("file1"));
    			b.setBoardid(rs.getString("boardid"));
    			b.setRegdate(rs.getTimestamp("regdate"));
    			b.setReadcnt(rs.getInt("readcnt"));
    			b.setGrp(rs.getInt("grp"));
    			b.setGrplevel(rs.getInt("grplevel"));
    			b.setGrpstep(rs.getInt("grpstep"));  			
    			list.add(b);
    		}
    		return list;    		
    	} catch(SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DBConnection.close(con, pstmt, null);
    	}
    	return null;
    }
    
    public Board selectOne(int num) {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	String sql = "select * from board where num=?";
    	try {
    		pstmt= con.prepareStatement(sql);
    		pstmt.setInt(1, num);
    		rs = pstmt.executeQuery();    		
    		if(rs.next()) {    		
    			Board b = new Board();
    			b.setNum(rs.getInt("num"));
    			b.setWriter(rs.getString("writer"));
    			b.setPass(rs.getString("pass"));
    			b.setTitle(rs.getString("title"));
    			b.setContent(rs.getString("content"));
    			b.setFile1(rs.getString("file1"));
    			b.setBoardid(rs.getString("boardid"));
    			b.setRegdate(rs.getTimestamp("regdate"));
    			b.setReadcnt(rs.getInt("readcnt"));
    			b.setGrp(rs.getInt("grp"));
    			b.setGrplevel(rs.getInt("grplevel"));
    			b.setGrpstep(rs.getInt("grpstep")); 
    			return b;
    		}    		
    	} catch(SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DBConnection.close(con, pstmt, rs);
    	}
    	return null;
    } 
    
    public void readcntAdd(int num) {
    	Connection con = DBConnection.getConnection();
    	PreparedStatement pstmt = null;
    	String sql = "update board set readcnt=readcnt+1 where num=?" ;
    	try {
    		pstmt = con.prepareStatement(sql);
    		pstmt.setInt(1, num);
    		pstmt.executeQuery();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DBConnection.close(con, pstmt, null);
    	}
    }
}
