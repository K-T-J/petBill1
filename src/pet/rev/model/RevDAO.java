package pet.rev.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pet.hos.model.HosDTO;
import pet.rev.model.RevDAO;
import pet.rev.model.RevDTO;



public class RevDAO {
	
	private static RevDAO instance = new RevDAO();
	private RevDAO() {}
	public static RevDAO getInstance() {return instance;}
	
	

	   private Connection getConnection() throws Exception {
	      Context ctx = new InitialContext();
	      Context env = (Context)ctx.lookup("java:comp/env");
	      DataSource ds = (DataSource)env.lookup("jdbc/orcl");
	      return ds.getConnection();
	   }
	   
	   // 게시글 전체 가져오기 
	   public int getArticleCount() {
	      int count = 0; 
	      Connection conn = null; 
	      PreparedStatement pstmt = null;
	      ResultSet rs = null; 
	      
	      try {
	         conn = getConnection(); 
	         String sql = "select count(*) from review";
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery(); 
	         if(rs.next()) {
	            count = rs.getInt(1);  
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
	         if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
	         if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	      }
	      return count;
	   }

	   
	   
	   
	   // 글 저장
	   public void RevinsertArticle(RevDTO article) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		    
		   try {
			   conn = getConnection();
			   String sql = "insert into review(reviewNo,reviewId,reviewSubject,reviewPetKind,reviewGender,reviewAge,reviewWeight,reviewPetType,reviewPhoto,reviewArticle,reviewPrice,reviewContent,reviewJudge,reviewHosNo,reviewGu,reviewDate) "
					   +"values(review_seq.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, article.getReviewId());
			   pstmt.setString(2, article.getReviewSubject()); 
			   pstmt.setString(3, article.getReviewPetKind());
			   pstmt.setString(4, article.getReviewGender());
			   pstmt.setString(5, article.getReviewAge());
			   pstmt.setString(6, article.getReviewWeight());
			   pstmt.setString(7, article.getReviewPetType());
			   pstmt.setString(8, article.getReviewPhoto());
			   pstmt.setString(9, article.getReviewArticle());
			   pstmt.setString(10, article.getReviewPrice());
			   pstmt.setString(11, article.getReviewContent());
			   pstmt.setString(12, article.getReviewJudge());
			   pstmt.setString(13, article.getReviewHosNo());
			   pstmt.setString(14, article.getReviewGu());
			   pstmt.executeUpdate();
			  
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			   
		   }
	   }
	   
	   
	   
	   
	   // 리뷰 삭제  -- reviewNo랑 HosNo랑 같은지 확인해함
	   public int deleteReview(String userId, String userPw, int reviewNo) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   int result = 0;
		   try {
			   conn = getConnection();
			   String sql = "select userPw from users where userId=?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, userId);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   String dbPw = rs.getString("userPw");
				   if(dbPw.equals(userPw)){
				   sql = "delete from review where reviewId=? and reviewNo=?";
				   pstmt = conn.prepareStatement(sql);
				   pstmt.setString(1, userId);
				   pstmt.setInt(2, reviewNo);
				   result = pstmt.executeUpdate();
				   System.out.println("result 1 : " + result);
				   }else {
					   result = -1;
				   }
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   return result;
	   }
			   
	   
	   // 관리자 리뷰 삭제
	   public int AdminDelete(int reviewNo) {
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   int result = 0;
		   
		   try {
			   conn = getConnection();
			   String sql = "delete from review where reviewNo=?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setInt(1, reviewNo); 
			   result = pstmt.executeUpdate();
			   if(result == 1) {
				   result = 1;
			   }else {
				   result = -1; 
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   return result;
	   }
	   
	   

	   
	   
	   
	   
	   
	   
	   
	   
  
	   // 고유번호로 게시글 가져오기
	   public RevDTO getReview(int reviewNo, String reviewHosNo) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			RevDTO rev = null;
			 
			try {
				conn = getConnection(); 
				String sql = "select * from review where reviewNo = ? and reviewHosNo = ?";
				pstmt = conn.prepareStatement(sql); 
				pstmt.setInt(1, reviewNo);    
				pstmt.setString(2, reviewHosNo);   
				rs = pstmt.executeQuery();
				if(rs.next()) {
					rev = new RevDTO();
			               rev.setReviewNo(rs.getInt("reviewNo"));
			               rev.setReviewId(rs.getString("reviewId"));
			               rev.setReviewSubject(rs.getString("reviewSubject"));			               
			               rev.setReviewPetKind(rs.getString("reviewPetKind"));
			               rev.setReviewGender(rs.getString("reviewGender"));
			               rev.setReviewAge(rs.getString("reviewAge"));
			               rev.setReviewWeight(rs.getString("reviewWeight"));
			               rev.setReviewPetType(rs.getString("reviewPetType"));
			               rev.setReviewPhoto(rs.getString("reviewPhoto"));
			               rev.setReviewArticle(rs.getString("reviewArticle"));
			               rev.setReviewPrice(rs.getString("reviewPrice"));
			               rev.setReviewContent(rs.getString("reviewContent"));
			               rev.setReviewJudge(rs.getString("reviewJudge"));
			               rev.setReviewHosNo(rs.getString("reviewHosNo"));
			               rev.setReviewGu(rs.getString("reviewGu"));
			               rev.setReviewRef(rs.getString("reviewRef"));
			               rev.setReviewDate(rs.getTimestamp("reviewDate"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			
			}
			return rev;
		}
	   
	   
	   
	   	// 리뷰 수정 처리
		public int ReviewUpdate(RevDTO dto,String userId) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			int result = 0;
			System.out.println("123 :" + dto.getReviewNo());
			System.out.println("456 :" + dto.getReviewId());
			try {
				conn = getConnection();
				
				// 고유넘
				String sql = "select * from review where reviewNo=? and reviewId=?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getReviewNo());
				pstmt.setString(2, dto.getReviewId());
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					String dbno = rs.getString(1);
					System.out.println("dbno : " + dbno);
					if(dbno != null) { // rs 값이 null이 아닐 때
						if(dto.getReviewPhoto() == null) {
							System.out.println("pro 1");
						sql = "update review set "
								+ "reviewSubject=?, reviewPetKind=?, reviewGender=?, reviewAge=?, reviewWeight=?, reviewPetType=?, "
								+ "reviewArticle=?, reviewPrice=?, reviewContent=?, reviewJudge=? where reviewNo=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, dto.getReviewSubject());
							pstmt.setString(2, dto.getReviewPetKind());
							pstmt.setString(3, dto.getReviewGender());
							pstmt.setString(4, dto.getReviewAge());
							pstmt.setString(5, dto.getReviewWeight());
							pstmt.setString(6, dto.getReviewPetType());
							pstmt.setString(7, dto.getReviewArticle());
							pstmt.setString(8, dto.getReviewPrice());
							pstmt.setString(9, dto.getReviewContent());
							pstmt.setString(10, dto.getReviewJudge());
							pstmt.setInt(11, dto.getReviewNo());
							result = pstmt.executeUpdate(); // 하나의 레코드 업데이트 되면 1리턴 
							}else if(dto.getReviewPhoto() != null){
								System.out.println("pro 2");
							sql = "update review set "
								+ "reviewSubject=?, reviewPetKind=?, reviewGender=?, reviewAge=?, reviewWeight=?, reviewPetType=?, "
								+ "reviewPhoto=?, reviewArticle=?, reviewPrice=?, reviewContent=?, reviewJudge=? where reviewNo=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, dto.getReviewSubject());
							pstmt.setString(2, dto.getReviewPetKind());
							pstmt.setString(3, dto.getReviewGender());
							pstmt.setString(4, dto.getReviewAge());
							pstmt.setString(5, dto.getReviewWeight());
							pstmt.setString(6, dto.getReviewPetType());
							pstmt.setString(7, dto.getReviewPhoto());
							pstmt.setString(8, dto.getReviewArticle());
							pstmt.setString(9, dto.getReviewPrice());
							pstmt.setString(10, dto.getReviewContent());
							pstmt.setString(11, dto.getReviewJudge());
							pstmt.setInt(12, dto.getReviewNo());
							result = pstmt.executeUpdate(); // 하나의 레코드 업데이트 되면 1리턴 
						}else {
							result = -1;
						}
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
			return result;
		}
		
		
		
		
		// 병원 답글
		public void HosRef(RevDTO article) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				String sql = "update review set reviewRef=? where reviewNo=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, article.getReviewRef());
				pstmt.setInt(2, article.getReviewNo());
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			}
		}
		
		
		
		
		
		   // 해당 리뷰병원번호 리뷰갯수 가져오기 
		   public int getReviewArticleCount(String reviewHosNo){
			   int count = 0; 
			   Connection conn = null; 
			   PreparedStatement pstmt = null;
			   ResultSet rs = null; 
			   
			   try {
				   conn = getConnection(); 
				   String sql = "select count(*) from review where reviewHosNo=?";
				   pstmt = conn.prepareStatement(sql);
				   pstmt.setString(1, reviewHosNo);
				   rs = pstmt.executeQuery(); 
				   if(rs.next()) {
					   count = rs.getInt(1);  
				   }
			   }catch(Exception e) {
				   e.printStackTrace();
			   }finally {
				   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
				   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			   }
			   return count;
		   }
		   
		   
		   
		   
		   // 리뷰병원번호로 게시글 가져오기
		   public RevDTO getContactReview(String reviewHosNo) {
			   Connection conn = null;
			   PreparedStatement pstmt = null;
			   ResultSet rs = null;
			   RevDTO rev = null;
			   
			   try {
				   conn = getConnection();
				   String sql = "select * from review where reviewHosNo = ?";
				   pstmt = conn.prepareStatement(sql);
				   pstmt.setString(1, reviewHosNo);   
				   rs = pstmt.executeQuery();
				   if(rs.next()) {
					   rev = new RevDTO();
					   rev.setReviewNo(rs.getInt("reviewNo"));
					   rev.setReviewId(rs.getString("reviewId"));
					   rev.setReviewSubject(rs.getString("reviewSubject"));			               
					   rev.setReviewPetKind(rs.getString("reviewPetKind"));
					   rev.setReviewGender(rs.getString("reviewGender"));
					   rev.setReviewAge(rs.getString("reviewAge"));
					   rev.setReviewWeight(rs.getString("reviewWeight"));
					   rev.setReviewPetType(rs.getString("reviewPetType"));
					   rev.setReviewPhoto(rs.getString("reviewPhoto"));
					   rev.setReviewArticle(rs.getString("reviewArticle"));
					   rev.setReviewPrice(rs.getString("reviewPrice"));
					   rev.setReviewContent(rs.getString("reviewContent"));
					   rev.setReviewJudge(rs.getString("reviewJudge"));
					   rev.setReviewHosNo(rs.getString("reviewHosNo"));
					   rev.setReviewGu(rs.getString("reviewGu"));
					   rev.setReviewRef(rs.getString("reviewRef"));
					   rev.setReviewDate(rs.getTimestamp("reviewDate"));
				   }
			   }catch(Exception e) {
				   e.printStackTrace();
			   }finally {
				   if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				   if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				   if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				   
			   }
			   return rev;
		   }
		   
		
		   //시작번호 끝번호 설정(비로그인시)
		   public List getArticlesAll(int startRow, int endRow, String reviewHosNo) {
			   Connection conn = null;
			   PreparedStatement pstmt = null;
			   ResultSet rs = null;
			   List articleList = null;
			   
			   try {
				   conn = getConnection();
				   String sql = "select B.*, r "+ 
						   			"from (select A.*, rownum r "+
						   				"from (select * from review where reviewHosNo=? order by reviewno desc) A " + 
						   			"order by reviewno desc) B "+ 
						   		"where r >= ? and r <= ?";
				   pstmt = conn.prepareStatement(sql);
				   pstmt.setString(1, reviewHosNo);
				   pstmt.setInt(2, startRow);
				   pstmt.setInt(3, endRow);
				   
				   rs = pstmt.executeQuery();
				   if(rs.next()) {
					   articleList = new ArrayList();
					   do {
						   RevDTO article = new RevDTO();
						   article.setReviewNo(rs.getInt("reviewNo"));
			               article.setReviewId(rs.getString("reviewId"));
			               article.setReviewPetKind(rs.getString("reviewPetKind"));
			               article.setReviewGender(rs.getString("reviewGender"));
			               article.setReviewAge(rs.getString("reviewAge"));
			               article.setReviewWeight(rs.getString("reviewWeight"));
			               article.setReviewPetType(rs.getString("reviewPetType"));
			               article.setReviewArticle(rs.getString("reviewArticle"));
			               article.setReviewPrice(rs.getString("reviewPrice"));
			               article.setReviewContent(rs.getString("reviewContent"));
			               article.setReviewJudge(rs.getString("reviewJudge"));
			               article.setReviewPhoto(rs.getString("reviewPhoto"));
			               article.setReviewHosNo(rs.getString("reviewHosNo"));
			               article.setReviewGu(rs.getString("reviewGu"));
			               article.setReviewRef(rs.getString("reviewRef"));
			               article.setReviewDate(rs.getTimestamp("reviewDate"));
			               article.setReviewSubject(rs.getString("reviewSubject")); 
			               
			               articleList.add(article);
					   }while(rs.next());
				   }
				   
			   }catch(Exception e) {
				   e.printStackTrace();
			   }finally {
				   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
				   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			       if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
			   }
			   
			   return articleList;
		   }
		   
		// 사용자 진료비 평균 꺼내오기
					public List getAvg(String reviewHosNo) {
						Connection conn = null;
						PreparedStatement pstmt = null;
						ResultSet rs = null;
						List revList = null;
						
						try {
							conn = getConnection(); 
							//평균값 들고오기 
							String sql = "select reviewArticle, "
										+"ceil(ROUND(avg(reviewPrice), -3)) from review where reviewHosNo=? group by reviewArticle";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, reviewHosNo);
							
							rs = pstmt.executeQuery();
							if(rs.next()) { // 결과를 null인지 먼저 체크해보고 
								revList = new ArrayList(); // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
								do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
									RevDTO revAvg = new RevDTO();
									revAvg.setReviewArticle(rs.getString(1));
									revAvg.setReviewPrice(rs.getString(2));
									 // 처음거는 무조건 실행해서 리스트에 추가하고
									revList.add(revAvg);
									
								}while(rs.next()); // 반복해라 
								System.out.println("사용자리뷰평균뽑혔당 = "+ revList);
							}//if 중괄호 끝 
							
						}catch(Exception e) {
							e.printStackTrace();
						}finally {
							if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
							if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
							if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
						}
						System.out.println("진료비꺼냄");
						return revList;
						
					}
		   
		
}  
 

	
	   

