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
	 * @功能 加载数据库驱动程序
	 */
	public void loadDrive() {
		try {
			Class.forName(className);
		} catch (ClassNotFoundException e) {
			System.out.println("加载数据库驱动程序失败！");
			e.printStackTrace();
		}
	}
	
	/**
	 * @功能 获取数据库连接
	 */
	public void getCon() {
		loadDrive();
		try {
			con = DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			System.out.println("连接数据库失败！");
			e.printStackTrace();
		}
	}
	
	/**
	 * @功能 获取Statement对象
	 */
	public void getStm() {
		getCon();
		try {
			stm = con.createStatement();
		} catch (Exception e) {
			System.out.println("获取Statement对象失败！");
			e.printStackTrace();
		}
	}

	/**
	 * @功能 查询数据表，获取结果集
	 */
	public void getRs(String sql) {
		getStm();
		try {
			rs = stm.executeQuery(sql);
		} catch (Exception e) {			
			System.out.println("查询数据库失败！");
			e.printStackTrace();
		}
	}
	
	/**
	 * @功能 查询数据表，获取投票选项
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
					System.out.println("封装tb_vote表中数据失败！");
					e.printStackTrace();
				} finally {
					closed();
				}
			}
		}
		return votelist;
	}

	/**
	 * @功能 查询数据表，获取指定IP最后一次投票的记录
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
					System.out.println("封装tb_temp表中数据失败！");
					e.printStackTrace();
				} finally {
					closed();
				}
			}
		}
		return tempSingle;
	}
	
	/**
	 * @功能 更新数据表
	 */
	public int update(String sql) {
		int i = -1;
		if (sql != null && !sql.equals("")) {
			getStm();
			try {
				i = stm.executeUpdate(sql);   //i是更新的记录数量
			} catch (Exception e) {
				System.out.println("更新数据库失败！");
				e.printStackTrace();
			} finally {
				closed();
			}
		}
		return i;
	}
	/**
	 * @功能 关闭数据库连接
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
			System.out.println("关闭数据库失败！");
			e.printStackTrace();
		}
	}
}
