package pet.user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pet.hos.model.HosDTO;
import pet.rev.model.RevDTO;

public class UserDAO {

	// 싱글턴
	private static UserDAO instance = new UserDAO();

	private UserDAO() {
	}

	public static UserDAO getInstance() {
		return instance;
	}

	// 커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds = (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}

	// 회원가입 메서드
	public void userSignup(UserDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "insert into users values(?,?,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPw());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserMobile());
			pstmt.setString(5, dto.getUserNick());
			pstmt.setString(6, dto.getUserSiAddress());
			pstmt.setString(7, dto.getUserSelectAddress());
			pstmt.setString(8, dto.getUserDetailAddress());

			pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

	}
	

	
	//관리자, 회원 , 병원 로그인 체크 (로그인)

	public int IdPwcheck(String userId, String userPw, String login) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int res = -1;
		
		if (login.equals("0")) {
			if (userId.equals("admin")) {
				try {	//관리자
					conn = getConnection();
					String sql = "select userPw from users where userId=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userId);
					rs = pstmt.executeQuery();

					if (rs.next()) {
						String dbpw = rs.getString(1);
						if (dbpw.equals(userPw)) {res = 2;}
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
					if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
					if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
				}
				return res;
			} else if (login.equals("0")) {
				try {	//회원
					conn = getConnection();
					String sql = "select userPw from users where userId=? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userId);
					rs = pstmt.executeQuery();

					if (rs.next()) {
						String dbpw = rs.getString(1);
						if (dbpw.equals(userPw)) {res = 0;}
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
					if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
					if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
				}
				return res;
				
			}
		} else {
			try {	// 병원
				conn = getConnection();
				String sql = "select hosPw from HOSPITAL where hosId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userId);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					String dbpw = rs.getString(1);
					if (dbpw.equals(userPw)) {
						res = 1;
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
				if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
				if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
			}
		}
		return res;
	}
	
	
	

	// 회원 1명의 전체 정보 가져오기 (마이페이지)
	public UserDTO getUser(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDTO dto = null;

		try {
			conn = getConnection();
			String sql = "select * from users where userId=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new UserDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setUserPw(rs.getString("userPw"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserMobile(rs.getString("userMobile"));
				dto.setUserNick(rs.getString("userNick"));
				dto.setUserSiAddress(rs.getString("userSiAddress"));
				dto.setUserSelectAddress(rs.getString("userSelectAddress"));
				dto.setUserDetailAddress(rs.getString("userDetailAddress"));
				dto.setUserReg(rs.getTimestamp("userReg"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return dto;
	}

	// 정보 수정

	public int updateUser(UserDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = getConnection();
			String sql = "update users set userMobile=?, userNick=?, userSiAddress=?, userSelectAddress=?, userDetailAddress=? where userId=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserMobile());
			pstmt.setString(2, dto.getUserNick());
			pstmt.setString(3, dto.getUserSiAddress());
			pstmt.setString(4, dto.getUserSelectAddress());
			pstmt.setString(5, dto.getUserDetailAddress());
			pstmt.setString(6, dto.getUserId());

			result = pstmt.executeUpdate();
			System.out.println("dao result: " + result);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	// 비밀번호 수정

	public int pwupdateUser(String userId, String userPw, String userPwModify) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select userPw from users where userId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String dbpw = rs.getString(1);
				if (dbpw.equals(userPw)) {
					sql = "update users set userPw=? where userId=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userPwModify);
					pstmt.setString(2, userId);
					result = pstmt.executeUpdate();
				}
			} else {
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}

	
	
	// 회원탈퇴
	public int userDeletepw(String userId, String userPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();
			String sql = "select userPw from  users where userId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbpw = rs.getString("userPw");
				if (dbpw.equals(userPw)) {
					sql = "delete from users where userId=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userId);
					result = pstmt.executeUpdate();
					System.out.println("result 1 :" + result);
					if (result == 1) {
						sql = "delete from review where reviewId=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, userId);
						result = pstmt.executeUpdate();
						if(result > 0) {result = 1;
						}else {result = 1;}
					}else {result = -1;}
				} else {result = -1;}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;

	}

	// id 찾기 이름, 핸드폰번호

	public String findid(String userName, String userMobile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbid = null;
		try {
			conn = getConnection();
			String sql = "select userId from users where userName=? and userMobile=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userMobile);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbid = rs.getString(1);
			} else {
				dbid = null;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return dbid;
	}

	// 비밀번호 찾기

	public String findpw(String userId, String userName, String userMobile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpw = null;
		try {
			conn = getConnection();
			String sql = "select userPw from users where userid = ? and username=? and userMobile = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			pstmt.setString(2, userName);
			pstmt.setString(3, userMobile);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbpw = rs.getString(1);
			} else {
				dbpw = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dbpw;
	}

	// 유저 게시글 전체 불러오기
	public int getUserArticleCount(String userId) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select count(*) from review where reviewId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return count;
	}

	// 유저후기 글 가져오기 (시작번호,끝번호,정렬) 설정
	public List getArticles(int startRow, int endRow, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select B.*, r from " + "(select A.*, hospital.hosname, rownum r from "
					+ "(select reviewId, reviewno, reviewdate, reviewsubject, reviewjudge, reviewhosno from "
					+ "review where reviewid=? order by reviewdate desc) A, hospital where a.reviewhosno = hospital.hosno order by reviewdate desc) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				articleList = new ArrayList();
				do {
					RevDTO article = new RevDTO();
					article.setReviewNo(rs.getInt("reviewNo"));
					article.setReviewJudge(rs.getString("reviewJudge"));
					article.setReviewHosNo(rs.getString("reviewHosNo"));
					article.setReviewDate(rs.getTimestamp("reviewDate"));
					article.setReviewSubject(rs.getString("reviewSubject"));
					article.setReviewHosName(rs.getString("hosname"));
					article.setReviewId(rs.getString("reviewid"));
					articleList.add(article);

				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if (pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return articleList;
	}

	// 아이디 중복 체크

	public boolean confirmId(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;

		try {
			conn = getConnection();
			String sql = "select userId from users where userId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	// 아이디 중복 체크

	public boolean confirmNick(String userNick) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "select userNick from users where userNick=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userNick);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

// 관리자 회원정보 모든 리스트로 불러올 메서드 ---------------------------------------(21.07.14 쿼리문 수정)----------------
	public List getAdminUserList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List adminUserList = null;

		try {
			conn = getConnection();
			String sql = "select B.*, r " + "from (select A.*, rownum r "
					+ "from (select * from users order by userreg) A " + "order by userreg) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				adminUserList = new ArrayList();
				do {
					UserDTO dto = new UserDTO();
					dto.setUserId(rs.getString("userId"));
					dto.setUserPw(rs.getString("userPw"));
					dto.setUserName(rs.getString("userName"));
					dto.setUserMobile(rs.getString("userMobile"));
					dto.setUserNick(rs.getString("userNick"));
					dto.setUserSiAddress(rs.getString("userSiAddress"));
					dto.setUserSelectAddress(rs.getString("userSelectAddress"));
					dto.setUserDetailAddress(rs.getString("userDetailAddress"));
					dto.setUserReg(rs.getTimestamp("userReg"));

					adminUserList.add(dto);

				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return adminUserList;
	}
	// 관리자 회원정보 전체 수 가져오는 메서드 -----------------------------------------------------------------------(21.07.16 수정) 
	   public int getAdminUserSearchCount(String adminUserSearch) {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select count(*) from users where userid like '%" + adminUserSearch + "%'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
					System.out.println("회원정보 전체수 : " + count);
				}
			} catch (Exception e) {
				e.printStackTrace(); 	
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return count;
		}
		
		// 관리자 회원정보 모든 리스트로 불러올 메서드 -----------------------------------------------------------------(21.07.16 수정)
		public List getAdminUserSearchList(int start, int end, String adminUserSearch) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List adminUserList = null;
			
			try {
				conn = getConnection();
				String sql = "select B.*, r "
								+ "from (select A.*, rownum r "
									+ "from (select * from users where userid like '%" + adminUserSearch + "%' order by userreg) A "
								+ "order by userreg) B "
							+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					adminUserList = new ArrayList();
					do {
						UserDTO dto = new UserDTO();
						dto.setUserId(rs.getString("userId"));
						dto.setUserPw(rs.getString("userPw"));
						dto.setUserName(rs.getString("userName"));
						dto.setUserMobile(rs.getString("userMobile"));
						dto.setUserNick(rs.getString("userNick"));
						dto.setUserSiAddress(rs.getString("userSiAddress"));
						dto.setUserSelectAddress(rs.getString("userSelectAddress"));
						dto.setUserDetailAddress(rs.getString("userDetailAddress"));
						dto.setUserReg(rs.getTimestamp("userReg"));
						
						adminUserList.add(dto);
						
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return adminUserList;
		}
		
		// admin 마이페이지 에서 첫 화면 또는 검색하지 않았을때 보여질 페이지.-----------------------------------------------(21.07.16 추가)
		public int getAdminUserCount() { 
			int count = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select count(*) from users";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return count;
		}
		
		
		// admin 마이페이지에서 회원 정보 모두 보여질 페이지. ----------------------------------------------------------------(21.07.16 추가)
		public List getgetAdminUserList(int start, int end) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			List adminUserList = null; 
			
			try {
				conn = getConnection();
				String sql = "select B.*, r "
								+ "from (select A.*, rownum r "
									+ "from (select * from users order by userreg desc) A "
								+ "order by userreg desc) B "
							+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					adminUserList = new ArrayList();
					do {
						UserDTO dto = new UserDTO();
						dto.setUserId(rs.getString("userId"));
						dto.setUserPw(rs.getString("userPw"));
						dto.setUserName(rs.getString("userName"));
						dto.setUserMobile(rs.getString("userMobile"));
						dto.setUserNick(rs.getString("userNick"));
						dto.setUserSiAddress(rs.getString("userSiAddress"));
						dto.setUserSelectAddress(rs.getString("userSelectAddress"));
						dto.setUserDetailAddress(rs.getString("userDetailAddress"));
						dto.setUserReg(rs.getTimestamp("userReg"));
						
						adminUserList.add(dto);
						
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return adminUserList;
		}
		
		// admin 마이페이지에서 회원 검색 또는 회원ID 클릭시 회원 마이페이지처럼 보이게 하는 메서드 ------------------------------------(21.07.16 추가)
		public UserDTO getAdminUser(String adminUserId) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			UserDTO dto = null;
			
			try {
				conn = getConnection();
				String sql = "select * from users where userId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, adminUserId);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					dto = new UserDTO();
					
					dto.setUserId(rs.getString("userId"));
					dto.setUserPw(rs.getString("userPw"));
					dto.setUserName(rs.getString("userName"));
					dto.setUserMobile(rs.getString("userMobile"));
					dto.setUserNick(rs.getString("userNick"));
					dto.setUserSiAddress(rs.getString("userSiAddress"));
					dto.setUserSelectAddress(rs.getString("userSelectAddress"));
					dto.setUserDetailAddress(rs.getString("userDetailAddress"));		
					dto.setUserReg(rs.getTimestamp("userReg"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return dto;
		}
	
	

}
