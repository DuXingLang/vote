package toolbean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import valuebean.TempSingle;
import valuebean.VoteSingle;

public class DB {
	private String className;

	private String url;

	private String username;

	private String password;

	private Connection con;

	private Statement stm;

	private ResultSet rs;
	
	public ResultSet Rs = rs;

	public DB() {
		//className = "sun.jdbc.odbc.JdbcOdbcDriver";
		//url = "jdbc:odbc:vote";
		className= "com.mysql.jdbc.Driver";
		url = "jdbc:mysql://localhost/vote?useUnicode=true&characterEncoding=utf-8";
		username = "root";
		password = "root";
	}

	/**
	 * @���� �������ݿ���������
	 */
	public void loadDrive() {
		try {
			Class.forName(className);
		} catch (ClassNotFoundException e) {
			System.out.println("�������ݿ���������ʧ�ܣ�");
			e.printStackTrace();
		}
	}
	
	/**
	 * @���� ��ȡ���ݿ�����
	 */
	public void getCon() {
		loadDrive();
		try {
			con = DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			System.out.println("�������ݿ�ʧ�ܣ�");
			e.printStackTrace();
		}
	}
	
	/**
	 * @���� ��ȡStatement����
	 */
	public void getStm() {
		getCon();
		try {
			stm = con.createStatement();
		} catch (Exception e) {
			System.out.println("��ȡStatement����ʧ�ܣ�");
			e.printStackTrace();
		}
	}

	/**
	 * @���� ��ѯ���ݱ���ȡ�����
	 */
	public void getRs(String sql) {
		getStm();
		try {
			rs = stm.executeQuery(sql);
		} catch (Exception e) {			
			System.out.println("��ѯ���ݿ�ʧ�ܣ�");
			e.printStackTrace();
		}
	}
	
	/**
	 * @���� ��ѯ���ݱ���ȡͶƱѡ��
	 */
	public List selectVote(String sql) {
		List votelist = null;
		if (sql != null && !sql.equals("")) {
			getRs(sql);
			if (rs != null) {
				votelist = new ArrayList();
				try {
					while (rs.next()) {
						VoteSingle voteSingle = new VoteSingle();
						voteSingle.setId(MyTools.intToStr(rs.getInt(1)));
						voteSingle.setTitle(rs.getString(2));
						voteSingle.setNum(MyTools.intToStr(rs.getInt(3)));
						voteSingle.setOrder(MyTools.intToStr(rs.getInt(4)));
						votelist.add(voteSingle);
					}
				} catch (Exception e) {
					System.out.println("��װtb_vote��������ʧ�ܣ�");
					e.printStackTrace();
				} finally {
					closed();
				}
			}
		}
		return votelist;
	}

	/**
	 * @���� ��ѯ���ݱ���ȡָ��IP���һ��ͶƱ�ļ�¼
	 */
	public TempSingle selectTemp(String sql) {
		TempSingle tempSingle = null;
		if (sql != null && !sql.equals("")) {
			getRs(sql);
			if (rs != null) {
				try {
					while (rs.next()) {
						tempSingle = new TempSingle();
						tempSingle.setId(MyTools.intToStr(rs.getInt(1)));
						tempSingle.setVoteIp(rs.getString(2));
						tempSingle.setVoteMSEL(rs.getLong(3));
						tempSingle.setVoteTime(rs.getString(4));
					}
				} catch (Exception e) {
					System.out.println("��װtb_temp��������ʧ�ܣ�");
					e.printStackTrace();
				} finally {
					closed();
				}
			}
		}
		return tempSingle;
	}
	
	/**
	 * @���� �������ݱ�
	 */
	public int update(String sql) {
		int i = -1;
		if (sql != null && !sql.equals("")) {
			getStm();
			try {
				i = stm.executeUpdate(sql);   //i�Ǹ��µļ�¼����
			} catch (Exception e) {
				System.out.println("�������ݿ�ʧ�ܣ�");
				e.printStackTrace();
			} finally {
				closed();
			}
		}
		return i;
	}
	/**
	 * @���� �ر����ݿ�����
	 */
	public void closed() {
		try {
			if (rs != null)
				rs.close();
			if (stm != null)
				stm.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			System.out.println("�ر����ݿ�ʧ�ܣ�");
			e.printStackTrace();
		}
	}
}
