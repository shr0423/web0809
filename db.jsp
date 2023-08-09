<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>

<%
	/*javase의 기술을 적용할 수 있다.
		String(O)
		Swing(X)
		ArrayList(O)
	*/
	
	//웹브라우저로부터 데이터를 전송받아서 회원정보에 넣기

	//전송 파라미터( 변수) 값 받기
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String phone=request.getParameter("phone");


	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="java";
	String pass="1234";
	Connection con=null;
	PreparedStatement pstmt=null;

	//드라이버
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		out.print("드라이버가 로드성공");
		con=DriverManager.getConnection(url, user, pass);
		if(con!=null){
			out.println("접속성공");
			String sql="insert into member(member_idx, id, name, phone)";
			sql+=" values(seq_member.nextval,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,name);
			pstmt.setString(3,phone);
			
			int result=pstmt.executeUpdate();//DML실행
			
			if(result>0){
				out.print("등록성공");
			}
		}
	}catch(ClassNotFoundException e){
		out.print("드라이버가 없습니다.");
	}finally{
		if(pstmt!=null){
			try{
				pstmt.close();}catch(SQLException e){
			}
		}
			if(con!=null){
			}try{con.close();}
			catch(SQLException e){
			
			
		}
	}
%>